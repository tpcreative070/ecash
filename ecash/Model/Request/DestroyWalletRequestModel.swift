//
//  DestroyWalletRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class DestroyWalletRequestModel  : Codable{
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
    var terminalId : String?
    var terminalInfo : String?
    
    init() {
        guard let mSignIn = CommonService.getSignInData() else {
            return
        }
        
        guard let mSignUp = CommonService.getSignUpStoreData() else {
            return
        }
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.DESTROY_WALLET.rawValue
        self.sessionId = mSignIn.sessionId ?? ""
        self.terminalId = CommonService.getUniqueId()
        self.terminalInfo = DeviceHelper.getDeviceInfo()
        self.token = mSignIn.token ?? ""
        self.username = mSignIn.username ?? ""
        self.walletId = mSignUp.walletId?.description ?? "0"
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(sessionId!)\(terminalId!)\(terminalInfo!)\(token!)\(username!)\(walletId!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
}
