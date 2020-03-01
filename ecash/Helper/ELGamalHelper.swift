//
//  ELGamalHelper.swift
//  ecash
//
//  Created by phong070 on 8/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ELGamalHelper {
    static let instance = ELGamalHelper()
    private init(){
    }
    
    func generateECKey()  -> ELGamalModel?{
        let keyGenerator = ECSecp256k1KeyGenerator()
        let _ = keyGenerator.generateKeyPair()
        let privateKey = keyGenerator.privateKey
        let publicKey = keyGenerator.publicKey
        debugPrint("private key is: \(privateKey)")
        debugPrint("public key is: \(publicKey)")
        return ELGamalModel(privateKey: privateKey, publicKey: publicKey)
    }
    
    func elGamaAlgorithm(){
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
    
    /*Package data*/
    func packandUnPack(){
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
    
    func elGamalAlgorithmV2(){
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
    
    func generatePublicKey() {
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
    }
    
    /**
     encrypted channel
    */
    func signatureChannel(data : Data) ->String?{
        let signature = ECSecp256k1.signData(data: data, strPrivateKey: CipherKey.PrivateChannelKey)
        return signature
    }
    
    /**
     encrypted wallet
    */
    func signatureWallet(data : Data) ->String?{
        guard let key = CommonService.getKeychainData() else {
            return "Not found private key"
        }
        let signature = ECSecp256k1.signData(data: data, strPrivateKey: key.privateKey ?? "")
        return signature
    }
    
    /**
     Signed data
    */
    func signData(string : String) -> String {
        let signature = ECSecp256k1.signData(data: string.sha256Data(), strPrivateKey: CommonService.getPrivateKey() ?? "")
        return signature ?? ""
    }
    
    /**
     Signed data with cash logs and transactions log
    */
    func signatureCashTransactionsLogs(data : Data) -> String {
        let signature = ECSecp256k1.signData(data: data, strPrivateKey: CommonService.getPrivateKey() ?? "")
        return signature ?? ""
    }
    
    /**
     Verified data
    */
    func verifyData(signature : String,data : String, publicKeySender : String) -> Bool {
        let verify = ECSecp256k1.verifySignedData(strSig: signature, msgData: data.sha256Data(), strPublicKey: publicKeySender)
        return verify
    }
    
    /**
     Verified cash
     */
    func verifyDataCash(signature : String,data : String, publicKeySender : String) -> Bool {
        let verify = ECSecp256k1.verifySignedData(strSig: signature, msgData: data.sha256Data(), strPublicKey: publicKeySender)
        return verify
    }
    
    /**
     Encrypted package
    */
    func encryptedPackage(receiverPublicKey : String,cashArray : [[String]]) -> [String]{
        let rawData = ""
        let encData: [String] = rawData.encryptV2(receiverPublickey: receiverPublicKey, cashArray: cashArray)
        return encData
    }
    
    /**
     Decrypted package
    */
    func decryptedPackage(receiverPrivateKey : String,encData : [String]) -> [[String]] {
        let rawData = ""
        let decData:[[String]] = rawData.decryptV2(receiverPrivatekey: receiverPrivateKey, blockEncrypt: encData)
        return decData
    }
}
