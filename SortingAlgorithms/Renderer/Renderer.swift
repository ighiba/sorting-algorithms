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
    var vertexFactory: VertexFactory { get }
    func setupMetal()
    func updateVertexBuffer(withVertices vertices: [Vertex])
}

class RendererImpl: NSObject, Renderer {
    var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    private var pipelineState: MTLRenderPipelineState!
    private var vertexBuffer: MTLBuffer!
    private var vertexCount: Int = 0
    var vertexFactory: VertexFactory = VertexFactoryImpl()
    
    override init() {
        device = MTLCreateSystemDefaultDevice()
        commandQueue = device.makeCommandQueue()
    }
    
    func setupMetal() {
        let library = device.makeDefaultLibrary()
       
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = library!.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = library!.makeFunction(name: "fragmentShader")
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float4
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0

        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        vertexDescriptor.layouts[0].stepFunction = .perVertex

        pipelineDescriptor.vertexDescriptor = vertexDescriptor

        pipelineState = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        let initialVertices = vertexFactory.makeQuadrangle(
            SIMD4<Float>( 1, -1, 0, 1),
            SIMD4<Float>(-1, -1, 0, 1),
            SIMD4<Float>(-1,  1, 0, 1),
            SIMD4<Float>( 1,  1, 0, 1),
            color: SIMD4<Float>(1, 1, 1, 1)
        )
        
        updateVertexBuffer(withVertices: initialVertices)
    }
    
    func updateVertexBuffer(withVertices vertices: [Vertex]) {
        vertexCount = vertices.count
        vertexBuffer = makeVertexBuffer(for: vertices)
    }
    
    private func makeVertexBuffer(for vertices: [Vertex]) -> MTLBuffer? {
        device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }
}

extension RendererImpl: MTKViewDelegate {
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let pipelineState = pipelineState,
              let descriptor = view.currentRenderPassDescriptor else {
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
