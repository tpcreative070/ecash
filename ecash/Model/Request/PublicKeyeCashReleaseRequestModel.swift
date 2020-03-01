//
//  PublicKeyeCashReleaseRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PublicKeueCashReleaseRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var decisionCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init(decisionCode : String) {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
        let channelCode = "MB001"
        let functionCode = EnumFunctionName.ECASH_RELEASE.rawValue
        let sessionId = signInData.sessionId ?? ""
        let terminalId = CommonService.getUniqueId()
        let token = signInData.token ?? ""
        let username = signInData.username ?? ""
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode =  channelCode
        self.decisionCode = decisionCode
        self.functionCode = functionCode
        self.sessionId = sessionId
        self.terminalId = terminalId
        self.token = token
        self.username = username
        let alphobelCode =  "\(auditNumber!)\(channelCode)\(decisionCode)\(functionCode)\(sessionId)\(terminalId)\(token)\(username)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
