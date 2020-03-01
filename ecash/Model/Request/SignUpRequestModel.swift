//
//  SignUpRequestModel.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignUpRequestModel  : Codable{
    var appName : String?
    var auditNumber : String?
    var channelCode : String?
    var firebaseToken : String?
    var functionCode : String?
    var idNumber : String?
    var keyPublicAlias : String?
    var ecKeyPublicValue : String?
    var password : String?
    var personFirstName : String?
    var personLastName : String?
    var personMiddleName : String?
    var personMobilePhone : String?
    var terminalId : String?
    var terminalInfo : String?
    var username : String?
    var channelSignature : String?
    var nickname : String?
  
    init( channelCode : String,
        functionCode : String,
        idNumber : String,
        keyPublicAlias : String,
        ecKeyPublicValue : String,
        nickname : String,
        password : String,
        personFirstName : String,
        personLastName : String,
        personMiddleName : String,
        personMobilePhone : String,
        terminalId : String,
        terminalInfo : String,
        username : String) {
        self.appName = ConfigKey.AppName.infoForKey()
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = channelCode
        self.firebaseToken = CommonService.getFirebaseToken() ?? ""
        self.functionCode = functionCode
        self.idNumber = idNumber
        self.keyPublicAlias = keyPublicAlias
        self.ecKeyPublicValue = ecKeyPublicValue
        self.nickname = nickname
        self.password = password
        self.personFirstName = personFirstName
        self.personLastName = personLastName
        self.personMiddleName = personMiddleName
        self.personMobilePhone = personMobilePhone
        self.terminalId = terminalId
        self.terminalInfo = terminalInfo
        self.username = username
        let alphobelCode =   "\(appName ?? "")\(auditNumber!)\(channelCode)\(ecKeyPublicValue)\(firebaseToken ?? "")\(functionCode)\(idNumber)\(keyPublicAlias)\(nickname)\(password)\(personFirstName)\(personLastName)\(personMiddleName)\(personMobilePhone)\(terminalId)\(terminalInfo)\(username)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
}
