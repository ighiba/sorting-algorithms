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
    
    // MARK: - Properties
    
    @Published var sortChange: SortChange
    @Published var isSorting: Bool = false
    var currentSortAlgorithm: SortAlgorithms = .selection
    
    var sortFactory: SortFactory!
    
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
        guard sortChange.array.isNotSorted() else { return }
        isSorting = true
        sortFactory.makeSort(algorithm: currentSortAlgorithm, array: sortChange.array, onChange: { [weak self] sortChange in
            self?.sortChange = sortChange
        }, onComplete: { [weak self] in
            self?.isSorting = false
        }).start()
    }
    
    func shuffle() {
        sortChange.array.shuffle()
    }
}
