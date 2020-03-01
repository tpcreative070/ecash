//
//  DeleteContactModel.swift
//  ecash
//
//  Created by phong070 on 2/11/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class DeleteContactRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
       
    init(walletId : String) {
        guard let mSignInData = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.DeleteContact.rawValue
        self.sessionId = mSignInData.sessionId ?? ""
        self.token = mSignInData.token ?? ""
        self.username = mSignInData.username ?? ""
        self.walletId = walletId
        let alphobelCode = "\(self.auditNumber!)\(self.channelCode!)\(self.functionCode!)\(self.sessionId!)\(self.token!)\(self.username!)\(self.walletId!)"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
