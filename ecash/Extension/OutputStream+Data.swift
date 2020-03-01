//
//  OutputStream+Data.swift
//  ecash
//
//  Created by phong070 on 8/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension OutputStream {
    func write(data: Data) -> Int {
        return data.withUnsafeBytes({ (rawBufferPointer: UnsafeRawBufferPointer) -> Int in
            let bufferPointer = rawBufferPointer.bindMemory(to: UInt8.self)
            return self.write(bufferPointer.baseAddress!, maxLength: data.count)
        })
    }
}
