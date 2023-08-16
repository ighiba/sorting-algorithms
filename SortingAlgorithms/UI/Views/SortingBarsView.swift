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

    private var metalView: MTKView!

    private var renderer: Renderer = RendererImpl()

    private let vertexBaseColor: SIMD4<Float> = NSColor.white.multiply(by: 0.9).toVertexColor()
    private let vertexRedColor: SIMD4<Float> = NSColor.red.toVertexColor()
    
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

    // MARK: - Update

    func update(withChange change: SortChange, maxValue: UInt16) {
        let barModels = change.array.enumerated().map { (index, element) in
            let value = CGFloat(element) / CGFloat(maxValue)
            let type = BarType.obtain(forAction: change.sortAction, currentIndex: index)
            return BarModel(type: type, value: value, rect: .zero)
        }
        
        let barWidth = Float(2) / Float(barModels.count)
        let vertices: [Quadrangle] = barModels.enumerated().map { (index, barModel) in
            let barHeight = Float(barModel.value * 2 - 1)
            let xPosition = Float(index) * barWidth - 1
            let vertexColor = vertexBarColor(forType: barModel.type, value: barModel.value)
            return Quadrangle(
                PositionXY(barWidth + xPosition,        -1),
                PositionXY(           xPosition,        -1),
                PositionXY(           xPosition, barHeight),
                PositionXY(barWidth + xPosition, barHeight),
                color: vertexColor
            )
        }
        
        renderer.renderQuadrangles(vertices)
    }
    
    // MARK: - Bars colors
    
    private func vertexBarColor(forType type: BarType, value: CGFloat) -> SIMD4<Float> {
        switch type {
        case .standart:
            return calculateVertexColor(for: value)
        case .selected, .swopped:
            return vertexRedColor
        }
    }
    
    private func calculateVertexColor(for value: CGFloat) -> SIMD4<Float> {
        let r = vertexBaseColor.x * Float(value)
        let g = vertexBaseColor.y * Float(value)
        let b = vertexBaseColor.z * Float(value)
        return SIMD4(r, g, b, vertexBaseColor.w)
    }
}
