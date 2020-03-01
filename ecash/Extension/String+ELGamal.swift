//
//  String+ELGamal.swift
//  ecash
//
//  Created by phong070 on 8/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit
import BigInt

extension String {
    /*
     Get array's bytes info from one point to curve
     Input: ProjectivePoint
     Output: Array byte have 65 elements
     */
    func getEncode(ecpoint: ProjectivePoint<WeierstrassCurve<NaivePrimeField<U256>>>) -> Data {
        let bytesX = ecpoint.toAffine().X.bytes
        let bytesY = ecpoint.toAffine().Y.bytes
        var PO = bytesX[0..<bytesX.count]
        PO.append(bytesY)
        PO.insert(0x04, at: 0)
        return PO
    }
    /*
     Get curve's point of info from array bytes
     Input: Array bytes have 65 element or publickey
     Output: AffinePoint
     */
    func getDecode(data: Data) -> AffinePoint<WeierstrassCurve<NaivePrimeField<U256>>> {
        let POX = data[1..<data.count/2 + 1]
        let POY = data[data.count/2+1..<data.count]
        let ecpoint = secp256k1Curve.toPoint(BigUInt(POX), BigUInt(POY))
        return ecpoint!
    }
    
    func getLength(length: Int) -> String{
        if(length < 1000){
            return String(format: "%03d", length)
        }
        else{
            return ""
        }
    }
    
    /*
     Hàm lấy ra các phần tử của eCash
     Input: Mảng bytes
     Output: Mảng String 3 phần tử(Thông tin chi tiết | Chữ ký phát hành | Chữ ký lưu hành)
     */
    func SpliteCashElement(blockDataDetail: [UInt8]) -> [String]?{
        var block = blockDataDetail
        var eCashDetail: [String]! = ["","",""]
        var b1StrHeader:[UInt8] =  [UInt8].init(repeating: 0, count: 3)
        b1StrHeader.replaceSubrange(0...2, with: block[0...2])
        guard let b1len = Int(String(bytes: b1StrHeader, encoding:.utf8)!) else { return [String].init() }
        block.removeSubrange(0...2)
        var b1StrBody:[UInt8] = [UInt8].init(repeating: 0, count: b1len)
        b1StrBody.replaceSubrange(0...b1len-1, with: block[0...b1len-1])
        block.removeSubrange(0...b1len-1)
        eCashDetail[0] = String(bytes: b1StrBody, encoding: .utf8)!
        
        var b2StrHeader:[UInt8] =  [UInt8].init(repeating: 0, count: 3)
        b2StrHeader.replaceSubrange(0...2, with: block[0...2])
        guard let b2len = Int(String(bytes: b2StrHeader, encoding:.utf8)!) else { return [String].init() }
        block.removeSubrange(0...2)
        var b2StrBody:[UInt8] = [UInt8].init(repeating: 0, count: b2len)
        b2StrBody.replaceSubrange(0...b2len-1, with: block[0...b2len-1])
        block.removeSubrange(0...b2len-1)
        eCashDetail[1] = NSData(bytes: b2StrBody, length: b2StrBody.count).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        var b3StrHeader:[UInt8] =  [UInt8].init(repeating: 0, count: 3)
        b3StrHeader.replaceSubrange(0...2, with: block[0...2])
        guard let b3len = Int(String(bytes: b3StrHeader, encoding:.utf8)!) else { return [String].init() }
        block.removeSubrange(0...2)
        var b3StrBody:[UInt8] = [UInt8].init(repeating: 0, count: b3len)
        b3StrBody.replaceSubrange(0...b3len-1, with: block[0...b3len-1])
        block.removeSubrange(0...b3len-1)
        eCashDetail[2] = NSData(bytes: b3StrBody, length: b3StrBody.count).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return eCashDetail
    }
    
    /*
     Hàm lấy ra các tờ eCash từ mảng Data
     Input: Mảng Data
     Output: Mảng 2 chiểu chứa các tờ eCash
     */
    func spliteCashBlock(blockData: Data) -> [[UInt8]]?{
        var block = blockData
        var eCash: [[UInt8]] = [[UInt8]]()
        while block.count > 0{
            var blockLength:[UInt8] =  [UInt8].init(repeating: 0, count: 3)
            blockLength.replaceSubrange(0...2, with: block[0...2])
            if(blockLength == [UInt8].init(repeating: 0, count: 3)){
                break
            }
            guard let len = Int(String(bytes: blockLength, encoding:.utf8)!) else { return [[UInt8]].init() }
            block.removeSubrange(0...2)
            var blockBody:[UInt8] = [UInt8].init(repeating: 0, count: len)
            blockBody.replaceSubrange(0...len-1, with: block[0...len-1])
            block.removeSubrange(0...len-1)
            eCash.append(blockBody)
        }
        return eCash
    }
    
    /*
     Hàm giải mã khối dữ liệu nhận được để phân tích ra từng tờ eCash
     Input: Khoá private & khối dữ liệu
     Output: Mảng 2 chiểu chứa các tờ eCash
     */
    func decryptV2(receiverPrivatekey: String, blockEncrypt: [String]) -> [[String]]{
        var result: [[String]] = [[String]].init()
        let decData = self.elGamalDecryptData(receiverPrivateKey: receiverPrivatekey, blockEncrypt: blockEncrypt)!
        let eCashBlock: [[UInt8]] = spliteCashBlock(blockData: decData)!
        for i in 0...eCashBlock.count - 1 {
            result.append(SpliteCashElement(blockDataDetail: eCashBlock[i])!)
            debugPrint("\(result[i])")
        }
        return result
    }
    
    /*
     Hàm mã hoá các tờ eCash sau khi ghép thành mảng byte
     Input: Khoá public & mảng các tờ eCash
     Output: Mảng String chứa M1, M2 & Khối dữ liệu mã hoá
     */
    func encryptV2(receiverPublickey: String, cashArray: [[String]]) -> [String]{
        var baos = [UInt8](repeating: 0, count: 0)
        for(_, item) in cashArray.enumerated(){
            let b1 =  [UInt8](item[0].utf8)
            let b1Str = item[0].getLength(length: b1.count)
            let b1StrInByteArr = [UInt8](b1Str.utf8)
            
            let b2 = Data(base64Encoded: item[1])
            let b2Str = item[1].getLength(length: b2!.count)
            let b2StrInByteArr = [UInt8](b2Str.utf8)
            
            let b3 = Data(base64Encoded: item[2])
            let b3Str = item[1].getLength(length: b3!.count)
            let b3StrInByteArr = [UInt8](b3Str.utf8)
            
            let header = b1.count + b2!.count + b3!.count + 9
            let headerStr = String(header).getLength(length: header)
            let headerStrInByteArr = [UInt8](headerStr.utf8)
            baos.append(contentsOf: headerStrInByteArr)
            baos.append(contentsOf: b1StrInByteArr)
            baos.append(contentsOf: b1)
            baos.append(contentsOf: b2StrInByteArr)
            baos.append(contentsOf: b2!)
            baos.append(contentsOf: b3StrInByteArr)
            baos.append(contentsOf: b3!)
        }
        //var baosStr = Data(baos).base64EncodedString()
        //var baosStr = String(decoding: baos, as: UTF8.self)
        let encData: [String]! = self.elGamalEncrypt(receiverPublickey: receiverPublickey, rawData: baos)
        debugPrint("m1 data: \(encData[0])")
        debugPrint("m2 data: \(encData[1])")
        debugPrint("enc data: \(encData[2])")
        return encData
    }

    /*
     Hàm giải mã theo thuật toán Elgammal
     Input:
     1. Khoá private
     2. Mảng String 3 phần tử
     - ECPoint M1
     - ECPoint M2
     - Khối dữ liệu mã hoá
     
     Output: Kết quả giải mã
     */
    func elGamalDecryptData(receiverPrivateKey: String, blockEncrypt: [String]) -> Data? {
        var dataDecrypt = Data.init()
        let m1Bytes = Data(base64Encoded: blockEncrypt[0])
        let m1Decrypt = getDecode(data: m1Bytes!)
        let m2Bytes = Data(base64Encoded: blockEncrypt[1])
        let m2Decrypt = getDecode(data: m2Bytes!)
        guard let priKey2 = Data(base64Encoded: receiverPrivateKey, options: .ignoreUnknownCharacters) else { return dataDecrypt }
        let curve = secp256k1Curve
        let pointDecrypt = curve.sub(m2Decrypt.toProjective(), curve.mul(NativeU256(BigUInt(priKey2)), m1Decrypt) )
        let pointDecryptByte = getEncode(ecpoint: pointDecrypt)
        let AESDecrypt = pointDecryptByte[pointDecryptByte.count/2+1..<pointDecryptByte.count]
        dataDecrypt = blockEncrypt[2].aesDecryptTransactionDataBlock(key: AESDecrypt.base64EncodedString())!
        //print("decryptText: \(dataDecrypt)")
        return dataDecrypt
    }
    
    /*
     Decrypted Elgammal algorithm
     Input:
     1. private key
     2. Array string have 3 elements
     - ECPoint M1
     - ECPoint M2
     - Block encrypt
     
     Output: Result decypted
     */
    func elGamalDecrypt(receiverPrivateKey: String, blockEncrypt: [String]) -> String? {
        var dataDecrypt = ""
        let m1Bytes = Data(base64Encoded: blockEncrypt[0])
        let m1Decrypt = getDecode(data: m1Bytes!)
        let m2Bytes = Data(base64Encoded: blockEncrypt[1])
        let m2Decrypt = getDecode(data: m2Bytes!)
        guard let priKey2 = Data(base64Encoded: receiverPrivateKey, options: .ignoreUnknownCharacters) else { return dataDecrypt }
        let curve = secp256k1Curve
        let pointDecrypt = curve.sub(m2Decrypt.toProjective(), curve.mul(NativeU256(BigUInt(priKey2)), m1Decrypt) )
        let pointDecryptByte = getEncode(ecpoint: pointDecrypt)
        let AESDecrypt = pointDecryptByte[pointDecryptByte.count/2+1..<pointDecryptByte.count]
        dataDecrypt = blockEncrypt[2].aesDecryptTransactionData(key: AESDecrypt.base64EncodedString())!
        //print("decryptText: \(dataDecrypt)")
        return dataDecrypt
    }

    
    /*
     Encrypted Elgammal algorithm
     Input:
     1. String value
     2. That's public key of receiver
     
     Output: Array string have 3 elements
     - ECPoint M1
     - ECPoint M2
     - Block encypted
     */
    func elGamalEncrypt(receiverPublickey: String) -> [String]{
        var arr: [String]! = ["","",""]
        //Khoi tao duong cong
        let curve = secp256k1Curve
        let generatorX = BigUInt("79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798", radix: 16)!
        let generatorY = BigUInt("483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8", radix: 16)!
        guard let G = curve.toPoint(generatorX, generatorY) else {return arr}
        let n = NativeU256(BigUInt.randomInteger(lessThan: BigUInt("fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", radix: 16)!))
        let k = NativeU256(BigUInt.randomInteger(lessThan: BigUInt("fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", radix: 16)!))
        let m1ECPoint = curve.mul(n, G)
        guard let receiverPubKey = Data(base64Encoded: receiverPublickey, options: .ignoreUnknownCharacters) else { return arr}
        let kECP = curve.mul(k, G)
        let m2ECPoint = curve.add(kECP, curve.mul(n, getDecode(data: receiverPubKey)) )
        let keyAES = kECP.toAffine().Y.bytes
        arr[0] = getEncode(ecpoint: m1ECPoint).base64EncodedString()
        arr[1] = getEncode(ecpoint: m2ECPoint).base64EncodedString()
        arr[2] = self.aesEncryptTransactionData(key: keyAES.base64EncodedString())!
        return arr
    }
    
    /*
     Hàm mã hoá theo thuật toán Elgammal
     Input:
     1. String cần mã hoá
     2. Khoá public của người nhận
     
     Output: Mảng string 3 phần tử
     - ECPoint M1
     - ECPoint M2
     - Khối dữ liệu mã hoá
     */
    func elGamalEncrypt(receiverPublickey: String, rawData: [UInt8]) -> [String]{
        var arr: [String]! = ["","",""]
        //Khoi tao duong cong
        let curve = secp256k1Curve
        let generatorX = BigUInt("79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798", radix: 16)!
        let generatorY = BigUInt("483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8", radix: 16)!
        guard let G = curve.toPoint(generatorX, generatorY) else {return arr}
        let n = NativeU256(BigUInt.randomInteger(lessThan: BigUInt("fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", radix: 16)!))
        let k = NativeU256(BigUInt.randomInteger(lessThan: BigUInt("fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", radix: 16)!))
        let m1ECPoint = curve.mul(n, G)
        guard let receiverPubKey = Data(base64Encoded: receiverPublickey, options: .ignoreUnknownCharacters) else { return arr}
        let kECP = curve.mul(k, G)
        let m2ECPoint = curve.add(kECP, curve.mul(n, getDecode(data: receiverPubKey)) )
        let keyAES = kECP.toAffine().Y.bytes
        arr[0] = getEncode(ecpoint: m1ECPoint).base64EncodedString()
        arr[1] = getEncode(ecpoint: m2ECPoint).base64EncodedString()
        arr[2] = self.aesEncryptTransactionData(data: rawData, key: keyAES.base64EncodedString())!
        return arr
    }


}
