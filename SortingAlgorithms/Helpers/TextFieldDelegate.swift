//
//  TextFieldDelegate.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 04.08.2023.
//

import Cocoa

class TextFieldDelegate: NSObject, NSTextFieldDelegate {
    
    let textFieldTextDidChangeHandler: ((NSTextField) -> Void)?
    
    init(textChangeHandler: ((NSTextField) -> Void)?) {
        self.textFieldTextDidChangeHandler = textChangeHandler
    }

    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else { return }
        textFieldTextDidChangeHandler?(textField)
    }
}
