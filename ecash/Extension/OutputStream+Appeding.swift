//
//  OutputStream+.swift
//  ecash
//
//  Created by phong070 on 8/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension OutputStream {
    @discardableResult
    func write(_ string: String) -> Int {
        guard let data = string.data(using: .utf8) else { return -1 }
        return data.withUnsafeBytes { (buffer: UnsafePointer<UInt8>) -> Int in
            write(buffer, maxLength: data.count)
        }
    }
    
    @discardableResult
    func append(contentsOf url: URL) -> Int {
        guard let inputStream = InputStream(url: url) else { return -1 }
        inputStream.open()
        let bufferSize = 1_024 * 1_024
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        var bytes = 0
        var totalBytes = 0
        repeat {
            bytes = inputStream.read(&buffer, maxLength: bufferSize)
            if bytes > 0 {
                write(buffer, maxLength: bytes)
                totalBytes += bytes
            }
        } while bytes > 0
        
        inputStream.close()
        
        return bytes < 0 ? bytes : totalBytes
    }
}
