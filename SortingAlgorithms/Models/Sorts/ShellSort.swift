//
//  ShellSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 04.08.2023.
//

import Foundation

final class ShellSort: BaseSort {
    
    override var timeInterval: TimeInterval { return TimeInterval(0.05) }
    
    override func start() {
        DispatchQueue.global().async {
            self.startShellSort()
        }
    }
    
    private func startShellSort() {
        var step = unsortedArray.count / 2
        
        while step > 0 {
            for i in step ..< unsortedArray.count {
                var j = i - step
                comparisonsCount.inc()
                while j >= 0, j + step < unsortedArray.count && unsortedArray[j] > unsortedArray[j + step] {
                    unsortedArray.swapAt(j, j + step)
                    handleSwap(unsortedArray, currentIndex: j, swoppedIndex: j + step)
                    j -= step
                }
            }
            
            step /= 2
        }
        handleCompletion(resultArray: unsortedArray)
    }
}
