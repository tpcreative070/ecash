//
//  ECRSADecoder.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ECRSADecoder: NSObject {
    
    private var privateKey : SecKey?
    
    func decodeMessage(message : String, privKey : String) -> String {
        importSeckeyFromString(strPrivateKey: privKey)
        let blockSize = SecKeyGetBlockSize(privateKey!)
        var messageDecrypted = [UInt8](repeating: 0, count: blockSize)
        var messageDecryptedSize = blockSize
        let data = Data(base64Encoded: message)
        var messageEncrypted = [UInt8](data!)
        var status : OSStatus!
        status = SecKeyDecrypt(privateKey!, SecPadding.PKCS1, &messageEncrypted, messageDecryptedSize, &messageDecrypted, &messageDecryptedSize)
        if status != noErr {
            print("Decryption Error!")
        }
        let resultMessage : String = String(bytesNoCopy: &messageDecrypted, length: messageDecryptedSize, encoding: .utf8, freeWhenDone: true)!
        print("Decrypt message is: ", resultMessage)
        return resultMessage
    }
    
    private func importSeckeyFromString(strPrivateKey : String) {
        guard let data = Data.init(base64Encoded: strPrivateKey) else {
            print("Failed to convert String to Data")
            return
        }
        let keyDict:[NSObject:NSObject] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecAttrKeySizeInBits: NSNumber(value: 1024),
            kSecReturnPersistentRef: true as NSObject
        ]
        privateKey = SecKeyCreateWithData(data as CFData, keyDict as CFDictionary, nil)
    }
}
