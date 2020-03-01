//
//  eDongToeCashRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/10/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongToeCashRequestModel : Codable {
    var amount : Int?
    var auditNumber : String?
    var channelCode : String?
    var creditAccount : String?
    var debitAccount : String?
    var functionCode : String?
    var quantities : [Int]?
    var receiver : String?
    var sender : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var values : [Int]?
    var channelSignature : String?
    
    init(amount : Int,
         quantities : [Int],
         values : [Int] ,mDebitAccount : String, receiverToSomeone : String? = nil) {
       
        guard let signInData = CommonService.getSignInData() else {
            return
        }
        guard let signUpData = CommonService.getSignUpStoreData() else {
            return
        }
       
        let mChannelCode = "MB001"
        let mSessionId = signInData.sessionId ?? ""
        let mTerminalId = CommonService.getUniqueId()
        let mToken = signInData.token ?? ""
        let mUsername = signInData.username ?? ""
        let mCreditAccount = CipherKey.EDONGECPAY.description
        let mDebitAccount = mDebitAccount
        var mReceiver = signUpData.walletId?.description ?? ""
        if let mValue = receiverToSomeone {
            mReceiver = mValue
        }
        let mSender = signUpData.walletId?.description ?? ""
        let mAmount = amount
        let mQuantities = quantities
        let mValues = values
        let mFunctionCode = EnumFunctionName.EDONG_TO_ECASH_OWNER.rawValue
        
        self.amount  = mAmount
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode  = mChannelCode
        self.creditAccount  = mCreditAccount
        self.debitAccount  = mDebitAccount
        self.functionCode = mFunctionCode
        self.quantities  = mQuantities
        self.receiver  = mReceiver
        self.sender  = mSender
        self.sessionId  = mSessionId
        self.terminalId  = mTerminalId
        self.token  = mToken
        self.username  = mUsername
        self.values  = mValues
       
        let alphobelCode =  "\(mAmount)\(auditNumber!)\(mChannelCode)\(mCreditAccount)\(mDebitAccount)\(mFunctionCode)\(mQuantities)\(mReceiver)\(mSender)\(mSessionId)\(mTerminalId)\(mToken)\(mUsername)\(mValues)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    init() {
        
    }
}
