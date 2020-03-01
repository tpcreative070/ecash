//
//  SearchByPhoneRequestModel.swift
//  ecash
//
//  Created by phong070 on 10/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SearchByPhoneRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var personMobilePhone : String?
    var sessionId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    
    init(phoneNumber : String) {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.SEARCH_BY_PHONE.rawValue
        self.personMobilePhone = phoneNumber
        self.sessionId = signInData.sessionId
        self.token = signInData.token
        self.username = signInData.username
        let alphobelCode =  "\(self.auditNumber!)\(self.channelCode ?? "")\(self.functionCode ?? "")\(self.personMobilePhone ?? "")\(self.sessionId ?? "")\(self.token ?? "")\(self.username ?? "")"
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
}
