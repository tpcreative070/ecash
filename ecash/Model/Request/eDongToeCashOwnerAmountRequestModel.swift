//
//  eDongToeCashOwnerAmountRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongToeCashOwnerAmountRequestModel : Codable {
    var amount : Int?
    var auditNumber : String?
    var channelCode : String?
    var creditAccount : String?
    var debitAccount : String?
    var functionCode : String?
    var receiver : String?
    var sender : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init(amount : Int, mDebitAccount : String, receiverToSomeone : String? = nil) {
        guard let mSignIn = CommonService.getSignInData() else {
            return
        }
        guard let mSignUp = CommonService.getSignUpStoreData() else {
            return
        }
        self.amount = amount
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.creditAccount = CipherKey.EDONGECPAY.description
        self.debitAccount = mDebitAccount
        self.functionCode = EnumFunctionName.EDONG_TO_ECASH_OWNER_AMOUNT.rawValue
        self.receiver = mSignUp.walletId?.description ?? ""
        if let mValue = receiverToSomeone {
            self.receiver = mValue
        }
        self.sender = mSignUp.walletId?.description ?? ""
        self.sessionId = mSignIn.sessionId ?? ""
        self.terminalId = CommonService.getUniqueId()
        self.token = mSignIn.token ?? ""
        self.username = mSignIn.username ?? ""
        let alphobelCode =  "\(amount.description)\(auditNumber!)\(channelCode!)\(creditAccount!)\(debitAccount!)\(functionCode!)\(receiver!)\(sender!)\(sessionId!)\(terminalId!)\(token!)\(username!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
}
