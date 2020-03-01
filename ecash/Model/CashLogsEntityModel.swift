//
//  CashLogsEntityModel.swift
//  ecash
//
//  Created by phong070 on 9/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct CashLogsEntityModel : Codable{
    var id : Int?
    var countryCode : String?
    var issuerCode : String?
    var decisionNo : String?
    var serial   : Int64?
    var value  : Int64?
    var actived  : String?
    var expired  : String?
    var accountSignature  : String?
    var cycle  : Int?
    var treasureSignature  : String?
    // Input/output
    var type  : Bool?
    var transactionSignature  : String?
    var previousHash : String?
    var verify : Bool?
    var data : String?
    
    init(data : ExchangeCashModel) {
        self.id = data.id
        self.countryCode = data.countryCode
        self.issuerCode = data.issuerCode
        self.decisionNo = data.decisionNo
        self.serial = data.serial
        self.value = data.value
        self.actived = data.actived
        self.expired = data.expired
        self.accountSignature = data.accountSignature
        self.cycle = data.cycle
        self.treasureSignature = data.treasureSignature
        self.type = data.type
        self.transactionSignature = data.transactionSignature
        self.previousHash = data.previousHash
        self.verify = data.verify
        self.data = data.data
    }
    
    init(id : Int,
        countryCode : String,
        issuerCode : String,
        decisionNo : String,
        serial   : Int64,
        value  : Int64,
        actived  : String,
        expired  : String,
        accountSignature  : String,
        cycle  : Int,
        treasureSignature  : String,
        // Input/output
        type  : Bool,
        transactionSignature  : String,
        previousHash : String) {
        self.id = id
        self.countryCode = countryCode
        self.issuerCode = issuerCode
        self.decisionNo = decisionNo
        self.serial = serial
        self.value = value
        self.actived = actived
        self.expired = expired
        self.accountSignature = accountSignature
        self.cycle = cycle
        self.treasureSignature = treasureSignature
        self.type = type
        self.transactionSignature = transactionSignature
        self.previousHash = previousHash
    }
    
    //TuanLe - add 4/2/2020
    //this function caculate previous has value bases on cashLog entity
    //return previousHash value
    func caculatePreviousHash(cashLogs : CashLogsEntityModel? = nil) -> String?{
        let alphobelCode =  "\(String(cashLogs?.countryCode ?? ""))\(String(cashLogs?.issuerCode ?? ""))\(String(cashLogs?.decisionNo ?? ""))\(String(cashLogs?.serial ?? 0))\(String(cashLogs?.value ?? 0))\(String(cashLogs?.actived ?? ""))\(String(cashLogs?.expired ?? ""))\(String(cashLogs?.accountSignature ?? ""))\(String(cashLogs?.cycle ?? 0))\(String(cashLogs?.treasureSignature ?? ""))\(String(cashLogs?.type ?? true))\(String(cashLogs?.transactionSignature ?? ""))"
        debugPrint(alphobelCode)
        let previousHash = ELGamalHelper.instance.signatureCashTransactionsLogs(data: alphobelCode.sha256Data())
        debugPrint(previousHash)
        return previousHash
    }
    
    //Receive eCash
    init(data : CashEncModel,inputOutput : Bool, dataExisting : CashLogsEntityModel? = nil) {
        guard let mDataExisting = dataExisting else {
            self.countryCode = data.countryCode
            self.issuerCode = data.issuerCode
            self.decisionNo = data.decisionNo
            self.serial = Int64(data.serialNo ?? "0")
            self.value = Int64(data.parValue ?? "0")
            self.actived = data.activeDate
            self.expired = data.expireDate
            self.accountSignature = data.accountSignature
            self.cycle = Int(data.status ?? "0")
            self.treasureSignature = data.treasureSignature
            self.type = inputOutput
            self.transactionSignature = data.transactionSignature
            let alphobelCode =  "\(countryCode ?? "" )\(issuerCode ?? "")\(decisionNo ?? "")\(serial ?? 0)\(value ?? 0)\(actived ?? "")\(expired ?? "")\(accountSignature ?? "")\(cycle ?? 0)\(treasureSignature ?? "")\(type ?? false)\(transactionSignature ?? "")"
            debugPrint(alphobelCode)
            self.previousHash = ELGamalHelper.instance.signatureCashTransactionsLogs(data: alphobelCode.sha256Data())
            return
        }
        
        self.countryCode = data.countryCode
        self.issuerCode = data.issuerCode
        self.decisionNo = data.decisionNo
        self.serial = Int64(data.serialNo ?? "0")
        self.value = Int64(data.parValue ?? "0")
        self.actived = data.activeDate
        self.expired = data.expireDate
        self.accountSignature = data.accountSignature
        self.cycle = Int(data.status ?? "0")
        self.treasureSignature = data.treasureSignature
        self.type = inputOutput
        self.transactionSignature = data.transactionSignature
        self.previousHash = caculatePreviousHash(cashLogs: mDataExisting)
    }
    
    //Send eCash
    init(dataSender : CashLogsEntityModel,inputOutput : Bool, dataExisting : CashLogsEntityModel? = nil) {
        guard let mDataExisting = dataExisting else {
            self = dataSender
            let alphobelCode =  "\(countryCode ?? "" )\(issuerCode ?? "")\(decisionNo ?? "")\(serial ?? 0)\(value ?? 0)\(actived ?? "")\(expired ?? "")\(accountSignature ?? "")\(cycle ?? 0)\(treasureSignature ?? "")\(type ?? false)\(transactionSignature ?? "")"
            debugPrint(alphobelCode)
            self.previousHash = ELGamalHelper.instance.signatureCashTransactionsLogs(data: alphobelCode.sha256Data())
            return
        }
        self = dataSender
        self.previousHash = caculatePreviousHash(cashLogs: mDataExisting)
    }
    
    init(data : CashLogsEntityModel,inputOutput : Bool, dataExisting : CashLogsEntityModel? = nil) {
        guard let mDataExisting = dataExisting else {
            self = data
            let alphobelCode =  "\(countryCode ?? "" )\(issuerCode ?? "")\(decisionNo ?? "")\(serial ?? 0)\(value ?? 0)\(actived ?? "")\(expired ?? "")\(accountSignature ?? "")\(cycle ?? 0)\(treasureSignature ?? "")\(type ?? false)\(transactionSignature ?? "")"
            debugPrint(alphobelCode)
            self.previousHash = ELGamalHelper.instance.signatureCashTransactionsLogs(data: alphobelCode.sha256Data())
            return
        }
        
        //Merged previous hash
        self = data
        self.previousHash = caculatePreviousHash(cashLogs: mDataExisting)
        
    }
    
    init() {
        
    }
    
    init(isAccSign : Bool, data : CashLogsEntityModel, response : DecisionsDiaryEntityModel) {
        self = data
        let valueAssign = isAccSign ? "" : ";\(data.cycle?.description ?? "")"
        let stringData = "\(countryCode ?? "");\(issuerCode ?? "");\(serial ?? 0);\(decisionNo ?? "");\(value ?? 0);\(actived ?? "");\(expired ?? "")\(valueAssign)"
        var verify : Bool!
        if isAccSign{
            verify = ELGamalHelper.instance.verifyDataCash(signature: data.accountSignature ?? "", data: stringData, publicKeySender: response.accountPublicKeyValue ?? "")
        }else{
              verify = ELGamalHelper.instance.verifyDataCash(signature: data.treasureSignature ?? "", data: stringData, publicKeySender: response.treasurePublicKeyValue ?? "")
        }
        self.verify = verify
        debugPrint("Verify eCash \(verify.description)")
    }
    
    //Send eCash to eCash
    init(mDataExisting : CashLogsEntityModel) {
        self = mDataExisting
        let mCountryCode = mDataExisting.countryCode ?? ""
        let mIssuerCode = mDataExisting.issuerCode ?? ""
        let mDecisionNo = mDataExisting.decisionNo ?? ""
        let mSerial =     mDataExisting.serial ?? 0
        let mValue =      mDataExisting.value ?? 0
        let mActived = mDataExisting.actived ?? ""
        let mExpired = mDataExisting.expired ?? ""
        let mCycle = mDataExisting.cycle ?? 0
        let alphobelCode =  "\(mCountryCode);\(mIssuerCode);\(mDecisionNo);\(mSerial);\(mValue);\(mActived);\(mExpired);\(mCycle)"
        self.data = alphobelCode
    }
    
}
