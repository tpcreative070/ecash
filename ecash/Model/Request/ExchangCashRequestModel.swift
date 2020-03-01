//
//  ExchangCashRequestModel.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExchangeCashRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var cashEnc : String?
    var quantities : [Int]?
    var values : [Int]?
    var token : String?
    var username : String?
    var channelSignature : String?
    var sender : String?
    var receiver : String?
    var sessionId : String?

    init(transferData : TransferDataModel, expectationCash : ExpectationCashData) {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
        let mCashEnc = transferData.cashEnc ?? ""
        let mChannelCode = EnumChannelName.MB001.rawValue
        let mFunctionCode = EnumFunctionName.EXCHANGE_CASH.rawValue
        let mQuantities = expectationCash.quantities
        let mReceiver = transferData.receiver ?? ""
        let mSender = transferData.sender ?? ""
        let mSessionId = signInData.sessionId ?? ""
        let mToken = signInData.token ?? ""
        let mUsername = signInData.username ?? ""
        let mValues = expectationCash.value
       
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.cashEnc = mCashEnc
        self.channelCode  = mChannelCode
        self.functionCode = mFunctionCode
        self.quantities  = mQuantities
        self.receiver = mReceiver
        self.sender = mSender
        self.sessionId = mSessionId
        self.token  = mToken
        self.username  = mUsername
        self.values  = mValues
        let alphobelCode =  "\(auditNumber!)\(mCashEnc)\(mChannelCode)\(mFunctionCode)\(mQuantities)\(mReceiver)\(mSender)\(mSessionId)\(mToken)\(mUsername)\(mValues)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    init() {
        
    }
}
