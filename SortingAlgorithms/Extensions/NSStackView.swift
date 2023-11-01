//
//  NSStackView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 01.11.2023.
//

import Cocoa

extension NSStackView {
    func addArrangedSubviews(_ views: [NSView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
