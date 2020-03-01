//
//  Data+Array.swift
//  ecash
//
//  Created by phong070 on 8/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Data {
    init<T>(fromArray values: [T]) {
        var values = values
        self.init(buffer: UnsafeBufferPointer(start: &values, count: values.count))
    }
    
    func toArray<T>(type: T.Type) -> [T] {
        let value = self.withUnsafeBytes {
            $0.baseAddress?.assumingMemoryBound(to: T.self)
        }
        return [T](UnsafeBufferPointer(start: value, count: self.count / MemoryLayout<T>.stride))
    }

    //  let data = Data(fromArray: index)
    //  let bytes = data.toArray(type: UInt8.self)
}
