//
//  MainViewModel.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation
import Combine

typealias SortStatistics = (comparisons: Int, swaps: Int)

protocol MainViewModelDelegate: AnyObject {
    var sortChange: SortChange { get }
    var isSorting: Bool { get }
    func viewDidLoad()
    func start()
    func shuffle()
    func changeAlgorithm(_ algorithm: SortAlgorithms)
}

class MainViewModel: MainViewModelDelegate {
    
    // MARK: - Properties
    
    @Published var sortChange: SortChange
    @Published var sortStatistics: SortStatistics
    @Published var isSorting: Bool = false
    
    var arraySize: UInt16 = 512
    var delay: UInt16 = 10
    
    var currentSortAlgorithm: SortAlgorithms = .quick
    
    var sortFactory: SortFactory!
 
    // MARK: - Init
        
    init() {
        sortChange = ([], nil)
        sortStatistics = (0, 0)
        refreshArray(arraySize)
    }
    
    // MARK: - Methods
    
    private func refreshArray(_ arraySize: UInt16) {
        sortChange.array = createNewArray(upToSize: arraySize)
    }
    
    private func createNewArray(upToSize elementsCount: UInt16) -> [Int] {
       return (1...elementsCount).map({ Int($0) }).shuffled()
    }
    
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //self.start()
        }
    }
    
    func start() {
        if sortChange.array.count != arraySize { refreshArray(arraySize) }
        guard sortChange.array.isNotSorted() else { return }
        
        isSorting = true
        let sort = sortFactory.makeSort(algorithm: currentSortAlgorithm, array: sortChange.array, onChange: { [weak self] sortChange in
            self?.sortChange = sortChange
        }, onComplete: { [weak self] in
            self?.isSorting = false
        })
        
        bindSortStatistics(sort)
        
        sort.setDelay(ms: delay)
        sort.start()
    }
    
    private func bindSortStatistics(_ sort: Sort) {
        guard let baseSort = sort as? BaseSort else { return }
        Publishers.CombineLatest(baseSort.$comparisonsCount, baseSort.$swapsCount)
            .receive(on: DispatchQueue.main)
            .map { SortStatistics($0, $1) }
            .assign(to: &$sortStatistics)
    }
    
    func shuffle() {
        refreshArray(arraySize)
        sortStatistics.comparisons = 0
        sortStatistics.swaps = 0
    }
    
    func changeAlgorithm(_ algorithm: SortAlgorithms) {
        currentSortAlgorithm = algorithm
    }
}
