//
//  ECDSACryptor.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ECDSACryptor: NSObject {

    var publicKey : SecKey?
    var privateKey : SecKey?
    
    func generateKeys() {
        let privateKeyParams: [String: AnyObject] = [
            kSecAttrLabel as String: "privateLabel" as AnyObject,
            kSecAttrIsPermanent as String: true as AnyObject,
            kSecAttrApplicationTag as String: "applicationTag" as AnyObject
        ]
        // public key parameters
        let publicKeyParams: [String: AnyObject] = [
            kSecAttrLabel as String: "publicLabel" as AnyObject,
            kSecAttrIsPermanent as String: false as AnyObject,
            kSecAttrApplicationTag as String: "applicationTag" as AnyObject
        ]
        
        // global parameters
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
            kSecAttrKeySizeInBits as String: 256 as AnyObject,
            kSecPublicKeyAttrs as String: publicKeyParams as AnyObject,
            kSecPrivateKeyAttrs as String: privateKeyParams as AnyObject
        ]
        let status = SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
        if status != noErr {
            debugPrint("Decryption Error!")
        }
    }
    
    func exportPublicKey() -> String {
        var error:Unmanaged<CFError>?
        if let cfPublicKeyData = SecKeyCopyExternalRepresentation(publicKey!, &error) {
            let publicKeyData : Data = cfPublicKeyData as Data
            return publicKeyData.base64EncodedString()
        } else {
            debugPrint("Failed to export public key to string!!!")
            return String()
        }
    }
    
    func exportPrivateKey() -> String {
        var error:Unmanaged<CFError>?
        if let cfPrivateKeyData = SecKeyCopyExternalRepresentation(privateKey!, &error) {
            let privateKeyData : Data = cfPrivateKeyData as Data
            return privateKeyData.base64EncodedString()
        } else {
            debugPrint("Failed to export public key to string!!!")
            return String()
        }
    }
    
    func encodeMessage(message : String) -> String {
        let blockSize = SecKeyGetBlockSize(publicKey!)
        var messageEncrypted = [UInt8](repeating: 0, count: blockSize)
        var messageEncryptedSize = blockSize
        var status: OSStatus!
        status = SecKeyEncrypt(publicKey!, SecPadding.PKCS1, message, message.count, &messageEncrypted, &messageEncryptedSize)
        if status != noErr {
            debugPrint("Encryption Error!")
            return String()
        }
        let data = Data(_: messageEncrypted)
        let str : String = data.base64EncodedString()
        return str
    }
    
    func decodeMessage(message : String) -> String {
        let blockSize = SecKeyGetBlockSize(privateKey!)
        var messageDecrypted = [UInt8](repeating: 0, count: blockSize)
        var messageDecryptedSize = blockSize
        let data = Data(base64Encoded: message)
        var messageEncrypted = [UInt8](data!)
        var status : OSStatus!
        status = SecKeyDecrypt(privateKey!, SecPadding.PKCS1, &messageEncrypted, messageDecryptedSize, &messageDecrypted, &messageDecryptedSize)
        if status != noErr {
            debugPrint("Decryption Error!")
        }
        let resultMessage : String = String(bytesNoCopy: &messageDecrypted, length: messageDecryptedSize, encoding: .utf8, freeWhenDone: true)!
        debugPrint("Decrypt message is: ", resultMessage)
        return resultMessage
    }
}
