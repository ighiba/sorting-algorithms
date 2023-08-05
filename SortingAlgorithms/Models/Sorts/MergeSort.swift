//
//  MergeSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 05.08.2023.
//

import Foundation

final class MergeSort: BaseSort {
    
    typealias RestArray = (left: [Int], right: [Int])
        
    override func start() {
        DispatchQueue.global().async {
            self.startMergeSort()
        }
    }
    
    private func startMergeSort() {
        let newArray = mergeSort(unsortedArray, restArray: ([],[]))
        handleCompletion(resultArray: newArray)
    }
    
    private func mergeSort(_ array: [Int], restArray: RestArray) -> [Int] {
        guard array.count > 1 else { return array }

        let (left, right) = partition(array, restArray: restArray)
        
        let restArrayForSortLeft = RestArray(restArray.left, right + restArray.right)
        let leftSorted = mergeSort(left, restArray: restArrayForSortLeft)
        
        let restArrayForSortRight = RestArray(restArray.left + leftSorted, restArray.right)
        let rightSorted = mergeSort(right, restArray: restArrayForSortRight)

        return merge(leftSorted, rightSorted, restArray: (restArray.left, restArray.right))
    }
    
    private func partition(_ array: [Int], restArray: RestArray) -> ([Int], [Int]) {
        guard array.count > 1 else { return (array, []) }
        let middle = array.count / 2
        
        var left: [Int] = []
        var right: [Int] = []
        
        for i in 0 ..< array.count {
            if i < middle {
                left.append(array[i])
            } else {
                right.append(array[i])
            }
        }
        
        return (left, right)
    }
    
    private func merge(_ left: [Int], _ right: [Int], restArray: RestArray) -> [Int] {
        var result: [Int] = []
        
        var leftCopy = left
        var rightCopy = right

        while leftCopy.count > 0 && rightCopy.count > 0 {
            if leftCopy.first! > rightCopy.first! {
                comparisonsCount.inc()
                result.append(rightCopy.removeFirst())
            } else if leftCopy.first! < rightCopy.first! {
                comparisonsCount.inc(2)
                result.append(leftCopy.removeFirst())
            } else {
                comparisonsCount.inc(2)
                result.append(leftCopy.removeFirst())
                result.append(rightCopy.removeFirst())
            }
            
            let leftIndex = restArray.left.count + left.count - leftCopy.count
            let rightIndex = leftIndex + leftCopy.count + right.count - rightCopy.count
            
            handleSelect(restArray.left + left + right + restArray.right, indices: [leftIndex, rightIndex])
        }

        result += leftCopy.isEmpty ? rightCopy : leftCopy

        var resultCopy: [Int] = left + right
        var arraySnapshot: [Int] { return restArray.left + resultCopy + restArray.right }
        for i in 0 ..< result.count {
            resultCopy[i] = result[i]
            handleSwap(arraySnapshot, currentIndex: restArray.left.count + i)
        }
        
        return result
    }
}
