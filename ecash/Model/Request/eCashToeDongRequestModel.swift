//
//  eCashToeDongRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/10/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct eCashToeDongRequestModel : Codable {
    var amount : Int?
    var auditNumber : String?
    var cashEnc : String?
    var channelCode : String?
    var content : String?
    var creditAccount : String?
    var debitAccount : String?
    var functionCode : String?
    var id : String?
    var receiver : String?
    var sender : String?
    var sessionId : String?
    var terminalId : String?
    var time : String?
    var token : String?
    var type : String?
    var username : String?
    var channelSignature : String?
    
    init(data : TransferDataModel, amount : Int ,creditAccount : String) {
        guard let mSignInData = CommonService.getSignInData() else {
            return
        }
        
        let mAmount = amount
        let mCashEnc = data.cashEnc ?? ""
        let mChannelCode  = EnumChannelName.MB001.rawValue
        let mContent  = "sell"
        let mCreditAccount  = creditAccount
        let mDebitAccount = CipherKey.EDONGECPAY
        let mFunctionCode  = EnumFunctionName.ECASH_TO_EDONG.rawValue
        let mId  = data.id ?? ""
        let mReceiver = data.receiver ?? ""
        let mSender = data.sender ?? ""
        let mSessionId  = mSignInData.sessionId ?? ""
        let mTerminalId = CommonService.getUniqueId()
        let mTime = data.time ?? ""
        let mToken = mSignInData.token ?? ""
        let mType = data.type ?? ""
        let mUsername = mSignInData.username ?? ""
        
        self.amount = mAmount
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.cashEnc = mCashEnc
        self.channelCode = mChannelCode
        self.content = mContent
        self.creditAccount = mCreditAccount
        self.debitAccount = mDebitAccount.description
        self.functionCode = mFunctionCode
        self.id = mId
        self.receiver = mReceiver
        self.sender = mSender
        self.sessionId = mSessionId
        self.terminalId = mTerminalId
        self.time = mTime
        self.token = mToken
        self.type = mType
        self.username = mUsername
        
        let alphobelCode =  "\(mAmount)\(auditNumber!)\(mCashEnc)\(mChannelCode)\(mContent)\(mCreditAccount)\(mDebitAccount)\(mFunctionCode)\(mId)\(mReceiver)\(mSender)\(mSessionId)\(mTerminalId)\(mTime)\(mToken)\(mType)\(mUsername)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
    init() {
        
    }
    
    
    
}
