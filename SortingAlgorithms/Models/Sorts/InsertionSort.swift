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
            sortChangeHandler?((unsortedArray, .select(j)))
            Thread.sleep(forTimeInterval: timeInterval)
            
            let key = unsortedArray[j]
            var i = j - 1
            
            while i >= 0 && unsortedArray[i] > key {
                i -= 1
            }
            
            if i != j - 1 {
                let item = unsortedArray.remove(at: j)
                unsortedArray.insert(item, at: i + 1)
                sortChangeHandler?((unsortedArray, .swap(i + 1)))
                Thread.sleep(forTimeInterval: timeInterval)
            }
        }
        sortChangeHandler?((array: unsortedArray, sortAction: nil))
        completion?()
    }
}
