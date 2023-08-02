//
//  SortAlgorithmsFactory.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

protocol SortAlgorithmsFactory: AnyObject {
    func makeSelectionSort(unsortedArray: [Int], sortChangeHandler: @escaping ([Int]) -> Void, completion: (() -> Void)?) -> SelectionSort
}

class SortAlgorithmsFactoryImpl: SortAlgorithmsFactory {
    func makeSelectionSort(unsortedArray: [Int], sortChangeHandler: @escaping ([Int]) -> Void, completion: (() -> Void)?) -> SelectionSort {
        return makeSort(unsortedArray: unsortedArray, sortChangeHandler: sortChangeHandler, completion: completion)
    }
    
    private func makeSort<S: Sort>(unsortedArray: [Int],sortChangeHandler: @escaping ([Int]) -> Void,completion: (() -> Void)?) -> S {
        return S(unsortedArray: unsortedArray, sortChangeHandler: sortChangeHandler,completion: completion)
    }
}
