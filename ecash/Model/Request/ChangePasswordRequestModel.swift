//
//  Change.swift
//  ecash
//
//  Created by phong070 on 9/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ChangePasswordRequestModel  : Codable{
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var password : String?
    var sessionId : String?
    var token : String?
    var username : String?
    var userId : String?
    var channelSignature : String?
    
    init(oldPassword : String,newPassword : String) {
        guard let mSignIn = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.CHANGE_PASSWORD.rawValue
        self.password = newPassword
        self.sessionId = mSignIn.sessionId ?? ""
        self.token = oldPassword
        self.userId = mSignIn.userId ?? ""
        self.username = mSignIn.username ?? ""
      
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(password!)\(sessionId!)\(token!)\(userId!)\(username!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    init() {
        
    }
}
