//
//  UpdatedForgotPasswordRequest.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class UpdatedForgotPasswordRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var otpvalue : String?
    var password  : String?
    var transactionCode : String?
    var userId : String?
    var channelSignature : String?
    
    init(newPassword : String,userId : String,transactionCode : String, otpCode : String) {
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.UPDATED_FORGOT_PASSWORD.rawValue
        self.otpvalue = otpCode
        self.password = newPassword
        self.transactionCode = transactionCode
        self.userId =  userId
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(otpvalue!)\(password!)\(transactionCode)\(userId)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    init() {
        
    }
    
}
