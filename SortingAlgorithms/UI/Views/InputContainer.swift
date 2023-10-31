//
//  InputContainer.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 04.08.2023.
//

import Cocoa

private let labelWidth: CGFloat = 65
private let textFieldWidth: CGFloat = 55
private let verticalOffset: CGFloat = 10

class InputContainer: NSView {
    
    var arraySizeTextFieldDelegate: NSTextFieldDelegate? {
        didSet {
            arraySizeTextField.delegate = arraySizeTextFieldDelegate
        }
    }
    
    var delayTextFieldDelegate: NSTextFieldDelegate? {
        didSet {
            delayTextField.delegate = delayTextFieldDelegate
        }
    }
    
    let arraySizeLabel = NSTextField(labelWithString: "Array size: ")
    let delayLabel = NSTextField(labelWithString: "Delay, ms: ")
    
    let arraySizeTextField: NSTextField = {
        let textField = NSTextField()
        textField.placeholderString = "min: 10"
        textField.refusesFirstResponder = true
        textField.formatter = UInt16NumberFormatter(minValue: 1, maxValue: 1024)
        return textField
    }()
    
    let delayTextField: NSTextField = {
        let textField = NSTextField()
        textField.placeholderString = "min: 5"
        textField.refusesFirstResponder = true
        textField.formatter = UInt16NumberFormatter(minValue: 1, maxValue: 1000)
        return textField
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let arraySizeStack = NSStackView(views: [arraySizeLabel, arraySizeTextField])
        let delayStack = NSStackView(views: [delayLabel, delayTextField])

        addSubview(arraySizeStack)
        addSubview(delayStack)
        
        arraySizeLabel.translatesAutoresizingMaskIntoConstraints = false
        delayLabel.translatesAutoresizingMaskIntoConstraints = false
        arraySizeTextField.translatesAutoresizingMaskIntoConstraints = false
        delayTextField.translatesAutoresizingMaskIntoConstraints = false
        arraySizeStack.translatesAutoresizingMaskIntoConstraints = false
        delayStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arraySizeLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            delayLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            delayTextField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            arraySizeTextField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            
            arraySizeStack.topAnchor.constraint(equalTo: topAnchor),
            arraySizeStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
            arraySizeStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: -verticalOffset / 2),
            arraySizeStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            delayStack.topAnchor.constraint(equalTo: arraySizeStack.bottomAnchor, constant: verticalOffset),
            delayStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
            delayStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5, constant: -verticalOffset / 2),
            delayStack.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    private func setupStyle() {
        arraySizeTextField.focusRingType = .none
        delayTextField.focusRingType = .none
    }
}
