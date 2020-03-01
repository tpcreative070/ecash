//
//  SiginNoneWalletStoreModel.swift
//  ecash
//
//  Created by phong070 on 9/13/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInNoneWalletStoreModel : Codable {
    var channelCode : String?
    var channelId : String?
    var customerId : String?
    var ecKeyPublicValue : String?
    var functionCode : String?
    var keyPublicAlias : String?
    var sessionId : String?
    var terminalId : String?
    var terminalInfo : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    var functionId : String?
    var walletId : String?
    var masterKey : String?
    var personFirstName : String?
    var personLastName : String?
    var personMiddleName : String?
    
    var personEmail : String?
    var personCurrentAddress : String?
    var wardName : String?
    var districtName : String?
    var provinceName : String?
    var countryName : String?
    
    init(data : SignInNoneWalletValidatedOTPData) {
        self.channelCode = data.channelCode
        self.channelId = data.channelId
        self.customerId = data.customerId
        self.ecKeyPublicValue = data.ecKeyPublicValue
        self.functionCode = data.functionCode
        self.keyPublicAlias = data.keyPublicAlias
        self.sessionId = data.sessionId
        self.terminalId = data.terminalId
        self.terminalInfo = data.terminalInfo
        self.token = data.token
        self.username = data.username
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId
        self.walletId = data.walletId
        self.masterKey = data.masterKey
        self.personFirstName = data.personFirstName
        self.personLastName = data.personLastName
        self.personMiddleName = data.personMiddleName
        
        self.personEmail  = data.personEmail
        self.personCurrentAddress  = data.personCurrentAddress
        self.wardName = data.wardName
        self.districtName = data.districtName
        self.provinceName = data.provinceName
        self.countryName = data.countryName
    }
}
