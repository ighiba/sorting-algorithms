//
//  UInt16NumberFormatter.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 04.08.2023.
//

import Foundation

class UInt16NumberFormatter: NumberFormatter {
    
    let minValue: UInt16
    let maxValue: UInt16
    
    init(minValue: UInt16, maxValue: UInt16) {
        self.minValue = minValue
        self.maxValue = maxValue
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        guard !partialString.isEmpty else { return true }
        
        if let value = UInt16(partialString) {
            return (value >= minValue && value <= maxValue)
        }
        
        return false
    }
}
