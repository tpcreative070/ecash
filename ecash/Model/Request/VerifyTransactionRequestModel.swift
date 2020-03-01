//
//  VerifyTransactionRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class VerifyTransactionRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var lastAccessTime : String?
    var masterKey : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
    
    init() {
        guard let mSignIn = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.VERIFY_TRANSACTION.rawValue
        self.lastAccessTime = CommonService.getLastAccessTimeKey() ?? ""
        self.masterKey = CommonService.getMasterKey() ?? ""
        self.sessionId = mSignIn.sessionId ?? ""
        self.terminalId = CommonService.getUniqueId()
        self.token = mSignIn.token ?? ""
        self.username = mSignIn.username ?? ""
        self.walletId = CommonService.getWalletId() ?? "0"
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(lastAccessTime!)\(masterKey!)\(sessionId!)\(terminalId!)\(token!)\(username!)\(walletId!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
