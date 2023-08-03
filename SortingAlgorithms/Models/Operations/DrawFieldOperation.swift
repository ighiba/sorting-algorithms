//
//  DrawFieldOperation.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

final class DrawFieldOperation: Operation {
    let handleDraw: (([BarModel]) -> Void)
    
    init(handleDraw: @escaping ([BarModel]) -> Void) {
        self.handleDraw = handleDraw
    }
    
    override func main() {
        var barModels: [BarModel] = []
        if let op = dependencies.first as? CalculateBarModelsOperation {
            barModels = op.barModels
        }
        handleDraw(barModels)
    }
}
