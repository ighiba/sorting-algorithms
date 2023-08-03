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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.start()
        }
    }
    
    func start() {
        guard isNotSorted(sortChange.array) else { return }
        isSorting = true
        makeSort(algorithm: selectedSortAlgorithm, onChange: { [weak self] sortChange in
            self?.sortChange = sortChange
        }, onComplete: { [weak self] in
            print("completed")
            self?.isSorting = false
        }).start()
    }
    
    private func isNotSorted(_ array: [Int]) -> Bool {
        return array != array.sorted()
    }
    
    func shuffle() {
        sortChange.array.shuffle()
    }

    private func makeSort(algorithm: SortAlgorithms, onChange: ((SortChange) -> Void)?, onComplete: (() -> Void)? = nil) -> Sort {
        let sortInput = SortInput(sortChange.array, onChange, onComplete)
        switch algorithm {
        case .selection:
            return sortFactory.makeSelectionSort(sortInput: sortInput)
        }
    }
}
