//
//  VertexFactory.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 06.08.2023.
//

import Foundation

protocol VertexFactory: AnyObject {
    func makeQuadrangle(_ p1: SIMD4<Float>, _ p2: SIMD4<Float>, _ p3: SIMD4<Float>, _ p4: SIMD4<Float>, color: SIMD4<Float>) -> [Vertex]
    func makeTrinagle(_ p1: SIMD4<Float>, _ p2: SIMD4<Float>, _ p3: SIMD4<Float>, color: SIMD4<Float>) -> [Vertex]
}

class VertexFactoryImpl: VertexFactory {
    func makeQuadrangle(_ p1: SIMD4<Float>, _ p2: SIMD4<Float>, _ p3: SIMD4<Float>, _ p4: SIMD4<Float>, color: SIMD4<Float>) -> [Vertex] {
        return makeTrinagle(p1, p2, p3, color: color) + makeTrinagle(p3, p4, p1, color: color)
    }
    
    func makeTrinagle(_ p1: SIMD4<Float>, _ p2: SIMD4<Float>, _ p3: SIMD4<Float>, color: SIMD4<Float>) -> [Vertex] {
        return [Vertex(position: p1, color: color), Vertex(position: p2, color: color), Vertex(position: p3, color: color)]
    }
}
