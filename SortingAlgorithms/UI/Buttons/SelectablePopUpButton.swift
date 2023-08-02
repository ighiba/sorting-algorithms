//
//  SelectablePopUpButton.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Cocoa

class SelectablePopUpButton: NSPopUpButton {
    func configure<T: TitledCaseIterable>(selectedItem: T) {
        let titles = T.allCases.map { $0.rawValue }
        self.addItems(withTitles: titles)
        self.selectItem(withTitle: selectedItem.rawValue)
    }
}
