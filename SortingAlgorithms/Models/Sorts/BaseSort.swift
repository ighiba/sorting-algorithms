//
//  BaseSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

protocol Sort {
    var timeInterval: TimeInterval { get set }
    init(unsortedArray: [Int], sortChangeHandler: @escaping ([Int]) -> Void, completion: (() -> Void)?)
    func start()
}

class BaseSort: Sort {
    var timeInterval: TimeInterval = TimeInterval(0.1)
    var unsortedArray: [Int]
    let sortChangeHandler: ([Int]) -> Void
    let completion: (() -> Void)?
    
    required init(
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
