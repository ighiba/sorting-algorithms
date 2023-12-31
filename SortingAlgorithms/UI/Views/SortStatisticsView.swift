//
//  SortStatisticsView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 03.08.2023.
//

import Cocoa

class SortStatisticsView: NSView {
    
    var comparisonsTextView = NSTextField(labelWithString: "Comparisons: 0")
    var swapsTextView = NSTextField(labelWithString: "Swaps: 0")
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(comparisonsTextView)
        addSubview(swapsTextView)
        
        comparisonsTextView.translatesAutoresizingMaskIntoConstraints = false
        swapsTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            comparisonsTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            comparisonsTextView.topAnchor.constraint(equalTo: topAnchor),
            comparisonsTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            comparisonsTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            swapsTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            swapsTextView.topAnchor.constraint(equalTo: comparisonsTextView.bottomAnchor),
            swapsTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            swapsTextView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func update(withStatistics statistics: SortStatistics) {
        comparisonsTextView.stringValue = "Comparisons: \(statistics.comparisons)"
        swapsTextView.stringValue = "Swaps: \(statistics.swaps)"
    }
}
