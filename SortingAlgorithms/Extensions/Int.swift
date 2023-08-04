//
//  Int.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Foundation

extension Int {
    mutating func inc(_ int: Int = 1) {
        self += int
    }
    
    mutating func dec(_ int: Int = 1) {
        self -= int
    }
}
