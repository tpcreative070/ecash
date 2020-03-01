//
//  WalletInfoRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct WalletInfoRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
    
    init(walletId : String) {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
      
        let channelCode = "MB001"
        let functionCode = EnumFunctionName.WALLET_INFO.rawValue
        let sessionId = signInData.sessionId ?? ""
        let terminalId = CommonService.getUniqueId()
        let token = signInData.token ?? ""
        let username = signInData.username ?? ""
        let walletId = walletId
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode =  channelCode
        self.functionCode = functionCode
        self.sessionId = sessionId
        self.terminalId = terminalId
        self.token = token
        self.username = username
        self.walletId = walletId
        let alphobelCode =  "\(auditNumber!)\(channelCode)\(functionCode)\(sessionId)\(terminalId)\(token)\(username)\(walletId)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
