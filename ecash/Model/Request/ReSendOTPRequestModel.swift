//
//  ReSendOTPRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ReSendOTPRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
 
    init(finalPassword : String) {
        guard let mSignUp = CommonService.getSignUpStoreData() else {
            return
        }
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.RESEND_OTP.rawValue
        self.token = finalPassword
        self.username = mSignUp.username ?? ""
        self.walletId = mSignUp.walletId ?? "0"
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(token!)\(username!)\(walletId!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
