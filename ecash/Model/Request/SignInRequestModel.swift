//
//  SignInRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInRequestModel : Codable{
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var terminalId : String?
    var token : String?
    var transactionId : String?
    var username : String?
    var uuid : String?
    var channelSignature : String?
    
    init(channelCode : String,
     functionCode : String,
     terminalId : String,
     token : String,
     transactionId : String,
     username : String,
     uuid : String) {
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = channelCode
        self.functionCode = functionCode
        self.terminalId = terminalId
        self.token = token
        self.transactionId = transactionId
        self.username = username
        self.uuid = uuid
        let alphobelCode =  "\(self.auditNumber!)\(channelCode)\(functionCode)\(terminalId)\(token)\(transactionId)\(username)\(uuid)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    init() {
        
    }
}
