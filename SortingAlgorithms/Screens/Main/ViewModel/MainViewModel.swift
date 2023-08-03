//
//  MainViewModel.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    var sortChange: SortChange { get }
    var isSorting: Bool { get }
    func viewDidLoad()
    func start()
    func shuffle()
}

class MainViewModel: MainViewModelDelegate {
    
    // MARK: - Methods
    
    @Published var sortChange: SortChange
    @Published var isSorting: Bool = false
    var selectedSortAlgorithm: SortAlgorithms = .selection
    
    var sortFactory: SortAlgorithmsFactory!
    
    // MARK: - Init
        
    init() {
        let array = ((1...50).map { $0 }).shuffled()
        self.sortChange = (array, nil)
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.start()
        }
    }
    
    func start() {
        self.isSorting = true
        DispatchQueue.global().async {
            self.makeSort(algorithm: self.selectedSortAlgorithm, onChange: { (newArray, sortAction) in
                self.sortChange.0 = newArray
                self.sortChange.1 = sortAction
            }, onComplete: {
                print("completed")
                self.isSorting = false
            }).start()
        }
    }
    
    func shuffle() {
        sortChange.0.shuffle()
    }
    
    private func makeSort(algorithm: SortAlgorithms, onChange: @escaping ([Int], SortAction?) -> Void, onComplete: (() -> Void)? = nil) -> Sort {
        switch algorithm {
        case .selection:
            return sortFactory.makeSelectionSort(
                unsortedArray: sortChange.0,
                sortChangeHandler: onChange,
                completion: onComplete
            )
        }
    }
}
