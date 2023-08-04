//
//  QuickSort.swift
//  SortingAlgorithms
//
//  Created by Ivan Ghiba on 04.08.2023.
//

import Foundation

final class QuickSort: BaseSort {
    
    typealias RestArray = (left: [Int], right: [Int])
    
    override var timeInterval: TimeInterval { return 0.02 }
    
    override func start() {
        DispatchQueue.global().async {
            self.startQuickSort()
        }
    }
    
    private func startQuickSort() {
        let newArray = qsort(unsortedArray, restArray: ([],[]))
        handleCompletion(resultArray: newArray)
    }
    
    private func qsort(_ array: [Int], restArray: RestArray) -> [Int] {
        guard array.count >= 2 else { return array }
        let middleIndex = array.count / 2
        let pivot = array[middleIndex]
        let (less, greater) = partition(array, pivot: pivot, restArray: restArray)
        
        let restArrayForGreater = RestArray(restArray.left, [pivot] + greater + restArray.right)
        let lessSorted = qsort(less, restArray: restArrayForGreater)
        
        let restArrayForLess = RestArray(restArray.left + lessSorted + [pivot], restArray.right)
        let greaterSorted = qsort(greater, restArray: restArrayForLess)
        
        return lessSorted + [pivot] + greaterSorted
    }
    
    private func partition(_ array: [Int], pivot: Int, restArray: RestArray) -> ([Int], [Int]) {
        var arrayCopy = array
        var midleBuff: [Int] = []
        var less: [Int] = []
        var greater: [Int] = []
        
        var lastLessIndex: Int { restArray.left.count + less.count - 1  }
        var firstGreaterIndex: Int { lastLessIndex + midleBuff.count + arrayCopy.count + 1 }
        var pivotIndex: Int { lastLessIndex + midleBuff.count }
        
        var currentArraySnapshot: [Int] { restArray.left + less + midleBuff + arrayCopy + greater + restArray.right }
       
        while arrayCopy.count > 1 {
            var currentIndex = 0
            var swapIndex: Int? = nil
            
            if arrayCopy.first! < pivot {
                comparisonsCount.inc()
                less.append(arrayCopy.removeFirst())
                currentIndex = lastLessIndex
            } else if arrayCopy.last! > pivot {
                comparisonsCount.inc(2)
                greater = [arrayCopy.removeLast()] + greater
                currentIndex = firstGreaterIndex
            } else if arrayCopy.first! == pivot {
                comparisonsCount.inc(3)
                midleBuff.append(arrayCopy.removeFirst())
                currentIndex = pivotIndex
            } else if arrayCopy.last! == pivot {
                comparisonsCount.inc(4)
                midleBuff.append(arrayCopy.removeLast())
                currentIndex = pivotIndex
            } else {
                comparisonsCount.inc(4)
                less.append(arrayCopy.removeLast())
                greater = [arrayCopy.removeFirst()] + greater
                currentIndex = lastLessIndex
                swapIndex = firstGreaterIndex
            }

            handleSwap(currentArraySnapshot, currentIndex: currentIndex, swoppedIndex: swapIndex)
        }
                
        if arrayCopy.count == 1 {
            if arrayCopy.first! < pivot {
                comparisonsCount.inc()
                less.append(arrayCopy.removeFirst())
                swapsCount.inc()
            } else if arrayCopy.first! > pivot {
                comparisonsCount.inc(2)
                greater = [arrayCopy.removeFirst()] + greater
                swapsCount.inc()
            }
        }

        return (less, greater)
    }
}
