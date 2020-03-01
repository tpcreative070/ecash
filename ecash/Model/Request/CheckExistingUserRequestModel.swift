//
//  CheckExistingUserModel.swift
//  ecash
//
//  Created by phong070 on 9/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class CheckExistingUserRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var idNumber : String?
    var personMobilePhone : String?
    var username : String?
    var channelSignature : String?
    
    
    /*Checking idNumber and Phone number*/
    init(channelCode : String,functionCode : String,idNumber : String, personMobilePhone : String) {
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = channelCode
        self.functionCode = functionCode
        self.idNumber = idNumber
        self.personMobilePhone = personMobilePhone
        let alphobelCode =   "\(auditNumber!)\(channelCode)\(functionCode)\(idNumber)\(personMobilePhone)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
  
    /*Checking username*/
    init(channelCode : String,functionCode : String,username : String) {
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = channelCode
        self.functionCode = functionCode
        self.username = username
        let alphobelCode =   "\(auditNumber!)\(channelCode)\(functionCode)\(username)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
