//
//  SignOutRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignOutRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init() {
        guard let mSignIn = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.SIGN_OUT.rawValue
        self.sessionId = mSignIn.sessionId ?? ""
        self.token = mSignIn.token ?? ""
        self.username = mSignIn.username ?? ""
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(sessionId!)\(token!)\(username!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
