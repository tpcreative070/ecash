//
//  ECMD5HashCreator.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ECMD5HashCreator: NSObject {
    func MD5(string: String) -> String {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = digestData.withUnsafeMutableBytes { (digestBytes: UnsafeMutableRawBufferPointer) -> Void in
            messageData.withUnsafeBytes { (messageBytes: UnsafeRawBufferPointer) -> Void in
                CC_MD5(messageBytes.baseAddress, CC_LONG(messageData.count), digestBytes.bindMemory(to: UInt8.self).baseAddress)
            }
        }
        return digestData.base64EncodedString()
    }
}
