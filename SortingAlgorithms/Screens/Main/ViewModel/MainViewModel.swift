//
//  MainViewModel.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    var array: [Int] { get }
    func start()
}

class MainViewModel: MainViewModelDelegate {
    
    @Published var array: [Int] = []
    
    private var testArray: [Int] { return ((1...50).map { $0 }).shuffled() }
    
    func start() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.startSelectionSort()
        }
    }
    
    func startSelectionSort() {
        SelectionSort(unsortedArray: testArray) { newArray in
            self.array = newArray
            Thread.sleep(forTimeInterval: 0.1)
        }.start()
    }
}
