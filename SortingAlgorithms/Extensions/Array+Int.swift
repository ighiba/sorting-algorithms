//
//  Array+Int.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

extension Array where Array.Element == Int {
    func isNotSorted() -> Bool {
        return self != self.sorted()
    }
}
