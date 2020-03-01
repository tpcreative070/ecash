//
//  eDongInfoRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongInfoRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId  : String?
    var terminalInfo : String?
    var token : String?
    var username : String?
    var waletId : String?
    var channelSignature : String?
    
    init() {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
       
        let channelCode = "MB001"
        let functionCode = EnumFunctionName.GET_EDONG.rawValue
        let auditNumber = CommonService.getRandomAlphaNumericInt(length: 15)
        let sessionId = signInData.sessionId ?? ""
        let terminalId = CommonService.getUniqueId()
        let terminalInfo = DeviceHelper.getDeviceInfo()
        let token = signInData.token ?? ""
        let username = signInData.username ?? ""
        
        self.auditNumber = auditNumber.description
        self.channelCode =  channelCode
        self.functionCode = functionCode
        self.sessionId = sessionId
        self.terminalId = terminalId
        self.terminalInfo = terminalInfo
        self.token = token
        self.username = signInData.username ?? ""
       
        let alphobelCode =  "\(auditNumber)\(channelCode)\(functionCode)\(sessionId)\(terminalId)\(terminalInfo)\(token)\(username )"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
