//
//  ECSecp256k1KeyGenerator.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit

class ECSecp256k1KeyGenerator: NSObject {
    
    private(set) var privateKey = String()
    private(set) var publicKey = String()
    
    func generateKeyPair() -> Bool {
        guard let prvKey = generatePrivateKey() else {
            return false
        }
        privateKey = prvKey
        guard let pubKey = ECSecp256k1.generatePublicKey(_privateKey: privateKey, compression: false) else {
            return false
        }
        publicKey = pubKey
        return true
    }
    
    private func generatePrivateKey() -> String? {
        func check(_ vch: [UInt8]) -> Bool {
            let max: [UInt8] = [
                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE,
                0xBA, 0xAE, 0xDC, 0xE6, 0xAF, 0x48, 0xA0, 0x3B,
                0xBF, 0xD2, 0x5E, 0x8C, 0xD0, 0x36, 0x41, 0x40
            ]
            var fIsZero = true
            for byte in vch where byte != 0 {
                fIsZero = false
                break
            }
            if fIsZero {
                return false
            }
            for (index, byte) in vch.enumerated() {
                if byte < max[index] {
                    if(vch[0] > 0x7F){
                        return false
                    }
                    else{
                        return true
                    }
                }
                if byte > max[index] {
                    return false
                }
            }
            if(vch[0] > 0x7F){
                return false
            }
            else{
                return true
            }
        }
        let count = 32
        var key = Data(count: count)
        var status: Int32 = 0
        repeat {
            //status = key.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, count, $0) }
            //status = key.withUnsafeMutableBytes(<#T##body: (UnsafeMutableRawBufferPointer) throws -> ResultType##(UnsafeMutableRawBufferPointer) throws -> ResultType#>)
            status = key.withUnsafeMutableBytes{(SecRandomCopyBytes(kSecRandomDefault, count, $0.bindMemory(to: UInt32.self).baseAddress!))}
        } while (status != 0 || !check([UInt8](key)))
        return key.base64EncodedString()
        
    }
}
