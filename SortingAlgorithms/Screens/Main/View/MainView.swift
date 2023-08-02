//
//  MainView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

class MainView: NSView {
    
    let sortingBarsView = SortingBarsView()

    override init(frame: CGRect) {
        super.init(frame: NSRect(origin: .zero, size: .windowSize))
        setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        self.addSubview(sortingBarsView)
        sortingBarsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortingBarsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            sortingBarsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            sortingBarsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            sortingBarsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

