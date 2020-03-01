//
//  DenominationRequestModel.swift
//  ecash
//
//  Created by phong070 on 12/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class DenominationRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var issuerCodes : [String]?
    var sessionId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init() {
        guard let mSignInData = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.DENOMINATION.rawValue
        self.issuerCodes = ["ECPAY"]
        let mIssuerCodes = "[ECPAY]"
        self.sessionId = mSignInData.sessionId ?? ""
        self.token = mSignInData.token ?? ""
        self.username = mSignInData.username ?? ""
        let alphobelCode = "\(self.auditNumber!)\(self.channelCode!)\(self.functionCode!)\(mIssuerCodes)\(self.sessionId!)\(self.token!)\(self.username!)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
