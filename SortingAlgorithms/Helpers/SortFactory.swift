//
//  SortFactory.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

protocol SortFactory: AnyObject {
    func makeSort(algorithm: SortAlgorithms, array: [Int], onChange: ((SortChange) -> Void)?, onComplete: (() -> Void)?) -> Sort
}

class SortFactoryImpl: SortFactory {
    
    let concreteSortFactory: ConcreteSortFactory
    
    init(concreteSortFactory: ConcreteSortFactory) {
        self.concreteSortFactory = concreteSortFactory
    }
    
    func makeSort(algorithm: SortAlgorithms, array: [Int], onChange: ((SortChange) -> Void)?, onComplete: (() -> Void)?) -> Sort {
        let sortInput = SortInput(array, onChange, onComplete)
        switch algorithm {
        case .selection:
            return concreteSortFactory.makeSelectionSort(sortInput: sortInput)
        case .insertion:
            return concreteSortFactory.makeInsertionSort(sortInput: sortInput)
        case .bubble:
            return concreteSortFactory.makeBubbleSort(sortInput: sortInput)
        }
    }
}
