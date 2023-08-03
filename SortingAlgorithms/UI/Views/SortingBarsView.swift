//
//  SortingBarsView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

protocol SortingView: NSView {
    func update(withChange change: (SortChange))
}

class SortingBarsView: NSView, SortingView {
    
    // MARK: - Properties
    
    private let baseBarColor = NSColor.white.multiply(by: 0.9)
    
    private var barField: CALayer? {
        didSet {
            configureBarField()
        }
    }
    
    // MARK: - Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
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

    func configureBarField() {
        guard let barField = self.barField else { return }
        self.layer?.sublayers?.removeAll()
        self.layer?.addSublayer(barField)
        barField.frame = self.bounds
    }
    
    func update(withChange change: SortChange) {
        guard !change.array.isEmpty else { return }
        let (frameWidth, frameHeight) = (self.frame.width, self.frame.height)
        let barWidth = frameWidth / CGFloat(change.0.count)
        let maxBarHeight = frameHeight
        let maxElementValue = change.0.max() ?? 0
        
        let barModels = change.0.enumerated().map { enumerated in
            let (element, index) = (enumerated.element, enumerated.offset)
            let xOffset = CGFloat(index) * barWidth
            let value = CGFloat(element) / CGFloat(maxElementValue)
            let barHeight = maxBarHeight * value
            let barRect = NSRect(
                x: xOffset,
                y: 0,
                width: barWidth,
                height: barHeight
            )
            let type = BarType.obtain(forAction: change.1, currentIndex: index)
            
            return BarModel(type: type, value: value, rect: barRect)
        }
        
        barField = drawField(barModels)
    }

    private func drawField(_ barModels: [BarModel]) -> CALayer {
        let field = CALayer()
        barModels.forEach { barModel in
            let bar = drawBar(barModel)
            field.addSublayer(bar)
        }
        return field
    }
    
    private func drawBar(_ barModel: BarModel) -> CALayer {
        let bar = CALayer()
        bar.frame = barModel.rect
        bar.backgroundColor = barColor(forType: barModel.type, value: barModel.value).cgColor
        return bar
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
