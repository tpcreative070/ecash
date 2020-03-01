//
//  SignInWithNoneWalletRequestModel.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInWithNoneWalletRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var channelId : String?
    var ecKeyPublicValue : String?
    var functionCode : String?
    var keyPublicAlias : String?
    var sessionId : String?
    var terminalId : String?
    var terminalInfo : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init(data : ELGamalModel) {
        guard let mSignInData = CommonService.getSignInData() else{
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.channelId = "3000"
        self.ecKeyPublicValue = data.publicKey ?? ""
        self.functionCode = EnumFunctionName.SIGN_IN_WITH_NONE_WALLET.rawValue
        self.keyPublicAlias = mSignInData.username ?? ""
        self.sessionId = mSignInData.sessionId ?? ""
        self.terminalId = CommonService.getUniqueId()
        self.terminalInfo = CommonService.getDeviceInfo()
        self.token = mSignInData.token ?? ""
        self.username = mSignInData.username ?? ""
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(channelId!)\(ecKeyPublicValue!)\(functionCode!)\(keyPublicAlias!)\(sessionId!)\(terminalId!)\(terminalInfo!)\(token!)\(username!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
