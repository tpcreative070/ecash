//
//  InputStream+Data.swift
//  ecash
//
//  Created by phong070 on 8/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension InputStream {
    func read(maxLength length: Int) throws -> Data {
        var buffer = [UInt8](repeating: 0, count: length)
        let result = self.read(&buffer, maxLength: buffer.count)
        if result < 0 {
            throw self.streamError ?? POSIXError(.EIO)
        } else {
            return Data(buffer.prefix(result))
        }
    }
}
