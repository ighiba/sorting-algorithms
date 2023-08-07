//
//  Shaders.metal
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 06.08.2023.
//

#include <metal_stdlib>
using namespace metal;

#include "ColoredVertex.h"

struct VertexData
{
    float4 position [[position]];
    float4 color;
};

vertex VertexData vertexShader(uint vertexID [[vertex_id]],
                             constant ColoredVertex *vertices [[buffer(0)]])
{
    VertexData vertex_data;
    vertex_data.position = float4(vertices[vertexID].position.x, vertices[vertexID].position.y, 0, 1);
    vertex_data.color = vertices[vertexID].color;
    return vertex_data;
}

fragment float4 fragmentShader(const VertexData vertex_data [[stage_in]])
{
    return vertex_data.color;
}
