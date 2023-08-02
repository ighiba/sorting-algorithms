//
//  SelectionSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

final class SelectionSort {
    
    private var unsortedArray: [Int]
    private let sortChangeHandler: ([Int]) -> Void
    private let completion: (() -> Void)?
    
    init(
        unsortedArray: [Int],
        sortChangeHandler: @escaping ([Int]) -> Void,
        completion: (() -> Void)? = nil
    ) {
        self.unsortedArray = unsortedArray
        self.sortChangeHandler = sortChangeHandler
        self.completion = completion
    }
    
    func start() {
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
