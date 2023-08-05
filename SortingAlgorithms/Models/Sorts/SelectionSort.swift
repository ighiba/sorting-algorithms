//
//  SelectionSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

final class SelectionSort: BaseSort {
    override func start() {
        DispatchQueue.global().async {
            self.startSelectionSort()
        }
    }
    
    private func startSelectionSort() {
        var newArray: [Int] = []
        for _ in unsortedArray {
            let min = findMin(unsortedArray)
            guard let minIndex = unsortedArray.firstIndex(of: min) else { break }
            
            var currentIndex = minIndex + newArray.count
            handleSelect(newArray + unsortedArray, index: currentIndex)
            
            newArray.append(unsortedArray.remove(at: minIndex))
            currentIndex = newArray.count - 1
            handleSwap(newArray + unsortedArray, currentIndex: currentIndex)
        }
        handleCompletion(resultArray: newArray)
    }
    
    private func findMin(_ array: [Int]) -> Int {
        return array.min(by: { lhs, rhs in
            comparisonsCount.inc()
            return lhs < rhs
        }) ?? 0
    }
}
