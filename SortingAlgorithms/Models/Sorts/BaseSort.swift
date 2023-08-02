//
//  BaseSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

class BaseSort {
    var unsortedArray: [Int]
    let sortChangeHandler: ([Int]) -> Void
    let completion: (() -> Void)?
    
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
        
    }
}
