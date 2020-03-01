//
//  TransactionsLogsEntityModel.swift
//  ecash
//
//  Created by phong070 on 9/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct TransactionsLogsEntityModel : Codable {
    var id : Int?
    var senderAccountId : Int64?
    var receiverAccountId : Int64?
    var type : String?
    var time : String?
    var content : String?
    var cashEnc : String?
    var refId : String?
    var transactionSignature : String?
    var previousHash : String?
    
    init(id : Int,
        senderAccountId : Int64,
        receiverAccountId : Int64,
        type : String,
        time : String,
        content : String,
        cashEnc : String,
        refId : String,
        transactionSignature : String,
        previousHash : String) {
        self.id = id
        self.senderAccountId = senderAccountId
        self.receiverAccountId = receiverAccountId
        self.type = type
        self.time = time
        self.content = content
        self.cashEnc = cashEnc
        self.refId = refId
        self.transactionSignature = transactionSignature
        //let alphobelCode =  "\(id)\(senderAccountId)\(receiverAccountId)\(type)\(time)\(content)\(cashEnc)"
        //debugPrint(alphobelCode)
        self.previousHash = previousHash
    }
    
    //TuanLe - add 4/2/2020
    //this function caculate previous has value bases on TransactionsLogs entity
    //return previousHash value
    func caculatePreviousHash(transactionsLogs: TransactionsLogsEntityModel? = nil) -> String{
        let alphobelCode =  "\(String(transactionsLogs?.senderAccountId ?? 0))\(String(transactionsLogs?.receiverAccountId ?? 0))\(String(transactionsLogs?.type ?? ""))\(String(transactionsLogs?.time ?? ""))\(String(transactionsLogs?.content ?? ""))\(String(transactionsLogs?.cashEnc ?? ""))\(String(transactionsLogs?.refId ?? ""))\(String(transactionsLogs?.transactionSignature ?? ""))"
        debugPrint(alphobelCode)
        let previousHash = ELGamalHelper.instance.signatureCashTransactionsLogs(data: alphobelCode.sha256Data())
        debugPrint(previousHash)
        return previousHash
    }
  
    init(data : TransferDataModel, dataExisting : TransactionsLogsEntityModel? = nil) {
        guard let mDataExisting = dataExisting else {
            self.senderAccountId = Int64(data.sender ?? "0")
            self.receiverAccountId = Int64(data.receiver ?? "0")
            self.type = data.type
            self.time = data.time
            self.content = data.content ?? ""
            self.cashEnc = data.cashEnc
            self.refId = data.refId ?? ""
            self.transactionSignature = data.id ?? ""
            let alphobelCode =  "\(senderAccountId ?? 0)\(receiverAccountId ?? 0)\(type ?? "")\(time ?? "")\(content ?? "")\(cashEnc ?? "")\(refId ?? "")\(transactionSignature ?? "")"
            debugPrint(alphobelCode)
            self.previousHash = ELGamalHelper.instance.signatureCashTransactionsLogs(data: alphobelCode.sha256Data())
            return
        }
        
        self.senderAccountId = Int64(data.sender ?? "0")
        self.receiverAccountId = Int64(data.receiver ?? "0")
        self.type = data.type
        self.time = data.time
        self.content = data.content ?? ""
        self.cashEnc = data.cashEnc
        self.refId = data.refId ?? ""
        self.transactionSignature = data.id ?? ""
        self.previousHash = caculatePreviousHash(transactionsLogs: mDataExisting)
    }
    
    init() {
        
    }
}
