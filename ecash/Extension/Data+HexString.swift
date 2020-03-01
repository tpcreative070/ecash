//
//  Data+HexString.swift
//  eWallet
//
//  Created by FPT Mac on 7/12/18.
//  Copyright © 2018 Hung Vu. All rights reserved.
//

import UIKit
import BigInt

extension String {
    func hexStringToData() -> Data? {
        var data = Data(capacity: self.count / 2)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        guard data.count > 0 else { return nil }
        return data
    }
}

extension Data {
    func dataToHexString() -> String {
        return map { String(format: "%02x", $0) }
            .joined(separator: "")
    }
}
