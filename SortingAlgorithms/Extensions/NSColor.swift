//
//  NSColor.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

extension NSColor {
    func multiply(by value: CGFloat) -> NSColor {
        guard let color = self.usingColorSpace(.deviceRGB) else { return self }
        let red = color.redComponent
        let green = color.greenComponent
        let blue = color.blueComponent
        let alpha = color.alphaComponent
        return NSColor(red: red * value, green: green * value, blue: blue * value, alpha: alpha)
    }
}
