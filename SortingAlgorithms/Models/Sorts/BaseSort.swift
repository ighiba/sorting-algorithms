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
    func setDelay(ms delay: UInt16)
}

class BaseSort: Sort {
    @Published var comparisonsCount: Int = 0
    @Published var swapsCount: Int = 0
    
    private(set) var delay: TimeInterval = 0.05
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
    
    func setDelay(ms delay: UInt16) {
        self.delay = Double(delay) / 1000
    }
    
    func handleSelect(_ array: [Int], index: Int) {
        sortChangeHandler?((array, .select([index])))
        Thread.sleep(forTimeInterval: delay)
    }
    
    func handleSelect(_ array: [Int], indices: [Int]) {
        sortChangeHandler?((array, .select(indices)))
        Thread.sleep(forTimeInterval: delay)
    }
    
    func handleSwap(_ array: [Int], currentIndex: Int, swoppedIndex: Int? = nil) {
        sortChangeHandler?((array, .swap(currentIndex, swoppedIndex)))
        swapsCount.inc()
        Thread.sleep(forTimeInterval: delay)
    }
    
    func handleCompletion(resultArray: [Int]) {
        sortChangeHandler?((array: resultArray, sortAction: nil))
        completion?()
    }
}
