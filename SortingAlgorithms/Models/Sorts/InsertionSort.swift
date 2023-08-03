//
//  InsertionSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

final class InsertionSort: BaseSort {
    override func start() {
        DispatchQueue.global().async {
            self.startInsertionSort()
        }
    }
    
    private func startInsertionSort() {
        for j in 1 ..< unsortedArray.count {
            handleSelect(unsortedArray, currentIndex: j)
            
            let key = unsortedArray[j]
            var i = j - 1
            
            while i >= 0 && unsortedArray[i] > key {
                comparisonsCount.inc()
                i -= 1
            }
            
            if i != j - 1 {
                let item = unsortedArray.remove(at: j)
                let index = i + 1
                unsortedArray.insert(item, at: index)
                handleSwap(unsortedArray, currentIndex: index)
            }
        }
        handleCompletion(resultArray: unsortedArray)
    }
}
