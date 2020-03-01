//
//  SendOTPRequest.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SendOTPRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var username : String?
    var channelSignature : String?
    
    init(username : String) {
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.SEND_OTP.rawValue
        self.username = username
        let alphobelCode =  "\(self.auditNumber!)\(self.channelCode ?? "")\(self.functionCode ?? "")\(self.username ?? "")"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
}
