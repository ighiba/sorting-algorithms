//
//  SelectionSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation


final class SelectionSort: BaseSort {
    override func start() {
        var newArray: [Int] = []
        for _ in unsortedArray {
            guard let min = unsortedArray.min(),
                  let minIndex = unsortedArray.firstIndex(of: min)
            else {
                break
            }
            newArray.append(unsortedArray.remove(at: minIndex))
            sortChangeHandler(newArray + unsortedArray)
        }
        completion?()
    }
}
