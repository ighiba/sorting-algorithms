//
//  BarType.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

enum BarType {
    case standart
    case selected
    case swopped
}

extension BarType {
    static func obtain(forAction sortAction: SortAction?, currentIndex: Int) -> BarType {
        let type: BarType
        if case .select(let index) = sortAction, index == currentIndex {
            type = .selected
        } else if case .swap(let index, let swoppedIndex) = sortAction, index == currentIndex || swoppedIndex == currentIndex {
            type = .swopped
        } else {
            type = .standart
        }
        return type
    }
}
