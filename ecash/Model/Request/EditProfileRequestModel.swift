//
//  EditProfileRequestModel.swift
//  ecash
//
//  Created by phong070 on 12/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class EditProfileRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var newCustomerId : String?
    var idNumber : String?
    var personMobilePhone : String?
    var personFirstName : String?
    var personMiddleName : String?
    var personLastName : String?
    var personCurrentAddress : String?
    var personEmail : String?
    var username : String?
    var token : String?
    var sessionId : String?
    var channelSignature : String?
    
    init(firstName : String,middleName : String,lastName : String,email : String,address : String,mIdNumber : String) {
        guard let mSignIn = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.EDIT_PROFILE.rawValue
        self.idNumber = mIdNumber
        self.newCustomerId = mSignIn.customerId?.description ?? ""
        self.personCurrentAddress = address
        self.personEmail = email
        self.personFirstName = firstName
        self.personLastName = lastName
        self.personMiddleName = middleName
        self.personMobilePhone = CommonService.getPhoneNumber()
        self.sessionId = mSignIn.sessionId
        self.token = mSignIn.token ?? ""
        self.username = mSignIn.username ?? ""

       
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(idNumber!)\(newCustomerId!)\(personCurrentAddress!)\(personEmail!)\(personFirstName!)\(personLastName!)\(personMiddleName!)\(personMobilePhone!)\(sessionId!)\(token!)\(username!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
    init() {
        
    }
}
