//
//  ECSecp256k1.swift
//  eWallet
//
//  Created by phong070 on 8/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ECSecp256k1: NSObject {
    
    static func generatePublicKey(_privateKey : String?, compression : Bool) -> String? {
        guard let _privateKeyData = _privateKey else {
            return nil
        }
        guard var privateKeyData = Data(base64Encoded: _privateKeyData) else {
            return nil
        }
        
        if privateKeyData.count > 32 {
            privateKeyData.remove(at: 0)
        }
        
        let context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))
        let prvKey = [UInt8](privateKeyData)
        var pKey = secp256k1_pubkey()
        let result = secp256k1_ec_pubkey_create(context!, &pKey, prvKey)
        if result != 1 {
            return nil
        }
        let size = compression ? 33 : 65
        let pubkey = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        var s : size_t = size
        let res = secp256k1_ec_pubkey_serialize(context!, pubkey, &s, &pKey, compression ? UInt32(SECP256K1_EC_COMPRESSED) : UInt32(SECP256K1_EC_UNCOMPRESSED))
        if res != 1 {
            return nil
        }
        secp256k1_context_destroy(context)
        let data = Data(bytes: pubkey, count: size)
        //print(data.dataToHexString())
        free(pubkey)
        return data.base64EncodedString()
    }
    
    static func verifyPublicKey(_ publicKey : String?) -> Bool {
        guard let _publicKey = publicKey else {
            return false
        }
        guard let publicKeyData = Data(base64Encoded: _publicKey, options: .ignoreUnknownCharacters) else {
            return false
        }
        let pubKey = [UInt8](publicKeyData)
        let context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))
        var pKey = secp256k1_pubkey()
        let pubResult = secp256k1_ec_pubkey_parse(context!, &pKey, pubKey, publicKeyData.count)
        return pubResult == 1
    }
    
    static func signData(strMessage : String?, strPrivateKey : String?) -> String? {
        guard let _messageData = strMessage else { return nil }
        guard let _privateKeyData = strPrivateKey else { return nil }
        guard let messageData = _messageData.data(using: .utf8) else { return nil }
        guard var privateKeyData = Data(base64Encoded: _privateKeyData) else { return nil }
        if privateKeyData.count > 32 {
            privateKeyData.remove(at: 0)
        }
        
        let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))!
        defer { secp256k1_context_destroy(ctx) }
        let signature = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { signature.deallocate() }
        let status = messageData.withUnsafeBytes { ptr  in
            privateKeyData.withUnsafeBytes {
                secp256k1_ecdsa_sign(ctx, signature, (ptr.baseAddress?.assumingMemoryBound(to: UInt8.self))!, $0.bindMemory(to: UInt8.self).baseAddress.unsafelyUnwrapped, nil, nil)
            }
        }
        /**
         return data.withUnsafeBytes({ (rawBufferPointer: UnsafeRawBufferPointer) -> Int in
         let bufferPointer = rawBufferPointer.bindMemory(to: UInt8.self)
         return self.write(bufferPointer.baseAddress!, maxLength: data.count)
         })
         */
        guard status == 1 else { return nil }
        let normalizedsig = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { normalizedsig.deallocate() }
        secp256k1_ecdsa_signature_normalize(ctx, normalizedsig, signature)
        var length: size_t = 128
        var der = Data(count: length)
        guard der.withUnsafeMutableBytes({
            return secp256k1_ecdsa_signature_serialize_der(ctx, $0.bindMemory(to: UInt8.self).baseAddress.unsafelyUnwrapped, &length, normalizedsig)
            
        }) == 1 else { return nil }
        
        der.count = length
        return der.base64EncodedString()
        /*
         _ = digestData.withUnsafeMutableBytes { (digestBytes: UnsafeMutableRawBufferPointer) -> Void in
         messageData.withUnsafeBytes { (messageBytes: UnsafeRawBufferPointer) -> Void in
         CC_MD5(messageBytes.baseAddress, CC_LONG(messageData.count), digestBytes.bindMemory(to: UInt8.self).baseAddress)
         }
         }
         */
    }
    
    static func signData(data: Data, strPrivateKey: String) -> String? {
        guard var privateKeyData = Data(base64Encoded: strPrivateKey) else {
            return nil
        }
        if privateKeyData.count > 32 {
            privateKeyData.remove(at: 0)
        }
        
        let ctx = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))!
        defer {secp256k1_context_destroy(ctx)}
        let signature = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer {
            signature.deallocate()
        }
        let status = data.withUnsafeBytes { ptr in
            privateKeyData.withUnsafeBytes({
                secp256k1_ecdsa_sign(ctx, signature, (ptr.baseAddress?.assumingMemoryBound(to: UInt8.self))!, $0.bindMemory(to: UInt8.self).baseAddress.unsafelyUnwrapped, nil, nil)
            })
            
        }
        guard status == 1 else {return nil}
        let normalizedsig = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { normalizedsig.deallocate() }
        secp256k1_ecdsa_signature_normalize(ctx, normalizedsig, signature)
        var length: size_t = 128
        var der = Data(count: length)
        guard der.withUnsafeMutableBytes({ return secp256k1_ecdsa_signature_serialize_der(ctx, $0.bindMemory(to: UInt8.self).baseAddress.unsafelyUnwrapped, &length, normalizedsig) }) == 1 else { return nil }
        der.count = length
        return der.base64EncodedString()
    }
    
    static func verifySignedData(strSig: String?, msgData: Data?, strPublicKey: String?) -> Bool {
        guard let sigData = Data(base64Encoded: strSig!, options: .ignoreUnknownCharacters) else { return false }
        guard let messageData = msgData else { return false }
        guard let publicKeyData = Data(base64Encoded: strPublicKey!, options: .ignoreUnknownCharacters) else { return false }
        let context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_VERIFY) | UInt32(SECP256K1_CONTEXT_SIGN))
        let sig = [UInt8](sigData)
        let msg = [UInt8](messageData)
        let pubKey = [UInt8](publicKeyData)
        var pKey = secp256k1_pubkey()
        let pubResult = secp256k1_ec_pubkey_parse(context!, &pKey, pubKey, publicKeyData.count)
        if pubResult != 1 {
            return false
        }
        var sig_ecdsa = secp256k1_ecdsa_signature()
        let sigResult = secp256k1_ecdsa_signature_parse_der(context!, &sig_ecdsa, sig, sigData.count)
        if sigResult != 1 {
            return false
        }
        let normalizedsig = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { normalizedsig.deallocate() }
        secp256k1_ecdsa_signature_normalize(context!, normalizedsig, &sig_ecdsa)
        let result = secp256k1_ecdsa_verify(context!, normalizedsig, msg, &pKey)
        secp256k1_context_destroy(context)
        return result == 1
    }
    
    static func verifySignedData(strSig : String?, strMessage : String?, strPublicKey : String?) -> Bool {
        guard let _sigData = strSig else { return false }
        guard let _messageData = strMessage else { return false }
        guard let _publicKeyData = strPublicKey else { return false }
        guard let sigData = Data(base64Encoded: _sigData,options: .ignoreUnknownCharacters) else { return false }
        guard let messageData = _messageData.data(using: .utf8) else { return false }
        guard let publicKeyData = Data(base64Encoded: _publicKeyData, options: .ignoreUnknownCharacters) else { return false }
        let context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_VERIFY) | UInt32(SECP256K1_CONTEXT_SIGN))
        let sig = [UInt8](sigData)
        let msg = [UInt8](messageData)
        let pubKey = [UInt8](publicKeyData)
        var pKey = secp256k1_pubkey()
        let pubResult = secp256k1_ec_pubkey_parse(context!, &pKey, pubKey, publicKeyData.count)
        if pubResult != 1 {
            return false
        }
        var sig_ecdsa = secp256k1_ecdsa_signature()
        let sigResult = secp256k1_ecdsa_signature_parse_der(context!, &sig_ecdsa, sig, sigData.count)
        if sigResult != 1 {
            return false
        }
        let normalizedsig = UnsafeMutablePointer<secp256k1_ecdsa_signature>.allocate(capacity: 1)
        defer { normalizedsig.deallocate() }
        let result = secp256k1_ecdsa_verify(context!, normalizedsig, msg, &pKey)
        secp256k1_context_destroy(context)
        return result == 1
    }
    
    static func generateSharedKey(strPrivateKey : String?, strPublicKey : String?) -> String? {
        guard let _privateKey = strPrivateKey else { return nil }
        guard let _publicKey = strPublicKey else { return nil }
        guard let privateKey = Data(base64Encoded: _privateKey, options: .ignoreUnknownCharacters) else { return nil }
        guard let publicKey = Data(base64Encoded: _publicKey, options: .ignoreUnknownCharacters) else { return nil }
        let context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN))
        let pubK = [UInt8](publicKey)
        let priK = [UInt8](privateKey)
        let shared = UnsafeMutablePointer<UInt8>.allocate(capacity: 32)
        var pKey = secp256k1_pubkey()
        let pubResult = secp256k1_ec_pubkey_parse(context!, &pKey, pubK, publicKey.count)
        if pubResult != 1 {
            return nil
        }
        let result = secp256k1_ecdh(context!, shared, &pKey, priK)
        if result != 1 {
            return nil
        }
        secp256k1_context_destroy(context)
        let data = Data(bytes: shared, count: 32)
        free(shared)
        return data.base64EncodedString()
    }
}
