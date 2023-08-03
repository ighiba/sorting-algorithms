//
//  BaseSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

typealias SortInput = (unsortedArray: [Int], sortChangeHandler: ((SortChange) -> Void)?, completion: (() -> Void)?)
typealias SortChange = (array: [Int], sortAction: SortAction?)

protocol Sort {
    var timeInterval: TimeInterval { get set }
    init(sortInput: SortInput)
    func start()
}

class BaseSort: Sort {
    var timeInterval: TimeInterval = TimeInterval(0.05)
    var unsortedArray: [Int]
    let sortChangeHandler: ((SortChange) -> Void)?
    let completion: (() -> Void)?
    
    required init(sortInput: SortInput) {
        self.unsortedArray = sortInput.unsortedArray
        self.sortChangeHandler = sortInput.sortChangeHandler
        self.completion = sortInput.completion
    }
    
    func start() {
        
    }
}
