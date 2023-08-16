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

    private let rgbaColorBase: RGBA = NSColor.white.multiply(by: 0.9).toRGBA()
    private let rgbaColorRed: RGBA = NSColor.red.toRGBA()
    
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
            let rgbaColor = barRgbaColor(forType: barModel.type, value: barModel.value)
            return Quadrangle(
                PositionXY(barWidth + xPosition,        -1),
                PositionXY(           xPosition,        -1),
                PositionXY(           xPosition, barHeight),
                PositionXY(barWidth + xPosition, barHeight),
                color: rgbaColor
            )
        }
        
        renderer.renderQuadrangles(vertices)
    }
    
    // MARK: - Bars colors
    
    private func barRgbaColor(forType type: BarType, value: CGFloat) -> RGBA {
        switch type {
        case .standart:
            return calculateRgbaColor(for: value)
        case .selected, .swopped:
            return rgbaColorRed
        }
    }
    
    private func calculateRgbaColor(for value: CGFloat) -> RGBA {
        let r = rgbaColorBase.x * Float(value)
        let g = rgbaColorBase.y * Float(value)
        let b = rgbaColorBase.z * Float(value)
        return RGBA(r, g, b, rgbaColorBase.w)
    }
}
