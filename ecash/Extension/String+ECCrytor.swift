//
//  ECAES256Crytor.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import BigInt

extension String {
    func aesEncrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = self.data(using: String.Encoding.utf8),
            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) {
            let keyLength              = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            var numBytesEncrypted :size_t = 0
            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      (data as NSData).bytes, data.count,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedString()
                return base64cryptString
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func aesDecrypt(key:String, iv:String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = key.data(using: String.Encoding.utf8),
            let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
            let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {
            let keyLength              = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      iv,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func genKeyFromUserPassword() -> String? {
        return self.padding(toLength: 32, withPad: "0", startingAt: 0)
    }
    
    func aesEncryptTransactionData(data: [UInt8], key : String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = Data(base64Encoded: key),
            //let data = self.data(using: String.Encoding.utf8),
            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) {
            let keyLength              = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            var numBytesEncrypted :size_t = 0
            let cryptStatus = CCCrypt(operation, algoritm, options,
                                      (keyData as NSData).bytes, keyLength,
                                      (keyData.subdata(in: 16..<keyData.count) as NSData).bytes,
                                      data, data.count,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedString()
                return base64cryptString
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func aesEncryptTransactionData(key : String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = Data(base64Encoded: key),
            let data = self.data(using: String.Encoding.utf8),
            let cryptData    = NSMutableData(length: Int((data.count)) + kCCBlockSizeAES128) {
            let keyLength              = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            var numBytesEncrypted :size_t = 0
            let cryptStatus = CCCrypt(operation, algoritm, options,
                                      (keyData as NSData).bytes, keyLength,
                                      (keyData.subdata(in: 16..<keyData.count) as NSData).bytes,
                                      (data as NSData).bytes, data.count,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                let base64cryptString = cryptData.base64EncodedString()
                return base64cryptString
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func aesDecryptTransactionData(key:String, options:Int = kCCOptionPKCS7Padding) -> String? {
        if let keyData = Data(base64Encoded: key),
            let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
            let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {
            let keyLength              = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      (keyData.subdata(in: 16..<keyData.count) as NSData).bytes,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                //let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                let unencryptedMessage = String(decoding: cryptData as Data, as: UTF8.self)
                return unencryptedMessage
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func aesDecryptTransactionDataBlock(key:String, options:Int = kCCOptionPKCS7Padding) -> Data? {
        if let keyData = Data(base64Encoded: key),
            let data = NSData(base64Encoded: self, options: .ignoreUnknownCharacters),
            let cryptData    = NSMutableData(length: Int((data.length)) + kCCBlockSizeAES128) {
            let keyLength              = size_t(kCCKeySizeAES256)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm:  CCAlgorithm = UInt32(kCCAlgorithmAES128)
            let options:   CCOptions   = UInt32(options)
            var numBytesEncrypted :size_t = 0
            
            let cryptStatus = CCCrypt(operation,
                                      algoritm,
                                      options,
                                      (keyData as NSData).bytes, keyLength,
                                      (keyData.subdata(in: 16..<keyData.count) as NSData).bytes,
                                      data.bytes, data.length,
                                      cryptData.mutableBytes, cryptData.length,
                                      &numBytesEncrypted)
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                //cryptData.length = Int(numBytesEncrypted)
                //let unencryptedMessage = String(data: cryptData as Data, encoding:String.Encoding.utf8)
                //let unencryptedMessage = String(decoding: cryptData as Data, as: UTF8.self)
                return cryptData as Data
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    
    
    func sha256Data() -> Data {
        guard let data = self.data(using: .utf8) else {
            return Data()
        }
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.bindMemory(to: UInt8.self).baseAddress.unsafelyUnwrapped, CC_LONG(data.count), &hash)
        }
        //Data(bytes: hash)
        return Data(bytes: hash, count: hash.count)
    }
    
    func sha256() -> String {
        guard let data = self.data(using: .utf8) else {
            return String()
        }
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.bindMemory(to: UInt8.self).baseAddress.unsafelyUnwrapped, CC_LONG(data.count), &hash)
        }
        return Data(bytes: hash, count: hash.count).base64EncodedString()
    }
    
    func sha256base64String() -> String {
        guard let data = Data(base64Encoded: self) else {
            return String()
        }
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress?.assumingMemoryBound(to: UInt8.self), CC_LONG(data.count), &hash)
        }
        return Data(bytes: hash, count: hash.count).base64EncodedString()
    }
    
    /*func sha256HexString() -> String {
     guard let data = self.data(using: .utf8) else {
     return String()
     }
     var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
     data.withUnsafeBytes {
     _ = CC_SHA256($0, CC_LONG(data.count), &hash)
     }
     
     return Data(bytes: hash).hexDigest()
     }*/
}
