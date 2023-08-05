//
//  ShellSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 04.08.2023.
//

import Foundation

final class ShellSort: BaseSort {
        
    override func start() {
        DispatchQueue.global().async {
            self.startShellSort()
        }
    }
    
    private func startShellSort() {
        var newArray = unsortedArray
        var step = unsortedArray.count / 2
        
        while step > 0 {
            for i in step ..< newArray.count {
                var j = i - step
                comparisonsCount.inc()
                while j >= 0, j + step < newArray.count && newArray[j] > newArray[j + step] {
                    newArray.swapAt(j, j + step)
                    handleSwap(newArray, currentIndex: j, swoppedIndex: j + step)
                    j -= step
                }
            }
            step /= 2
        }
        
        handleCompletion(resultArray: newArray)
    }
}
