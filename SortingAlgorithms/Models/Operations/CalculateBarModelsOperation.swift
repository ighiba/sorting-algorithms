//
//  CalculateBarModelsOperation.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

final class CalculateBarModelsOperation: Operation {
    var barModels: [BarModel] = []
    
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let change: SortChange
    let maxValue: UInt16
    
    init(frameSize: CGSize, change: SortChange, maxValue: UInt16) {
        self.frameWidth = frameSize.width
        self.frameHeight = frameSize.height
        self.change = change
        self.maxValue = maxValue
    }
    
    override func main() {
        guard !change.array.isEmpty else { return }
        let barWidth = frameWidth / CGFloat(change.array.count)
        let maxBarHeight = frameHeight
        
        barModels = change.array.enumerated().map { enumerated in
            let (element, index) = (enumerated.element, enumerated.offset)
            let xOffset = CGFloat(index) * barWidth
            let value = CGFloat(element) / CGFloat(maxValue)
            let barHeight = maxBarHeight * value
            let barRect = NSRect(
                x: xOffset,
                y: 0,
                width: barWidth,
                height: barHeight
            )
            let type = BarType.obtain(forAction: change.sortAction, currentIndex: index)
            
            return BarModel(type: type, value: value, rect: barRect)
        }
    }
}
