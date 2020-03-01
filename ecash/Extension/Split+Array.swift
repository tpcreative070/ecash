//
//  Split+Array.swift
//  ecash
//
//  Created by phong070 on 12/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Collection {
    func chunked(by distance: Int) -> [[Element]] {
        precondition(distance > 0, "distance must be greater than 0") // prevents infinite loop

        var index = startIndex
        let iterator: AnyIterator<Array<Element>> = AnyIterator({
            let newIndex = self.index(index, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex
            defer { index = newIndex }
            let range = index ..< newIndex
            return index != self.endIndex ? Array(self[range]) : nil
        })
        return Array(iterator)
    }
}

extension Array {
    func chunked(by distance: Int) -> [[Element]] {
        let indicesSequence = stride(from: startIndex, to: endIndex, by: distance)
        let array: [[Element]] = indicesSequence.map {
            let newIndex = $0.advanced(by: distance) > endIndex ? endIndex : $0.advanced(by: distance)
            //let newIndex = self.index($0, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex // also works
            return Array(self[$0 ..< newIndex])
        }
        return array
    }

}
