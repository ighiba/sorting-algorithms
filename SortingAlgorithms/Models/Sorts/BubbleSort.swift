//
//  BubbleSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

final class BubbleSort: BaseSort {
    
    override var timeInterval: TimeInterval { return TimeInterval(0.02) }
    
    override func start() {
        DispatchQueue.global().async {
            self.startBubbleSort()
        }
    }
    
    private func startBubbleSort() {
        var newArray = unsortedArray
        
        for j in 0 ..< newArray.count {
            for i in 1 ..< newArray.count - j {
                comparisonsCount.inc()
                if newArray[i] < newArray[i - 1] {
                    newArray.swapAt(i, i - 1)
                    handleSwap(newArray, currentIndex: i, swoppedIndex: i - 1)
                }
            }
        }
        
        handleCompletion(resultArray: newArray)
    }
}
