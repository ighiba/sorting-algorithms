//
//  BaseSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

typealias SortChange = (array: [Int], sortAction: SortAction?)

protocol Sort {
    var timeInterval: TimeInterval { get set }
    init(unsortedArray: [Int], sortChangeHandler: @escaping (SortChange) -> Void, completion: (() -> Void)?)
    func start()
}

class BaseSort: Sort {
    var timeInterval: TimeInterval = TimeInterval(0.05)
    var unsortedArray: [Int]
    let sortChangeHandler: (SortChange) -> Void
    let completion: (() -> Void)?
    
    required init(
        unsortedArray: [Int],
        sortChangeHandler: @escaping (SortChange) -> Void,
        completion: (() -> Void)? = nil
    ) {
        self.unsortedArray = unsortedArray
        self.sortChangeHandler = sortChangeHandler
        self.completion = completion
    }
    
    func start() {
        
    }
}
