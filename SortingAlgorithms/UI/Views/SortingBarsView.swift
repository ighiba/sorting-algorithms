//
//  SortingBarsView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa
import MetalKit

protocol SortingView: NSView {
    func update(withChange change: (SortChange), maxValue: UInt16)
}

class SortingBarsView: NSView, SortingView {
    
    // MARK: - Properties
    
//    private let mainQueue = OperationQueue.main
//    private let calculationQueue: OperationQueue = {
//        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 1
//        queue.qualityOfService = .userInitiated
//        return queue
//    }()
    
    private var metalView: MTKView!

    private var device: MTLDevice!
    private var commandQueue: MTLCommandQueue!
    private var pipelineState: MTLRenderPipelineState!
    private var vertexBuffer: MTLBuffer!
    private var vertexCount: Int = 0
    private let vertexFactory: VertexFactory = VertexFactoryImpl()

    private let baseBarColor: NSColor = .white.multiply(by: 0.9)
    
    // MARK: - Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        metalView = MTKView(frame: bounds)
        addSubview(metalView)

        device = MTLCreateSystemDefaultDevice()
        metalView.device = device

        commandQueue = device.makeCommandQueue()

        metalView.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        metalView.delegate = self

        setupMetal()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.white.setFill()
        dirtyRect.fill()
        super.draw(dirtyRect)
    }
    
    // MARK: - Metal
    
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
        
        vertexCount = initialVertices.count
        
        vertexBuffer = makeVertexBuffer(for: initialVertices)
    }
    
    private func makeVertexBuffer(for vertices: [Vertex]) -> MTLBuffer? {
        device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertices.count, options: [])
    }

    // MARK: - Update

    func update(withChange change: SortChange, maxValue: UInt16) {
        let barModels = change.array.enumerated().map { (index, element) in
            let value = CGFloat(element) / CGFloat(maxValue)
            let type = BarType.obtain(forAction: change.sortAction, currentIndex: index)
            return BarModel(type: type, value: value, rect: .zero)
        }
        
        autoreleasepool {
            let barWidth = Float(2) / Float(barModels.count)
            let vertices: [Vertex] = barModels.enumerated().map { (index, barModel) in
                let barHeight = Float(barModel.value * 2 - 1)
                let xPosition = Float(index) * barWidth - 1
                let vertexColor = vertexColor(forType: barModel.type, value: barModel.value)
                return vertexFactory.makeQuadrangle(
                    SIMD4<Float>(barWidth + xPosition,        -1, 0, 1),
                    SIMD4<Float>(           xPosition,        -1, 0, 1),
                    SIMD4<Float>(           xPosition, barHeight, 0, 1),
                    SIMD4<Float>(barWidth + xPosition, barHeight, 0, 1),
                    color: vertexColor
                )
            }.reduce([]) { $0 + $1 }
            
            vertexCount = vertices.count
            
            vertexBuffer = makeVertexBuffer(for: vertices)
        }
    }
    
    // MARK: - Bars drawing

    private func vertexColor(forType type: BarType, value: CGFloat) -> SIMD4<Float> {
        let nsColor = barColor(forType: type, value: value)
        let (r, g, b, a) = nsColor.floatComponents()
        return SIMD4<Float>(r, g, b, a)
    }
    
    private func barColor(forType type: BarType, value: CGFloat) -> NSColor {
        switch type {
        case .standart:
            return calculateColor(for: value)
        case .selected, .swopped:
            return NSColor.red
        }
    }
    
    private func calculateColor(for value: CGFloat) -> NSColor {
        return baseBarColor.multiply(by: value)
    }
}

// MARK: - MTKViewDelegate

extension SortingBarsView: MTKViewDelegate {
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
