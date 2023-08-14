//
//  Renderer.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 07.08.2023.
//

import Foundation
import MetalKit

protocol Renderer: NSObjectProtocol, MTKViewDelegate {
    var device: MTLDevice! { get }
    func setupMetal()
    func renderQuadrangles(_ quadrangles: [Quadrangle])
}

class RendererImpl: NSObject, Renderer {
    
    var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    private var pipelineState: MTLRenderPipelineState!
    private var vertexBuffer: MTLBuffer!
    private var vertexCount: Int = 0
    private let vertexFactory: VertexFactory = VertexFactoryImpl()
    
    override init() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
    }
    
    func setupMetal() {
        let library = device.makeDefaultLibrary()
        
        let pipelineDescriptor = configurePipelineDescriptor(library: library)

        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        
        let initialQuadrangle = Quadrangle(
            SIMD2<Float>( 1, -1),
            SIMD2<Float>(-1, -1),
            SIMD2<Float>(-1,  1),
            SIMD2<Float>( 1,  1),
            color: SIMD4<Float>(1, 1, 1, 1)
        )
        
        renderQuadrangles([initialQuadrangle])
    }
    
    private func configurePipelineDescriptor(library: MTLLibrary?) -> MTLRenderPipelineDescriptor {
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        pipelineDescriptor.vertexDescriptor = configureVertexDecriptor()
        
        return pipelineDescriptor
    }
    
    private func configureVertexDecriptor() -> MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        
        vertexDescriptor.attributes[0].format = .float2
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0

        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        vertexDescriptor.layouts[0].stepFunction = .perVertex
        
        return vertexDescriptor
    }
    
    func renderQuadrangles(_ quadrangles: [Quadrangle]) {
        let vertices: [Vertex] = quadrangles.map({ vertexFactory.makeQuadrangle($0) }).reduce([], +)
        updateVertexBuffer(withVertices: vertices)
    }
    
    private func updateVertexBuffer(withVertices vertices: [Vertex]) {
        vertexCount = vertices.count
        vertexBuffer = makeVertexBuffer(for: vertices)
    }
    
    private func makeVertexBuffer(for vertices: [Vertex]) -> MTLBuffer? {
        return device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
}

extension RendererImpl: MTKViewDelegate {
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let pipelineState = pipelineState,
              let descriptor = view.currentRenderPassDescriptor
        else {
            return
        }

        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)

        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)

        renderEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

    }
}
