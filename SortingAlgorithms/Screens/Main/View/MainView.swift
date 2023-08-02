//
//  MainView.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

private let popUpButtonWidht: CGFloat = 150
private let buttonsHorizontalOffset: CGFloat = 30

class MainView: NSView {
    
    let sortingBarsView = SortingBarsView()
    let sortListPopUp = SelectablePopUpButton()
    let startButton = NSButton(title: "Start", target: nil, action: nil)
    let shuffleButton = NSButton(title: "Shuffle", target: nil, action: nil)

    override init(frame: CGRect) {
        super.init(frame: NSRect(origin: .zero, size: .windowSize))
        setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        let buttonsLayoutGuide = NSLayoutGuide()
        self.addLayoutGuide(buttonsLayoutGuide)
        
        self.addSubview(sortingBarsView)
        self.addSubview(sortListPopUp)
        self.addSubview(startButton)
        self.addSubview(shuffleButton)
        
        sortingBarsView.translatesAutoresizingMaskIntoConstraints = false
        sortListPopUp.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sortingBarsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            sortingBarsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            sortingBarsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            sortingBarsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            buttonsLayoutGuide.topAnchor.constraint(equalTo: sortingBarsView.bottomAnchor),
            buttonsLayoutGuide.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            buttonsLayoutGuide.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            buttonsLayoutGuide.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            sortListPopUp.widthAnchor.constraint(equalToConstant: popUpButtonWidht),
            sortListPopUp.centerYAnchor.constraint(equalTo: buttonsLayoutGuide.centerYAnchor),
            sortListPopUp.trailingAnchor.constraint(equalTo: startButton.leadingAnchor, constant: -buttonsHorizontalOffset),
            
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: buttonsLayoutGuide.centerYAnchor),
            
            shuffleButton.centerYAnchor.constraint(equalTo: buttonsLayoutGuide.centerYAnchor),
            shuffleButton.leadingAnchor.constraint(equalTo: startButton.trailingAnchor, constant: buttonsHorizontalOffset)
        ])
    }
    
    func configurePopUpList(withItems items: [String], selectedItem: Int) {
        sortListPopUp.addItems(withTitles: items)
        sortListPopUp.selectItem(at: selectedItem)
    }
}
