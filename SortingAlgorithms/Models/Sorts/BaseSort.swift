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
    init(sortInput: SortInput)
    func start()
}

class BaseSort: Sort {
    @Published var comparisonsCount: Int = 0
    @Published var swapsCount: Int = 0
    
    var timeInterval: TimeInterval { return TimeInterval(0.05) }
    var unsortedArray: [Int]
    let sortChangeHandler: ((SortChange) -> Void)?
    let completion: (() -> Void)?
    
    required init(sortInput: SortInput) {
        self.unsortedArray = sortInput.unsortedArray
        self.sortChangeHandler = sortInput.sortChangeHandler
        self.completion = sortInput.completion
    }
    
    func start() {
        // Implement in child
    }
    
    func handleSelect(_ array: [Int], currentIndex: Int) {
        sortChangeHandler?((array, .select(currentIndex)))
        Thread.sleep(forTimeInterval: timeInterval)
    }
    
    func handleSwap(_ array: [Int], currentIndex: Int, swoppedIndex: Int? = nil) {
        sortChangeHandler?((array, .swap(currentIndex, swoppedIndex)))
        swapsCount.inc()
        Thread.sleep(forTimeInterval: timeInterval)
    }
    
    func handleCompletion(resultArray: [Int]) {
        sortChangeHandler?((array: resultArray, sortAction: nil))
        completion?()
    }
}
