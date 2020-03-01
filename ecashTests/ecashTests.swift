//
//  ecashTests.swift
//  ecashTests
//
//  Created by phong070 on 8/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import XCTest
import BigInt
@testable import ecash
class ecashTests: XCTestCase {

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
            debugPrint("future")
        case .orderedDescending:
            debugPrint("past")
        default:
            debugPrint("today")
        }
    }
    
    func testECKeyGenerate() {
        let keyGenerator = ECSecp256k1KeyGenerator()
        XCTAssertTrue(keyGenerator.generateKeyPair())
        let privateKey = keyGenerator.privateKey
        let publicKey = keyGenerator.publicKey
        debugPrint("private key is: \(privateKey)")
        debugPrint("public key is: \(publicKey)")
    }
    
    func testELGamal(){
        /*Preparing encypt and decrypt(elgamal)*/
        let receiverPrivateKey = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        let receiverPublicKey = "BN9uNmjGpJPbh8XtLFA3lq+t4JwhOtWlDTL3SNlcJY10wYyE6M1lpa9jDgOM2A5pZ4kJwyJvgU7zlobPbH6u6sw="
        let rawData = "ECPay===>(Elgamal algorithm data)"
        debugPrint("raw data: \(rawData)")
        //Want to send data to receiver : using public key of receiver in order to encrypted
        var encData: [String]! = rawData.elGamalEncrypt(receiverPublickey: receiverPublicKey)
        debugPrint("m1 data: \(encData[0])")
        debugPrint("m2 data: \(encData[1])")
        debugPrint("enc data: \(encData[2])")
        //Want to get data from sender : using private key of receiver in order to decrypted
        let decData = rawData.elGamalDecrypt(receiverPrivateKey: receiverPrivateKey, blockEncrypt: encData)!
        debugPrint("decrypt data: \(decData)")
    }
    
    func testGenerateQRCodes()
    {
        let MAX_LENGHT_QRCODE = 1000
        let msg:String = "{\"sender\": \"8350652544\",\"receiver\": \"8350652544\",\"time\": \"20191005163945\",\"type\": \"CT\",\"content\": \"test\",\"id\": \"MEQCICJdadMShv00byw3pN8ulOafo/oIgNwT12faKaf0BCOBAiAXii6dH230Ep+kLgAucQizwby8vROFp8BEY3RjPt1WIg==\",\"cashEnc\": \"BJxWBfwNro8F610Q4cBWX6kEDt+x+NaKMzFZd6t/JQu1wi9KYT1KAjsEWd6A1EoTd3q27f0q6YdwZRyLqKMuAaY=$BLEndroAi1d47JpVjZ68p4uUwQL0CyG9d0V2r7oj5Bd2Ahb8Zp7aj6zKV0XY+hrNHxLwx3PA0JwiAOcoB6qTf+g=$NTJTbezjHjHoLTBnFr/bqbKjuVn9CsNegtybk53KX3sa8SBXXZyWUWxqjcbaSzc/bCrA2A/N8R6se7UprU1PswOCfKxRna/D2DEAlfbxem0a60Vq520zSCCwcE+sAicfNXHFlsEgqqe5K0MLcN+VOeInyTdtybyNjOlxsV1PztoTbtanBh82PvhexwzVSwynIj68hg30l9MlqTKb9kPvBro+kq8Ofn9qh3CfqcYtZ1fHP48mqsdLFN3IajfWH30UyWcqXBEEeHkCVpPK2jFIjIWvrqFA2UTAuxp69L+3llHaNuT9eyrzGsjdQZekqolvnQDgi1e2Og7bxwoGsIRDEuETsvEyOcNhkbfVRtylBtCArj/9w+bJG8PvKSfjbfdJvnSxFOtW43uua1np5rdQ/tUkDDf0kExi4AXSxnVciQWpWqWf9hmyInCu+p48TYQYFlOGI2F2d5mV/ijwXen/woTxFENk+CuovB4w4hIwoj8I7oG9Vd5A7zh/WjTWuZOe5tZBSW8w7XAwncJfzHpAS7V0TvHAnS4fGgx/Qki+PX/IS9Ij498/VkHMVTuiOACD2OsE2xcU8tRSlCn+EWqgr/YOdO94mAfKGkcjEpGrcogu7phAHlkvm7aH05ebFMa5tNtn7joOYQNXLzyki75QIqAHzJNEwML3ZXdQq3KCsLp7e2wi05nYOeH0pLieTukdwH8PaciPCfIVC5pjk0X/jWOSJn2q70jq+zQrIDPLem/h7kv0z0r/1BLAPlxVS6giwlEQxXkz+YfoaxJG6P3NY0/o/ttEhO8lR7TFK9gWcB0Z7sC3qfsycfN2UlSA7jI1oe/bnDv911fUxVgCas/JF5LwstR2F39Efqg2Ede7HjxymMjrMGyUd2psb4IRgv7ZQSDNoGqJuVUerw7FxHTGxRELKukoGumXIVlqdZRMP+HCLU974bQ/VT8k/feDjbp5iMYB0hs+ps0KlUASfrbpbDYeEUdHx+QHYZ0LY53jEOhO1A7whDnIWEqJB/RjeSR2I0Ej636WHrNL9LPgPlxEI9mLLfRNYW5uT63lwvkZk2Q66jTn3JW6koN2EcyszICnzmzf5I67HAbpWICgUvLCKhjPCMzk+8QsP08142D3JhlvU4pniVaQa48xKMfPbNcQOYUC4WUdlEiJ5yh28mD/1MCeZD6abeKGIpz2hWcPSIWYnua5kgVFgk2FMz8lnvcNnzmUnTXdJ08k7O45Q3lic3eFP6Jt44NokF1HH9x4dec7te1kZ3Z9+JNOh3RRy0LrUeNTP4UNwGOJtH8iDcAVdxFVojRrCfZvQ7+HQmftvlezwn2rdUR3h+EnjW9WsiNvcmD2gDSQs2yI+qdUnb8KcJ15p2XtrS3MzXgLieXPSaYjtX0KgSTnmOupc/6CmkIyL/BJundpFmG5jGBtBEDUjFTcb9cSZRug04vxgGtR0X6T+sc86/jOBrvKy9GQ+SK7pYeeNdOnM7hh0VhYrjRmxxK4gyZrYHs51Smw90LEg42W59HpWEVT0r5hFP1qjNrlK98Yrz7TrggMxqWRyGMMbc/ONFBHXE/VRgWqt7jglAOufVHYKZJe68R/PHsTUHBCqBSpDJHjlo4CsDL3xOYCnpOEeh8Xpix9Env8Z0zsQOe6QIaU31cvMiHsGQr0rmJduMzUw8Cm5qU8erZjeXGmywk1U8mkFUgnBNH4TQo8dZ8XfVfTldJNu2t7M0lAvmXe+A/h1boX6TXUvRu6QoG7w86zGoUPZ0cwHld0Z4hDvKXOn6hFxDbMnnOhEjJZaJARE52gd6DG4JvX7ZsY8JRteeBn17Vw7qpBsjptpW64QbObBdOWdle9oQzAUiU6EdLw/UjrCIE3Iorn1wbqaRFSIT+11jj8Wcdisd6t74uP0F6r3IMfsYfSglC+PM1AA86q5eM+lPkINW8Do4yywaU38VdiW1fdXkdzeCt+gpEoYaQM0E3/IlDqOkXs2R4gMM+2RowtO4mKuxFRzr3rh5ZsGSuab6KT0LQGtNmeBDaxcvTw1zCxGkKMEzrFLmkynPq0vP3C5mMxmFtMCthxMJ1k/BXRX9utYJutwDUUsQCZkFNcm/JHbbbJKA4Mi8MVjaowx6mVfeuI1PpXDNFPe9mGE7gUIEAd745yqpJIP4Xe64Z6J17czieTxUWqj1yYhhyBKWEFXw3IdVQDFcyjuaQhw1JZ88OAQaHMkp+gCDCa89cWwWa8hUdIp0jIj6hcCz5CckUQn+w5cRaruCwh2LGE5cp15dJD/T6Z3WCLCgtuVfxyqsef76qd48ioNeA3yk0FUSX8BrWBttTUh36e+yudjUQ5OUc0iQT0gAAEcqKHvdfbTsJ435PvkWCD/HsMqCbZxdWq69Q7i7j0IpwHtozMozGGVNLoh6bIqBpNE1XrrdFqmhstz1Hpsf96TfiJYOkkiXB2FsB9Te9bJLdOfMvvaxydGY7dM66h6Z1dFXclWkCsTYnAPkE46/l2T69Rz0IyXnXCPKETzrYDHwxRtiNJS0GvIOtGn6p6qXlG9qCUwsnqkUxJAwccEVooHJe0y3mkAA39Ul3o9R1yJmTU77kwfrCwrlEVYZqwB2FkKcSj4CMqJaeRRW6H6JYfdOzAPhIdnitOdv+Y7bIVzd7v7ZPUPSzXU2RzeS/qnM3+GZkTA7t8kBC6G81meJlfVVvr4Z3nO0Jryvn/C2T8tWSlDcmH7GgULCF6zovV8PKGwPgQxaBCSQ2tFmyzqQlvBjZ4BQywm7j7BUZ/y7yQd2magUb6KQ==\"}"
        
        let arrQRCode: [String] = msg.substringsOfLength(by: MAX_LENGHT_QRCODE) /*Noi dung content cua QRCode*/
        let totalQRCode = (msg.count/MAX_LENGHT_QRCODE) + 1 /*So luong picture QRCode**/
        for index in 0...totalQRCode - 1 {
            debugPrint("index: \(index)")
            
        }
        
        for QRContent in arrQRCode {
            debugPrint("Content: \(QRContent)")
        }
        
        
        /*let strlen = input.count
         var start = input.startIndex
         let lastIndex = strlen > 0 ? input.endIndex.predecessor() : input.startIndex
         
         for i in 0 ..< (strlen + 1)/2 {
         start = i > 0 ? start.advancedBy(2) : start
         let end = start < lastIndex ? start.successor() : start
         let str = input[start...end]
         strings.append(str)
         }*/
        
    }

    
    /*Package data*/
    func testPackandUnPack(){
        //let receiverPrivateKey = "CXw0ovLVOSmuVxk/GYoNhe5xU9IVXDD69Rptd3dbC3E="
        //let receiverPublicKey = "BNPw8G0JSteV/Vh5ZJU9ZVpnskf53NVCBbQ1aksiNcRuXDTcktbe+GWEAVtIFHkPwjeLfuxFGckPZkbUTKMpHIk="
        let receiverPrivateKey = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        let receiverPublicKey = "BN9uNmjGpJPbh8XtLFA3lq+t4JwhOtWlDTL3SNlcJY10wYyE6M1lpa9jDgOM2A5pZ4kJwyJvgU7zlobPbH6u6sw="
        let rawData = ""
        let s0: [String] = ["VN;GPB;GPB01001;2716791183927;500000;20181220;20501220;2",
                            "MEUCIQCq18K/LHBxKqcpY1Q6wcqSheZKt/GjrMJbmypxazlVxwIgL+UYif0Fkbm7mdH/92oJj3UQsj/m0fVMoiXhSmia3+E=",
                            "MEUCIQCY2mEltt1BY0sKQUZ6xCswSjha5iW+15Pw0kQygiXZPAIgMw1FlAb8tPoLcSG4lKOBvfkAiF1aoRO00o8YZpOV20s="]
        // 4 tờ eCash
        let cashArray: [[String]] = [ s0, s0, s0, s0]
        let encData: [String]! = rawData.encryptV2(receiverPublickey: receiverPublicKey, cashArray: cashArray)
        //var encData: [String] = ["BFoVqRNr5YoPdItQGgdT+6UsTV3Ld0LawEdf/SmrQyH4bdWm+NDe5Sj4uP/YFKJa4pj5b8q56klQS/1VvFhCOaE=", "BNYJEYcTjmT45TlpzzU6OMvKcQ6L8OLVQZhTSTDDFBnc4c3Proys/f8EZjePuI+NkI8BSeisdnXq4UPiWF8dE9Q=", "5uKS8J+NWRkTlB4U7JwONpJxJdS9fkr4garS8SkUWRHNff2zfbN2RiW5/2z+eEE12u4BWtlYi20qP5AiaGleJ+8beuIEhPqdUzIb3NUYjBedt6eJpUUL28sKHKz4wN5hF/xuUtWoYqP+xBm7WmIvguKJaVKwA7A1Sqd4cLO/ilYQ/kXDbu1ceDJOGlVUzDyaNJG8RiZh7D4r0p5OyNw1TpOQCycONwN/CfFEDZlxOQs57zGgR5l2xPm+h8WTUyTRIhWtnXvlwkv/qYHOzmb2/amttQdXth8QnQlTwewzeSBejBGIwVVWbmp1MJ5E+t0Vy4oPfJo5hxv5tMQ7ByeEoNOVFGV3iermeivPeheRL2bNRSh0sAgBHRUEI+sXTUIBBQdERicv5EvUmAlJgftFyLz9SnqSDvqfBh90RbU8pD4CFQDeyd9tCqLqejoLsInvLP/6hgPsOy6IMPpulea/CnxgFm49naOZ+bfmx3lqaYDItv9iW0i5TkAiqJ93nlZQuGho6A2zTFPOy+lNUNA/4C9bTn/M9E1Q6DOJE8xRO1/ukzMMdb8NcE37eeS1TtJM"]
        let decData:[[String]] = rawData.decryptV2(receiverPrivatekey: receiverPrivateKey, blockEncrypt: encData)
        print("decrypt data package: \(decData)")
    }
    
    func testELGamalV2(){
        //let senderPrivateKey = "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0="
        let receiverPrivateKey = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        let receiverPublicKey = "BN9uNmjGpJPbh8XtLFA3lq+t4JwhOtWlDTL3SNlcJY10wYyE6M1lpa9jDgOM2A5pZ4kJwyJvgU7zlobPbH6u6sw="
        let rawData = "VN;GPB;GPB01001;2716791183927;500000;20181220;20501220;2,MEUCIQCq18K/LHBxKqcpY1Q6wcqSheZKt/GjrMJbmypxazlVxwIgL+UYif0Fkbm7mdH/92oJj3UQsj/m0fVMoiXhSmia3+E=,MEUCIQCY2mEltt1BY0sKQUZ6xCswSjha5iW+15Pw0kQygiXZPAIgMw1FlAb8tPoLcSG4lKOBvfkAiF1aoRO00o8YZpOV20s=VN;GPB;GPB01001;2716791183927;500000;20181220;20501220;2,MEUCIQCq18K/LHBxKqcpY1Q6wcqSheZKt/GjrMJbmypxazlVxwIgL+UYif0Fkbm7mdH/92oJj3UQsj/m0fVMoiXhSmia3+E=,MEUCIQCY2mEltt1BY0sKQUZ6xCswSjha5iW+15Pw0kQygiXZPAIgMw1FlAb8tPoLcSG4lKOBvfkAiF1aoRO00o8YZpOV20s="
        print("raw data: \(rawData)")
        var encData: [String]! = rawData.elGamalEncrypt(receiverPublickey: receiverPublicKey)
        print("m1 data: \(encData[0])")
        print("m2 data: \(encData[1])")
        print("enc data: \(encData[2])")
        let decData = rawData.elGamalDecrypt(receiverPrivateKey: receiverPrivateKey, blockEncrypt: encData)!
        print("decrypt data: \(decData)")
    }
    
    func testECSharedKeyGenerate() {
        let keyGen1 = ECSecp256k1KeyGenerator()
        let keyGen2 = ECSecp256k1KeyGenerator()
        XCTAssertTrue(keyGen1.generateKeyPair())
        XCTAssertTrue(keyGen2.generateKeyPair())
        let shared1 = ECSecp256k1.generateSharedKey(strPrivateKey: keyGen1.privateKey, strPublicKey: keyGen2.publicKey)
        let shared2 = ECSecp256k1.generateSharedKey(strPrivateKey: keyGen2.privateKey, strPublicKey: keyGen1.publicKey)
        XCTAssertTrue(shared1 == shared2)
    
        /*Preparing data to encrypt and decrypt(commonCrypto)*/
        let data = "ECPay===>(eCash project is testing on ECAES256Crytor)"
        debugPrint("data: \(data)")
        let encryptedData = data.aesEncryptTransactionData(key: shared1!)
        debugPrint("encryptedCryptoData: \(encryptedData ?? "")")
        let decryptedData = encryptedData!.aesDecryptTransactionData(key: shared2!)
        debugPrint("decryptedCryptoData: \(decryptedData ?? "")")
        
        /*Preparing encypt and decrypt(Elliptic)*/
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
        debugPrint("G coordinate:\(G.coordinates)")
        // calculate a public key
        let publicKey = privateKey * G
        XCTAssert(!publicKey.isInfinity)
        // also try to multiply by group order
        let groupOrder = curve.order
        let expectInfinity = groupOrder * G
        XCTAssert(expectInfinity.isInfinity)
        
        /*Preparing practice on Elliptic algorithm*/
        let prv1 = "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0="
        guard let priKey = Data(base64Encoded: prv1, options: .ignoreUnknownCharacters) else { return XCTFail() }
        guard let myKey = U256(priKey) else { return XCTFail()}
        let publicKey1 = myKey * G
        XCTAssert(!publicKey1.isInfinity)
        
        //Register public and private by Elliptic
        guard let n = Data(base64Encoded: "O1h4Id3HqATByouBiZOPL/adl09cp3uQRsZmC2nnDz0=", options: .ignoreUnknownCharacters) else { return XCTFail() }
        debugPrint("n: \(n)")
        guard let nScalar = NativeU256(n) else { return XCTFail()}
        let m1 = nScalar * G
        let m1Bytes = CommonService.getEncode(ecpoint: m1)
        
        let prv2 = "7GOpYjRs9u2lYnmzl6qmyxT7DE3qc43XGOQRlNSnRQ8="
        guard let priKey2 = Data(base64Encoded: prv2, options: .ignoreUnknownCharacters) else { return XCTFail() }
        guard let publicKey2 = curve.toPoint("101060493930250743992747937061457902747032902542079368747708321456016706604404", "87544655672495624923387103667640429819957134322524322546199467129716981295820") else {return XCTFail()}
        guard let k = Data(base64Encoded: "FnRGJJYDtjiepLGGN9AyiVwPqSNtFZjQlb9L0luR6ig=", options: .ignoreUnknownCharacters) else { return XCTFail() }
        debugPrint("k: \(k)")
        guard let kScalar = NativeU256(k) else { return XCTFail()}
        let m2tmp = kScalar * G
        let m2tmp1 = nScalar * publicKey2
        let keyAES = m2tmp.toAffine().Y.bytes
        debugPrint("keyAES: \(keyAES)")
        //encrypt data by commonCrypto
        let encryptedElgamalData = data.aesEncryptTransactionData(key: keyAES.base64EncodedString())
        debugPrint("encryptedData: \(encryptedElgamalData ?? "")")
        //decrypt data by commonCrypto
        let m2 = curve.add(m2tmp.toAffine().toProjective(), m2tmp1 )
        let m2Bytes = CommonService.getEncode(ecpoint: m2)
        let m1Decrypt = CommonService.getDecode(data: m1Bytes)
        let m2Decrypt = CommonService.getDecode(data: m2Bytes)
        let priKey21 = NativeU256(BigUInt(priKey2))
        let priKey21tmp = curve.mul(priKey21, m1Decrypt)
        debugPrint("priKey21: \(priKey21)")
        let pointDecrypt = curve.sub(m2Decrypt.toProjective(), priKey21tmp )
        let pointDecryptByte = CommonService.getEncode(ecpoint: pointDecrypt)
        let AESDecrypt = pointDecryptByte[pointDecryptByte.count/2..<pointDecryptByte.count]
        let decryptText = encryptedElgamalData?.aesDecryptTransactionData(key: AESDecrypt.base64EncodedString())
        debugPrint("decryptedData: \(decryptText ?? "")")
    }
  
    func testGeneratePublicKey() {
        let prv1 = "LtY4kRsTxuLKsEOlWCdbFjf6ut4OK0j+VunJBo1Qq08="
        let pub1 = ECSecp256k1.generatePublicKey(_privateKey: prv1, compression: false)
        debugPrint("Preparing sign with ECSecp256k1...")
        let data = "1231232131231232312321312312312312313113123123123"
        //prive key of sender
        let signature = ECSecp256k1.signData(strMessage: data, strPrivateKey: prv1)
        debugPrint("Signature: \(signature ?? "No signature")")
        //public key of sender
        let verify = ECSecp256k1.verifySignedData(strSig: signature, strMessage: data, strPublicKey: pub1)
        debugPrint("Verify: \(verify)")
        XCTAssertEqual(verify, true,"Sign doen't match")
    }
}
