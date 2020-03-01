//
//  TransferDataModel.swift
//  ecash
//
//  Created by phong070 on 9/12/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransferDataModel : Codable {
    var sender : String?
    var receiver : String?
    var time : String?
    var type : String?
    var content : String?
    var id : String?
    var templateCode : String?
    var cashEnc : String?
    var data : String?
    var refId : String?
    
    var senderPublicKey : String?
    var totalAmount : String?
    var channelSignature : String?
    var fullName : String?
    
    func dataeCashToeCash() -> String{
        return "\(sender ?? "")\(receiver ?? "")\(time ?? "")\(type ?? "")\(content ?? "")\(cashEnc ?? "")"
    }
    
    func dataeDC() -> String{
        return "\(sender ?? "")\(receiver ?? "")\(time ?? "")\(type ?? "")\(cashEnc ?? "")"
    }
    
    //eCash to eCash
    init(sender : String,
         receiver : String,
         time : String,
         type : String,
         content : String,
         cashEnc : String) {
        self.sender = sender
        self.receiver = receiver
        self.time = time
        self.type = type
        self.content = content
        self.cashEnc = cashEnc
        self.refId = "null"
        self.data = "\(sender)\(receiver)\(time)\(type)\(content)\(cashEnc)"
        self.id = ELGamalHelper.instance.signData(string: self.data ?? "")
    }
    
    //sendLixi
    init(sender : String,
            receiver : String,
            time : String,
            type : String,
            content : String,
            cashEnc : String,
            templateCode : String) {
        self.sender = sender
        self.receiver = receiver
        self.time = time
        self.type = type
        self.content = content
        self.cashEnc = cashEnc
        self.refId = "null"
        self.templateCode = templateCode
        self.data = "\(sender)\(receiver)\(time)\(type)\(content)\(cashEnc)"
        self.id = ELGamalHelper.instance.signData(string: self.data ?? "")
    }
    
    //eCash to eDong
    //eDong to eCash
    // Exhange money
    init(sender : String,
         receiver : String,
         time : String,
         type : String,
         cashEnc : String) {
        self.sender = sender
        self.receiver = receiver
        self.time = time
        self.type = type
        self.cashEnc = cashEnc
        self.data = "\(sender)\(receiver)\(time)\(type)\(cashEnc)"
        self.id = ELGamalHelper.instance.signData(string: self.data ?? "")
    }
    
    //Reply message
    init(data : TransactionsLogsEntityModel) {
        self.receiver = data.receiverAccountId?.description ?? "0"
        self.type = EnumTransferType.STOPPING_SOCKET.rawValue
        self.refId = data.refId ?? ""
        self.id = data.transactionSignature ?? ""
    }
    
    //eDong to eCash owner
    init(data : eDongToeCashOwnerViewModel) {
        self.receiver = data.receiver?.description
        self.sender = data.sender?.description
        self.time = data.time?.description
        self.type = data.type?.description
        self.content = data.content
        self.cashEnc = data.cashEnc
        self.id = data.id
        self.refId = data.refId?.description
    }
    
    //Exchange eCash
    init(data : ExchangeeCashViewModel) {
        self.receiver = data.receiver?.description
        self.sender = data.sender?.description
        self.time = data.time?.description
        self.type = data.type?.description
        self.content = data.content
        self.cashEnc = data.cashEnc
        self.id = data.id
        self.refId = data.refId?.description
    }
    
    //SavedLocalExchanged
    init(id : String,data : TransferDataModel) {
        self.receiver = data.receiver?.description
        self.sender = data.sender?.description
        self.time = data.time?.description
        self.type = data.type?.description
        self.content = data.content
        self.cashEnc = data.cashEnc
        self.id = id
        self.refId = data.refId?.description
    }
    
    //Stopping sync data
    init(data : TransferDataSyncContactModel) {
        self.refId = data.refId
        self.receiver = data.receiver
        self.sender = data.sender?.description
        self.type = EnumTransferType.STOPPING_SOCKET.rawValue
    }
    
    //Stopping cashTemp
    init(data : CashTempEntityModel) {
        self.refId = data.id?.description
        self.sender = data.senderAccountId?.description
        self.receiver = CommonService.getWalletId() ?? ""
        self.type = EnumTransferType.STOPPING_SOCKET.rawValue
    }
    
    //Stoping destroy contact
    init(data : DestroyContactModel){
        self.refId = data.refId
    }
    
    // Use on Send Request Pay To
    init(data: SocketRequestPaytoModel) {
        self.sender = data.sender
        self.receiver = data.receiver
        self.time = data.time
        self.type = data.type
        self.content = data.content
        self.senderPublicKey = data.senderPublicKey
        self.totalAmount = data.totalAmount
        self.channelSignature = data.channelSignature
        self.fullName = data.fullName ?? ""
        self.refId = data.refId
        if(data.refId != nil){
            self.type = EnumTransferType.STOPPING_SOCKET.rawValue
        }
    }
    
    // Use for Transfer eCash on Pay To & To Pay
    init(sender : String, receiver : String, time : String, type : String, content : String, id : String, cashEnc : String) {
        self.sender = sender
        self.receiver = receiver
        self.time = time
        self.type = type
        self.content = content
        self.id = id
        self.time = time
        self.cashEnc = cashEnc
    }
    
    // Use for Transfer eCash on Pay To & To Pay
    init(receiver: String, sender: String, senderPublicKey: String, time: String, totalAmount: String, type: String, content: String, fullName: String? = "", channelSignature: String) {
        self.receiver = receiver
        self.sender = sender
        self.senderPublicKey = senderPublicKey
        self.time = time
        self.totalAmount = totalAmount
        self.type = type
        self.content = content
        self.fullName = fullName
        self.channelSignature = channelSignature
    }
    
    //MyQRCode
    init(content : String, type: String) {
        self.content = content
        self.type = type
    }
}

struct CashEncModel : Codable {
    var id : Int64?
    var countryCode : String?
    var issuerCode  : String?
    var decisionNo : String?
    var serialNo   : String?
    var parValue : String?
    var activeDate  : String?
    var expireDate  : String?
    var status  : String?
    var treasureSignature : String?
    var accountSignature : String?
    var transactionSignature : String?
    init(id : Int64,
         countryCode : String,
         issuerCode  : String ,
         decisionNo : String,
         serialNo   : String,
         parValue : String,
         activeDate  : String,
         expireDate  : String,
         status  : String) {
        self.countryCode = countryCode
        self.issuerCode = issuerCode
        self.decisionNo = decisionNo
        self.serialNo = serialNo
        self.parValue = parValue
        self.activeDate = activeDate
        self.expireDate = expireDate
        self.status = status
        self.id = id
    }
    
    init() {
        
    }
    
    init(dataPackage : [String], transactionSignature : String) {
        if dataPackage.count >= 3{
            let data = dataPackage[0]
            let accountSign = dataPackage[1]
            let treasureSign = dataPackage[2]
            self.accountSignature = accountSign
            self.treasureSignature = treasureSign
            let array = data.components(separatedBy: ";")
            if array.count >= 8{
                self.countryCode = array[0]
                self.issuerCode = array[1]
                self.decisionNo = array[2]
                self.serialNo = array[3]
                self.parValue = array[4]
                self.activeDate = array[5]
                self.expireDate = array[6]
                self.status = array[7]
            }
            self.transactionSignature = transactionSignature
        }
    }
}
