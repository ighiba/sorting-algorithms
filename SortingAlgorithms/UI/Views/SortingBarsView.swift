//
//  SortingBarsView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

protocol SortingView: NSView {
    func update(withChange change: (SortChange), maxValue: UInt16)
}

class SortingBarsView: NSView, SortingView {
    
    // MARK: - Properties
    
    private let mainQueue = OperationQueue.main
    private let calculationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    private let baseBarColor: NSColor = .white.multiply(by: 0.9)
    
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
    
    // MARK: - Update
    
    func update(withChange change: SortChange, maxValue: UInt16) {
        let calculateBarModelsOperation = CalculateBarModelsOperation(
            frameSize: .sortingViewSize,
            change: change,
            maxValue: maxValue
        )
        
        let drawFieldOperation = DrawFieldOperation { [weak self] barModels in
            self?.barField = self?.drawField(barModels)
        }
        
        drawFieldOperation.addDependency(calculateBarModelsOperation)
        
        calculationQueue.addOperation(calculateBarModelsOperation)
        mainQueue.addOperation(drawFieldOperation)
    }
    
    // MARK: - Bars drawing

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
