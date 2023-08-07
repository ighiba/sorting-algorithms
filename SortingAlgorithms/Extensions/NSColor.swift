//
//  NSColor.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 02.08.2023.
//

import Cocoa

extension NSColor {
    func multiply(by value: CGFloat) -> NSColor {
        let (r, g, b, a) = components()
        return NSColor(red: r * value, green: g * value, blue: b * value, alpha: a)
    }
    
    func floatComponents() -> (Float, Float, Float, Float) {
        let (r, g, b, a) = components()
        return (Float(r), Float(g), Float(b), Float(a))
    }
    
    func components() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        guard let color = self.usingColorSpace(.deviceRGB) else { return (1, 1, 1, 1) }
        return (
            color.redComponent,
            color.greenComponent,
            color.blueComponent,
            color.alphaComponent
        )
    }
}

extension NSColor {
    func toVertexColor() -> SIMD4<Float> {
        let (r, g, b, a) = self.floatComponents()
        return SIMD4(r, g, b ,a)
    }
}
