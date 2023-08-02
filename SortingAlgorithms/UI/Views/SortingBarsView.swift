//
//  SortingBarsView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

protocol SortingView: NSView {
    func update(withArray array: [Int])
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
        setViews()
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
    
    func setViews() {

    }
    
    func configureBarField() {
        guard let barField = self.barField else { return }
        self.layer?.sublayers?.removeAll()
        self.layer?.addSublayer(barField)
        barField.frame = self.bounds
    }
    
    func update(withArray array: [Int]) {
        guard !array.isEmpty else { return }
        let (frameWidth, frameHeight) = (self.frame.width, self.frame.height)
        let barWidth = frameWidth / CGFloat(array.count)
        let maxBarHeight = frameHeight
        let maxElementValue = array.max() ?? 0
        
        let barModels = array.enumerated().map { enumerated in
            let xOffset = CGFloat(enumerated.offset) * barWidth
            let value = CGFloat(enumerated.element) / CGFloat(maxElementValue)
            let barHeight = maxBarHeight * value
            let barRect = NSRect(
                x: xOffset,
                y: 0,
                width: barWidth,
                height: barHeight
            )
            return BarModel(value: value, rect: barRect)
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
        bar.backgroundColor = calculateColor(for: barModel.value).cgColor
        return bar
    }
    
    private func calculateColor(for value: CGFloat) -> NSColor {
        return baseBarColor.multiply(by: value)
    }
}
