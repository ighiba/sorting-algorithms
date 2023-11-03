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
private let stackHeightMultiplier: CGFloat = 0.5

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
    
    // MARK: - Views
    
    private let arraySizeStack = NSStackView()
    private let delayStack = NSStackView()
    
    private let arraySizeLabel = NSTextField(labelWithString: "Array size: ")
    private let delayLabel = NSTextField(labelWithString: "Delay, ms: ")
    
    private let arraySizeTextField: NSTextField = {
        let textField = NSTextField()
        textField.placeholderString = "min: 10"
        textField.refusesFirstResponder = true
        textField.formatter = UInt16NumberFormatter(minValue: 1, maxValue: 1024)
        return textField
    }()
    
    private let delayTextField: NSTextField = {
        let textField = NSTextField()
        textField.placeholderString = "min: 5"
        textField.refusesFirstResponder = true
        textField.formatter = UInt16NumberFormatter(minValue: 1, maxValue: 1000)
        return textField
    }()
    
    // MARK: - Init
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupViews()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    private func setupViews() {
        arraySizeStack.addArrangedSubviews([arraySizeLabel, arraySizeTextField])
        delayStack.addArrangedSubviews([delayLabel, delayTextField])
        
        addSubview(arraySizeStack)
        addSubview(delayStack)
    }
    
    private func setupLayout() {
        arraySizeLabel.translatesAutoresizingMaskIntoConstraints = false
        arraySizeTextField.translatesAutoresizingMaskIntoConstraints = false
        delayLabel.translatesAutoresizingMaskIntoConstraints = false
        delayTextField.translatesAutoresizingMaskIntoConstraints = false
        arraySizeStack.translatesAutoresizingMaskIntoConstraints = false
        delayStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arraySizeLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            arraySizeTextField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            
            delayLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            delayTextField.widthAnchor.constraint(equalToConstant: textFieldWidth),

            arraySizeStack.topAnchor.constraint(equalTo: topAnchor),
            arraySizeStack.widthAnchor.constraint(equalTo: widthAnchor),
            arraySizeStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: stackHeightMultiplier, constant: -verticalOffset / 2),
            arraySizeStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            delayStack.topAnchor.constraint(equalTo: arraySizeStack.bottomAnchor, constant: verticalOffset),
            delayStack.widthAnchor.constraint(equalTo: widthAnchor),
            delayStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: stackHeightMultiplier, constant: -verticalOffset / 2),
            delayStack.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    private func setupStyle() {
        arraySizeTextField.focusRingType = .none
        delayTextField.focusRingType = .none
    }
    
    func setInputIsEnabled(_ isEnabled: Bool) {
        arraySizeTextField.isEnabled = isEnabled
        delayTextField.isEnabled = isEnabled
    }
    
    func setInputValues(arraySize: UInt16, delay: UInt16) {
        arraySizeTextField.stringValue = "\(arraySize)"
        delayTextField.stringValue = "\(delay)"
    }
}
