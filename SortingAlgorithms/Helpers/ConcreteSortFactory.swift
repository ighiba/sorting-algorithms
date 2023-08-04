//
//  ConcreteSortFactory.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

protocol ConcreteSortFactory: AnyObject {
    func makeSelectionSort(sortInput: SortInput) -> SelectionSort
    func makeInsertionSort(sortInput: SortInput) -> InsertionSort
    func makeBubbleSort(sortInput: SortInput) -> BubbleSort
    func makeShellSort(sortInput: SortInput) -> ShellSort
    func makeQuickSort(sortInput: SortInput) -> QuickSort
}

class SortAlgorithmsFactoryImpl: ConcreteSortFactory {
    func makeSelectionSort(sortInput: SortInput) -> SelectionSort {
        return makeSort(sortInput: sortInput)
    }
    
    func makeInsertionSort(sortInput: SortInput) -> InsertionSort {
        return makeSort(sortInput: sortInput)
    }
    
    func makeBubbleSort(sortInput: SortInput) -> BubbleSort {
        return makeSort(sortInput: sortInput)
    }
    
    func makeShellSort(sortInput: SortInput) -> ShellSort {
        return makeSort(sortInput: sortInput)
    }
    
    func makeQuickSort(sortInput: SortInput) -> QuickSort {
        return makeSort(sortInput: sortInput)
    }
    
    private func makeSort<S: Sort>(sortInput: SortInput) -> S {
        return S(sortInput: sortInput)
    }
}
