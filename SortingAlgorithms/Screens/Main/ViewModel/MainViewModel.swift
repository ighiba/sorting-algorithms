//
//  MainViewModel.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    var array: [Int] { get }
    var isSorting: Bool { get }
    func viewDidLoad()
    func start()
    func shuffle()
}

class MainViewModel: MainViewModelDelegate {
    
    @Published var array: [Int] = []
    @Published var isSorting: Bool = false
    var selectedSortAlgorithm: SortAlgorithms = .selection
    
    var sortFactory: SortAlgorithmsFactory!
        
    init() {
        self.array = ((1...50).map { $0 }).shuffled()
    }
    
    func viewDidLoad() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.start()
        }
    }
    
    func start() {
        self.isSorting = true
        DispatchQueue.global().async {
            self.makeSort(algorithm: self.selectedSortAlgorithm, onChange: { newArray in
                self.array = newArray
            }, onComplete: {
                print("completed")
                self.isSorting = false
            }).start()
        }
    }
    
    func shuffle() {
        array.shuffle()
    }
    
    private func makeSort(algorithm: SortAlgorithms, onChange: @escaping ([Int]) -> Void, onComplete: (() -> Void)? = nil) -> Sort {
        switch algorithm {
        case .selection:
            return sortFactory.makeSelectionSort(
                unsortedArray: array,
                sortChangeHandler: onChange,
                completion: onComplete
            )
        }
    }
}
