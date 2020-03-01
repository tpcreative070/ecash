//
//  eWalletTests.swift
//  eWalletTests
//
//  Created by Hung Vu on 5/28/18.
//  Copyright © 2018 Hung Vu. All rights reserved.
//

import XCTest
import BigInt
//import secp256k1
//import CommonCrypto
//import EllipticCurve
@testable import ecash

class eWalletTests: XCTestCase {
    
    //find_ecash_recursive
    //findeCashs
    //TestfindeCashs
    //Please use those things
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testExample() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let expireDate = formatter.date(from: "20180824")
        let today = Date()
        
        let calendar = Calendar.current
        
        let component = calendar.dateComponents([.year, .month, .day], from: expireDate!)
        let expire = calendar.date(from: component)
        
        let todayComponent = calendar.dateComponents([.year, .month, .day], from: today)
        let newToday = calendar.date(from: todayComponent)
        
        let res = (newToday?.compare(expire!))!
        
                switch res {
                case .orderedAscending:
                    print("future")
                case .orderedDescending:
                    print("past")
                default:
                    print("today")
                }
        
    }
    
    func findeCash()
    {
        
        let  eCashList: [Int32] = [10000, 10000, 20000, 50000, 100000]

        for ecash in eCashList {
            print(ecash)
        }
    }
    
    
    
    func find_ecash_recursive(myList: [ECECash], targetNumber:Int, listPartial: [ECECash]){
        for (index, item) in myList.enumerated()
        {
            var countIndex = 0
            var remaining:[ECECash] = [ECECash]()
            let n:ECECash = item
            for (index1, item1) in myList[index + 1..<myList.count].enumerated() {
                remaining.insert(item1, at: countIndex)
                countIndex = countIndex + 1;
            }
            var partial_rec:[ECECash] = [ECECash](listPartial)
            var partial_recIndex = partial_rec.count
            partial_rec.insert(n, at: partial_recIndex)
            partial_recIndex = partial_rec.count + 1
            
            find_ecash_recursive(myList: remaining, targetNumber: targetNumber, listPartial: partial_rec);

        }
    }
    
    
    func findeCashs(myList: [ECECash], targetNumber:Int){
        var list:[ECECash] = [ECECash]()
        find_ecash_recursive(myList: myList, targetNumber: targetNumber, listPartial: list)
    }

    
    func TestfindeCashs(){
        let  eCashList: [ECECash] = initeCashArr()
        let targetAmount: Int = 90000
        findeCashs(myList: eCashList, targetNumber: targetAmount)
        
        
    }
    
    func initeCashArr() -> [ECECash]
    {
        var myListCash:[ECECash] = [ECECash]()
        var cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "1111111111",
                           _value: 10000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        var index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "2222222",
                           _value: 10000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "333333",
                           _value: 10000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "444444",
                           _value: 20000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "5555555",
                           _value: 20000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "666666",
                           _value: 50000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "777777777",
                           _value: 100000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "88888888",
                           _value: 100000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "9999999",
                           _value: 200000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "3423432424",
                           _value: 200000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "89987878",
                           _value: 500000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        cash = ECECash(_countryCode: "EVND",
                           _issuerCode: "AGR",
                           _decisionNo: "SPH0023",
                           _serialNo: "4567657567",
                           _value: 50000,
                           _activeDate: "20180911",
                           _expireDate: "20180911",
                           _status: 1,
                           _treSign: "MEUCIQCTMjx5Qrm0bxs0eI2vZY8Fdbq1GC2L4uhs/BcLo3/lQQIgNmfV1QZdBi/p5HeGPGgngWVCNO5u3lCGOYQI5AuAf5M=",
                           _accSign: "MEUCIQC8AVbIbbv6ByJchWk+rZHf/aLBP6gG1ynqyfSTOi9IWwIgLI1zvJmNkWlOSwOomPDEK/EKS6hxsiagwr3XuihyrrY=")
        index = myListCash.count
        myListCash.insert(cash, at: index)
        
        return myListCash
    }
    
    
    func testELGamal(){
        
        //let senderPrivateKey = "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0="
        TestfindeCashs()
       /* let receiverPrivateKey = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        let receiverPublicKey = "BN9uNmjGpJPbh8XtLFA3lq+t4JwhOtWlDTL3SNlcJY10wYyE6M1lpa9jDgOM2A5pZ4kJwyJvgU7zlobPbH6u6sw="

        let rawData = "Ma hoa thuat toan elgamal"
        print("raw data: \(rawData)")
        var encData: [String]! = rawData.elGamalEncrypt(receiverPublickey: receiverPublicKey)
        
        print("m1 data: \(encData[0])")
        print("m2 data: \(encData[1])")
        print("enc data: \(encData[2])")
        
        var decData = rawData.elGamalDecrypt(receiverPrivateKey: receiverPrivateKey, blockEncrypt: encData)!
        print("decrypt data: \(decData)")
        */
    }
    
    
    func test() {
        
        let  eCashList: [Int32] = [10000, 10000, 20000, 50000, 100000]

        for ecash in eCashList {
            print(ecash)
        }
        
        /*let privateKey = "AIEGIA+wEeww8G/u3FF2/839hgTYb+8xD0gWo3X/Me/+"
        let publicKey = "BPKwnS/5ZO9EQTgIh4SsJfdDnjTaUltcatm6lMl8AH/n4K47E7cW5bIAmE5aI7C9KwmcUqsvccV9tUWY7wBuauM="
        let accountIDT = "100000004166"
        let issuerCode = "970405"
        let type = String(2)
        let initialDataSign = "MB001FU1003214560163"
        let dataSign = (initialDataSign).sha256Data()
        let dataSignBase64 = dataSign.base64EncodedString()
        let dataSignHex = dataSign.hexDigest()
        print("Initial datasign: \(initialDataSign)")
        print("datasign base64: \(dataSignBase64)")
        print("datasign hex: \(dataSignHex)")
        let signature = ECSecp256k1.signData(data: dataSign, strPrivateKey: privateKey)
        print("Signature: \(signature ?? "")")
        
        let verify = ECSecp256k1.verifySignedData(strSig: signature, msgData: dataSign, strPublicKey: publicKey)
        print("Verified: \(verify)")*/
    }
    
    
    func testECKeyGenerate() {
        let keyGenerator = ECSecp256k1KeyGenerator()
        XCTAssertTrue(keyGenerator.generateKeyPair())
        let privateKey = keyGenerator.privateKey
        let publicKey = keyGenerator.publicKey
        print("private key is: \(privateKey)")
        print("public key is: \(publicKey)")
    }
    
    func getEncode(ecpoint: ProjectivePoint<WeierstrassCurve<NaivePrimeField<U256>>>) -> Data {
        
        var bytesX = ecpoint.toAffine().X.bytes
        var bytesY = ecpoint.toAffine().Y.bytes
        let count = bytesX.count + bytesY.count;
        
        var PO = bytesX[0..<bytesX.count]
        PO.append(bytesY)
        return PO
        
    }
    
    func getDecode(data: Data) -> AffinePoint<WeierstrassCurve<NaivePrimeField<U256>>> {
        
        let POX = data[0..<data.count/2]
        let POY = data[data.count/2..<data.count]
        let X = BigUInt(POX)
        let Y = BigUInt(POY)
        
        let ecpoint = secp256k1Curve.toPoint(X, Y)
        
        return ecpoint!
    }
    
    func getECPointfromPublicKey(data: Data) -> AffinePoint<WeierstrassCurve<NaivePrimeField<U256>>> {
        
        let POX = data[1..<data.count/2 + 1]
        let POY = data[data.count/2 + 1..<data.count]
        let X = BigUInt(POX)
        let Y = BigUInt(POY)
        
        let ecpoint = secp256k1Curve.toPoint(X, Y)
        
        return ecpoint!
    }
    
    /*
    
    func testELGamal(){
        
        //let senderPrivateKey = "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0="

        let receiverPrivateKey = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        let receiverPublicKey = "BN9uNmjGpJPbh8XtLFA3lq+t4JwhOtWlDTL3SNlcJY10wYyE6M1lpa9jDgOM2A5pZ4kJwyJvgU7zlobPbH6u6sw="

        let rawData = "Ma hoa thuat toan elgamal"
        print("raw data: \(rawData)")
        var encData: [String]! = rawData.elGamalEncrypt(receiverPublickey: receiverPublicKey)
        
        print("m1 data: \(encData[0])")
        print("m2 data: \(encData[1])")
        print("enc data: \(encData[2])")
        
        var decData = rawData.elGamalDecrypt(receiverPrivateKey: receiverPrivateKey, blockEncrypt: encData)!
        print("decrypt data: \(decData)")
        
    }*/
    
    func testECSharedKeyGenerate() {
        let keyGen1 = ECSecp256k1KeyGenerator()
        let keyGen2 = ECSecp256k1KeyGenerator()
        XCTAssertTrue(keyGen1.generateKeyPair())
        XCTAssertTrue(keyGen2.generateKeyPair())
        let shared1 = ECSecp256k1.generateSharedKey(strPrivateKey: keyGen1.privateKey, strPublicKey: keyGen2.publicKey)
        let shared2 = ECSecp256k1.generateSharedKey(strPrivateKey: keyGen2.privateKey, strPublicKey: keyGen1.publicKey)
        XCTAssertTrue(shared1 == shared2)
        
        
        let prv1 = "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0="
        let pub1 = "BGDLmTY6V9PIM27Y218StuDgEtPDfTdPXknqc1AmgLfVCR0Ki+41A3kqQoVnyELkzZbVlLBtoGf24VXZ5niFOB8="
        
        let prv2 = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        let pub2 = "BN9uNmjGpJPbh8XtLFA3lq+t4JwhOtWlDTL3SNlcJY10wYyE6M1lpa9jDgOM2A5pZ4kJwyJvgU7zlobPbH6u6sw="
        /*
        let share1 = ECSecp256k1.generateSharedKey(strPrivateKey: prv1, strPublicKey: pub2)
        let share2 = ECSecp256k1.generateSharedKey(strPrivateKey: prv2, strPublicKey: pub1)
        print("share1: \(share1)")
        print("share2: \(share2)")
        
        let share3 = "A8XK+XxNQMm9SyXjPZyKzYmho6uPjkBB/Wr2EPSC5ucp"
        let share4 = share3.sha256base64String()
        
        
        let verify = ECSecp256k1.verifySignedData(strSig: "MEQCIHOCpyGMjX3ucv0lTfozuF3FVJliOzwaQEV0p7ZOc+DjAiAehwkpt32fgjGpEpF7zxDx8TZZcyAPg1+ufruxKvwDBw==", strMessage: "AI8EvNgvaOFhU3e2H37bCCH/yz5ndbsDOy9rMZ13w9mk", strPublicKey: pub1)
        
        let verify2 = ECSecp256k1.verifySignedData(strSig: "MEQCIHOCpyGMjX3ucv0lTfozuF3FVJliOzwaQEV0p7ZOc+DjAiAehwkpt32fgjGpEpF7zxDx8TZZcyAPg1+ufruxKvwDBw==", strMessage: "100000003424", strPublicKey: pub1)
        
        let sign1 = ECSecp256k1.signData(strMessage: "100000003424", strPrivateKey: "8HJhhUQbyYTtjv49w3UMy+y32O7aq/No6PS07dJ91/A=")
 */
        let data = "Le Anh Tuan"
        print("data: \(data)")
         let encryptedData = data.aesEncryptTransactionData(key: shared1!)
        print("encryptedData: \(encryptedData)")
        let decryptedData = encryptedData!.aesDecryptTransactionData(key: shared2!)
        print("decryptedData: \(decryptedData)")
        
        //let decryptedData1 = "yfs/zTSdUZF5fAna1A4kgA==".aesDecryptTransactionData(key: shared2!)
        //print("decryptedData1: \(decryptedData1)")
 
        let curve = secp256k1Curve
        let generatorX = BigUInt("79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798", radix: 16)!
        let generatorY = BigUInt("483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8", radix: 16)!
        let success = curve.testGenerator(AffineCoordinates(generatorX, generatorY))
        
        XCTAssert(success, "Failed to init secp256k1 curve!")
        
        // this is basically a private key - large random scalar
        let randomScalar = BigUInt.randomInteger(lessThan: 256)
        guard let privateKey = U256(randomScalar.serialize()) else { return XCTFail()}
        
        // make point. Point is made from affine coordinates in normal (not Montgomery) representation
        guard let G = curve.toPoint(generatorX, generatorY) else {return XCTFail()}
        print("G coordinate:\(G.coordinates)")

        // calculate a public key
        let publicKey = privateKey * G
        XCTAssert(!publicKey.isInfinity)
        
        // also try to multiply by group order
        let groupOrder = curve.order
        let expectInfinity = groupOrder * G
        XCTAssert(expectInfinity.isInfinity)
        
        guard let priKey = Data(base64Encoded: prv1, options: .ignoreUnknownCharacters) else { return XCTFail() }
        guard let pubKey = Data(base64Encoded: pub1, options: .ignoreUnknownCharacters) else { return XCTFail() }
        let pubK = [UInt8](pubKey)
        let priK = [UInt8](priKey)
        
        guard let myKey = U256(priKey) else { return XCTFail()}
        let publicKey1 = myKey * G
        XCTAssert(!publicKey1.isInfinity)
       print("myKey: \(!publicKey1.isInfinity)")
         print("myKey coordinate: \(publicKey1.toAffine().coordinates)")
        
        let secp256k1PrimeBUI = BigUInt("fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f", radix: 16)!
        //let n = BigUInt.randomInteger(lessThan: secp256k1PrimeBUI )
        guard let n = Data(base64Encoded: "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0=", options: .ignoreUnknownCharacters) else { return XCTFail() }
        print("n: \(n)")
        
       
        
        guard let nScalar = NativeU256(n) else { return XCTFail()}
        
        let m1 = nScalar * G
       print("m1: \(m1)")
        print("m1 coordinate X: \(m1.toAffine().coordinates.X)")
        print("m1 coordinate Y: \(m1.toAffine().coordinates.Y)")
        let m1Bytes = getEncode(ecpoint: m1)

    
        
        guard let priKey2 = Data(base64Encoded: prv2, options: .ignoreUnknownCharacters) else { return XCTFail() }
        guard let pubKey2 = Data(base64Encoded: pub2, options: .ignoreUnknownCharacters) else { return XCTFail() }
        let pubK2 = [UInt8](pubKey2)
        let priK2 = [UInt8](priKey2)
        
        
        
        guard let publicKey2 = curve.toPoint("101060493930250743992747937061457902747032902542079368747708321456016706604404", "87544655672495624923387103667640429819957134322524322546199467129716981295820") else {return XCTFail()}
        
        guard let k = Data(base64Encoded: "FnRGJJYDtjiepLGGN9AyiVwPqSNtFZjQlb9L0luR6ig=", options: .ignoreUnknownCharacters) else { return XCTFail() }
        print("k: \(k)")
        
        guard let kScalar = NativeU256(k) else { return XCTFail()}
        
        let m2tmp = kScalar * G
        let m2tmp1 = nScalar * publicKey2
        
        let keyAES = m2tmp.toAffine().Y.bytes
        
        print("keyAES: \(keyAES)")
        
        
        let m2 = curve.add(m2tmp.toAffine().toProjective(), m2tmp1 )
        let m2Bytes = getEncode(ecpoint: m2)
        print("m2: \(m2)")
        print("m2 coordinate X: \(m2.toAffine().coordinates.X)")
        print("m2 coordinate Y: \(m2.toAffine().coordinates.Y)")

        let m3 = m2tmp + m2tmp1
        
        print("m3: \(m3)")
        print("m3 coordinate X: \(m3.toAffine().coordinates.X)")
        print("m3 coordinate Y: \(m3.toAffine().coordinates.Y)")
        
        let encryptedElgamalData = data.aesEncryptTransactionData(key: keyAES.base64EncodedString())
        print("encryptedElgamalData: \(encryptedElgamalData)")
        
        
        
        
        let m1Decrypt = getDecode(data: m1Bytes)
        let m2Decrypt = getDecode(data: m2Bytes)
        
        let priKey21 = NativeU256(BigUInt(priKey2))
        let priKey21tmp = curve.mul(priKey21, m1Decrypt)
        
        print("priKey21: \(priKey21)")
        
        let pointDecrypt = curve.sub(m2Decrypt.toProjective(), priKey21tmp )
        let pointDecryptByte = getEncode(ecpoint: pointDecrypt)
        let AESDecrypt = pointDecryptByte[pointDecryptByte.count/2..<pointDecryptByte.count]
        
        let decryptText = encryptedElgamalData?.aesDecryptTransactionData(key: AESDecrypt.base64EncodedString())
        print("decryptText: \(decryptText)")
        //let m2Decrypt = curve.hashInto(m2Bytes)
        /*
        guard let myKey2 = U256(priKey) else { return XCTFail()}
        let publicKey2 = myKey2 * G
        
        print("myKey2: \(!publicKey2.isInfinity)")
        print("myKey2 coordinate: \(publicKey2.toAffine().coordinates)")
        
        var m2 = curve.add(publicKey2.toAffine().toProjective(), curve.mul(U256(n), publicKey1.toAffine()))
        print("m2 coordinate X: \(m2.toAffine().coordinates.X)")
        print("m2 coordinate Y: \(m2.toAffine().coordinates.Y)")
        
        var m2X = [UInt8]()
        var m2Y = [UInt8]()
        do{
            try m2.toAffine().coordinates.X.encode(to: m2X as! Encoder)
            try m2.toAffine().coordinates.Y.encode(to: m2Y as! Encoder)
        }
        catch{}
 */
        
        
        
        //print("m1 coordinate: \(m1.toAffine().coordinates)")
        //print("q= \(secp256k1s.q.)")
        //publicKey2.toAffine().
        //EllipticCurve.init(x: generatorX, y: generatorY)
    }
    
    func testSignCash() {
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733599", value: 50000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733598", value: 20000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733597", value: 10000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733596", value: 5000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733595", value: 2000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733594", value: 1000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733593", value: 500000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733592", value: 200000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print(ECashSigner(countryCode: "EVND", issuerCode: "AGR", decisionNo: "D000001", serialNo: "81063374733591", value: 100000, activeDate: "20180601", expireDate: "20190731", status: 1).generateECash())
        
        print("hahaha")
    }
    
    func testSignatureVerify() {
        let prv1 = "AIEGIA+wEeww8G/u3FF2/839hgTYb+8xD0gWo3X/Me/+"
        //let prv2 = "ANNTHN4ulPyIxq61K8nogTSm/oLbDrkStfIhqKQnegMY"
        
        let pub1 = ECSecp256k1.generatePublicKey(_privateKey: prv1, compression: false)
        //let pub2 = ECSecp256k1.generatePublicKey(_privateKey: prv2, compression: false)
        print("haha")
        
        let data = "MB001FU1003214560163"
        let signature = ECSecp256k1.signData(strMessage: data, strPrivateKey: prv1)
        print("Signature: \(signature ?? "No signature")")
        
        let verify = ECSecp256k1.verifySignedData(strSig: signature, strMessage: data, strPublicKey: pub1)
        print("Verify: \(verify)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
class ECECash {
    var _countryCode : String?
    var _issuerCode : String?
    var _decisionNo : String?
    var _serialNo : String?
    var _value : Int?
    var _activeDate : String?
    var _expireDate : String?
    var _status : Int?
    var _treSign : String?
    var _accSign : String?
    init(_countryCode : String,
         _issuerCode : String,
         _decisionNo : String,
         _serialNo : String,
         _value : Int,
         _activeDate : String,
         _expireDate : String,
         _status : Int,
         _treSign : String,
         _accSign : String) {
        self._countryCode = _countryCode
        self._issuerCode = _countryCode
        self._decisionNo = _decisionNo
        self._serialNo = _serialNo
        self._value = _value
        self._activeDate = _activeDate
        self._expireDate = _expireDate
        self._status = _status
        self._treSign = _treSign
        self._accSign = _accSign
    }
}
