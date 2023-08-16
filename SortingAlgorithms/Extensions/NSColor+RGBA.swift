//
//  NSColor+RGBA.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 16.08.2023.
//

import Cocoa

extension NSColor {
    func toRGBA() -> RGBA {
        let (r, g, b, a) = floatComponents()
        return RGBA(r, g, b ,a)
    }
}
