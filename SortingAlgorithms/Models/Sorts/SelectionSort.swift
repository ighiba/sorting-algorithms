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
            guard let min = unsortedArray.min(),
                  let minIndex = unsortedArray.firstIndex(of: min)
            else {
                break
            }
            var currentIndex = minIndex + newArray.count
            sortChangeHandler?((newArray + unsortedArray, .select(currentIndex)))
            Thread.sleep(forTimeInterval: timeInterval)
            
            newArray.append(unsortedArray.remove(at: minIndex))
            currentIndex = newArray.count - 1
            sortChangeHandler?((newArray + unsortedArray, .swap(currentIndex)))
            Thread.sleep(forTimeInterval: timeInterval)
        }
        sortChangeHandler?((array: newArray, sortAction: nil))
        completion?()
    }
}
