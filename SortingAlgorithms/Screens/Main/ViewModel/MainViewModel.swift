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
    
    func start() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            (0..<50).forEach { _ in
                sleep(1)
                let testArray = (0..<50).map { _ in
                    return Int.random(in: 1...100)
                }
                DispatchQueue.main.async {
                    self.array = testArray
                }
            }
        }
    }
}

