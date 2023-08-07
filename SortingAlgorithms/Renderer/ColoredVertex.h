//
//  ColoredVertex.h
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 06.08.2023.
//

#ifndef ColoredVertex_h
#define ColoredVertex_h

#include <simd/simd.h>

typedef struct
{
    vector_float2 position;
    vector_float4 color;
} ColoredVertex;

#endif /* ColoredVertex_h */
