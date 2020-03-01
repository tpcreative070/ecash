//
//  ECRSAKeyGenerator.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ECRSAKeyGenerator: NSObject {

    var publicKey : SecKey?
    var privateKey : SecKey?
    
    func generateKeys() {
        let parameters: [String: AnyObject] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: 1024 as AnyObject
        ]
        SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
    }
    
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
    
    func exportPrivateKey() -> String {
        var error:Unmanaged<CFError>?
        if let cfPrivateKeyData = SecKeyCopyExternalRepresentation(privateKey!, &error) {
            let privateKeyData : Data = cfPrivateKeyData as Data
            return privateKeyData.base64EncodedString()
        } else {
            print("Failed to export public key to string!!!")
            return String()
        }
    }
}
