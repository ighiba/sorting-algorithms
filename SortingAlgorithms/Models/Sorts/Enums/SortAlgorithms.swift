//
//  SortAlgorithms.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Foundation

protocol TitledCaseIterable: CaseIterable, RawRepresentable where RawValue == String {}

enum SortAlgorithms: String, TitledCaseIterable {
    case selection = "Selection sort"
    case insertion = "Insertion sort"
    case bubble = "Bubble sort"
    case shell = "Shell sort"
    case quick = "Quick sort"
    case merge = "Merge sort"
}
