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
        var newArray = unsortedArray
        
        for j in 1 ..< newArray.count {
            handleSelect(newArray, index: j)
            
            let key = newArray[j]
            var i = j - 1
            
            while i >= 0 && newArray[i] > key {
                comparisonsCount.inc()
                i -= 1
            }
            
            if i != j - 1 {
                let item = newArray.remove(at: j)
                let index = i + 1
                newArray.insert(item, at: index)
                handleSwap(newArray, currentIndex: index)
            }
        }
        
        handleCompletion(resultArray: newArray)
    }
}
