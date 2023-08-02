//
//  MainViewModel.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    var array: [Int] { get }
    func viewDidLoad()
    func start()
    func shuffle()
}

class MainViewModel: MainViewModelDelegate {
    
    @Published var array: [Int] = []
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
        DispatchQueue.global().async {
            let sort = self.makeSort(algorithm: self.selectedSortAlgorithm, onChange: { newArray in
                self.array = newArray
                Thread.sleep(forTimeInterval: 0.1)
            }, onComplete: {
                print("completed")
            })
            sort.start()
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
