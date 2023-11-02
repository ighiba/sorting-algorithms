//
//  SortStatisticsView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Cocoa

private let textViewHeightMultiplier: CGFloat = 0.5

class SortStatisticsView: NSView {
    
    private let comparisonsTextView = NSTextField(labelWithString: "Comparisons: 0")
    private let swapsTextView = NSTextField(labelWithString: "Swaps: 0")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(comparisonsTextView)
        addSubview(swapsTextView)
    }
    
    private func setupLayout() {
        comparisonsTextView.translatesAutoresizingMaskIntoConstraints = false
        swapsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            comparisonsTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            comparisonsTextView.topAnchor.constraint(equalTo: topAnchor),
            comparisonsTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: textViewHeightMultiplier),
            comparisonsTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            swapsTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            swapsTextView.topAnchor.constraint(equalTo: comparisonsTextView.bottomAnchor),
            swapsTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: textViewHeightMultiplier),
            swapsTextView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func update(withStatistics statistics: SortStatistics) {
        comparisonsTextView.stringValue = "Comparisons: \(statistics.comparisons)"
        swapsTextView.stringValue = "Swaps: \(statistics.swaps)"
    }
}
