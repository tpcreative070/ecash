//
//  ECRSAEncoder.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ECRSAEncoder: NSObject {
    
    private var publicKey : SecKey?
    
    func exportPublicKey() -> String {
        var error:Unmanaged<CFError>?
        if let cfPublicKeyData = SecKeyCopyExternalRepresentation(publicKey!, &error) {
            let publicKeyData : Data = cfPublicKeyData as Data
            return publicKeyData.base64EncodedString()
        } else {
            print("Failed to export public key to string!!!")
            return String()
        }
    }
    
    func encodeMessageWith(strPublicKey : String, message : String) -> String {
        importSeckeyFromString(strPublicKey: strPublicKey)
        let blockSize = SecKeyGetBlockSize(publicKey!)
        var messageEncrypted = [UInt8](repeating: 0, count: blockSize)
        var messageEncryptedSize = blockSize
        var status: OSStatus!
        status = SecKeyEncrypt(publicKey!, SecPadding.PKCS1, message, message.count, &messageEncrypted, &messageEncryptedSize)
        if status != noErr {
            print("Encryption Error!")
            return String()
        }
        let data = Data(_: messageEncrypted)
        let str : String = data.base64EncodedString()
        return str
    }
    
    func importSeckeyFromString(strPublicKey : String) {
        let keyClass = kSecAttrKeyClassPublic
        let attributes: [String:Any] =
            [
                kSecAttrKeyClass as String: keyClass,
                kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                kSecAttrKeySizeInBits as String: 1024,
                kSecReturnPersistentRef as String: true as NSObject
            ]
        
        guard let secKeyData = Data.init(base64Encoded: strPublicKey) else {
            print("Error: invalid encodedKey, cannot extract data")
            return
        }
        guard let secKey = SecKeyCreateWithData(secKeyData as CFData, attributes as CFDictionary, nil) else {
            print("Error: Problem in SecKeyCreateWithData()")
            return
        }
        publicKey = secKey
    }
}
