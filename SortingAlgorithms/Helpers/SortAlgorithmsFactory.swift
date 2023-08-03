//
//  SortAlgorithmsFactory.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

protocol SortAlgorithmsFactory: AnyObject {
    func makeSelectionSort(sortInput: SortInput) -> SelectionSort
}

class SortAlgorithmsFactoryImpl: SortAlgorithmsFactory {
    func makeSelectionSort(sortInput: SortInput) -> SelectionSort {
        return makeSort(sortInput: sortInput)
    }
    
    private func makeSort<S: Sort>(sortInput: SortInput) -> S {
        return S(sortInput: sortInput)
    }
}
