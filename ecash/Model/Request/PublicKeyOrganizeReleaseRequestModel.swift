//
//  PublicKeyOrganizeReleaseRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct PublicKeyOrganizeReleaseRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var issuerCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init() {
        guard let mSignInData = CommonService.getSignInData() else {
            return
        }
        
        let mChannelCode  = EnumChannelName.MB001.rawValue
        let mFunctionCode  = EnumFunctionName.ORGANIZE_RELEASE.rawValue
        let mIssuerCode = "ECPAY"
        let mSessionId  = mSignInData.sessionId ?? ""
        let mTerminalId = CommonService.getUniqueId()
        let mToken = mSignInData.token ?? ""
        let mUsername = mSignInData.username ?? ""
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = mChannelCode
        self.functionCode = mFunctionCode
        self.issuerCode = mIssuerCode
        self.sessionId = mSessionId
        self.terminalId = mTerminalId
        self.token = mToken
        self.username = mUsername
        
        let alphobelCode = "\(auditNumber!)\(mChannelCode)\(mFunctionCode)\(mIssuerCode)\(mSessionId)\(mTerminalId)\(mToken)\(mUsername)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
    
    
}
