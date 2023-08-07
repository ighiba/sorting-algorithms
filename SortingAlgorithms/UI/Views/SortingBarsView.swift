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

    private var renderer: Renderer = RendererImpl()

    private let baseBarColor: NSColor = .white.multiply(by: 0.9)
    
    // MARK: - Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        metalView = MTKView(frame: bounds)
        addSubview(metalView)

        metalView.device = renderer.device

        metalView.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        metalView.delegate = renderer

        renderer.setupMetal()
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

    // MARK: - Update

    func update(withChange change: SortChange, maxValue: UInt16) {
        let barModels = change.array.enumerated().map { (index, element) in
            let value = CGFloat(element) / CGFloat(maxValue)
            let type = BarType.obtain(forAction: change.sortAction, currentIndex: index)
            return BarModel(type: type, value: value, rect: .zero)
        }
        
        autoreleasepool {
            let barWidth = Float(2) / Float(barModels.count)
            let vertices: [Quadrangle] = barModels.enumerated().map { (index, barModel) in
                let barHeight = Float(barModel.value * 2 - 1)
                let xPosition = Float(index) * barWidth - 1
                let vertexColor = vertexColor(forType: barModel.type, value: barModel.value)
                return Quadrangle(
                    SIMD4<Float>(barWidth + xPosition,        -1, 0, 1),
                    SIMD4<Float>(           xPosition,        -1, 0, 1),
                    SIMD4<Float>(           xPosition, barHeight, 0, 1),
                    SIMD4<Float>(barWidth + xPosition, barHeight, 0, 1),
                    color: vertexColor
                )
            }
            
            renderer.renderQuadrangles(vertices)
        }
    }
    
    // MARK: - Bars colors

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
