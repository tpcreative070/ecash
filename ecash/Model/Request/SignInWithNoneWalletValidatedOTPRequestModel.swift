//
//  NoneWalletRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/12/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInWithNoneWalletValidatedOTPRequestModel : Codable {
    var appName : String?
    var auditNumber : String?
    var channelCode : String?
    var firebaseToken : String?
    var functionCode : String?
    var otpvalue : String?
    var sessionId : String?
    var terminalId : String?
    var terminalInfor : String?
    var token : String?
    var transactionCode : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
    
    init(data : SignInWithNoneWalletViewModel,mOTPValue : String) {
        guard let mSignInData = CommonService.getSignInData() else {
            return
        }
        self.appName = ConfigKey.AppName.infoForKey() ?? ""
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.firebaseToken = CommonService.getFirebaseToken() ?? ""
        self.functionCode = EnumFunctionName.SIGN_IN_WITH_NONE_WALLET_VALIDATED_OTP.rawValue
        self.otpvalue = mOTPValue
        self.sessionId = mSignInData.sessionId ?? ""
        self.terminalId = sessionId
        self.terminalInfor = CommonService.getDeviceInfo()
        self.token = mSignInData.token ?? ""
        self.transactionCode = data.transactionCode ?? ""
        self.username = mSignInData.username ?? ""
        self.walletId = data.walletId ?? ""
        let alphobelCode =  "\(self.appName!)\(auditNumber!)\(self.channelCode!)\(self.firebaseToken!)\(self.functionCode!)\(self.otpvalue!)\(self.sessionId!)\(self.terminalId!)\(self.terminalInfor!)\(self.token!)\(self.transactionCode!)\(self.username!)\(self.walletId!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
