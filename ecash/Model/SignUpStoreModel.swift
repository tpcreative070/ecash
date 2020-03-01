//
//  SignUpStoreModel.swift
//  ecash
//
//  Created by phong070 on 9/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct SignUpStoreModel : Codable{
    var channelCode : String?
    var functionCode : String?
    var idNumber : String?
    var keyPublicAlias : String?
    var password : String?
    var personFirstName : String?
    var personLastName : String?
    var personMiddleName : String?
    var personMobilePhone : String?
    var terminalId : String?
    var terminalInfo : String?
    var username : String?
    var channelSignature : String?
    var functionId : String?
    var channelId : String?
    var customerId : String?
    var nickname : String?
    var groupId : String?
    var userId : String?
    var dateCreated : String?
    var walletId : String?
    var masterKey : String?
    
    var auditNumber : String?
    var accountIdt : String?
    var otptimeCreated : String?
    var otpid : String?
    var otpvalue : String?
    var otptimeExpired : String?
    var otptimeRenew : String?
    var otpnumberOfFailure : String?
    
    var transactionCode : String?
    var cuKeyPublicValue : String?
    var lastAccessTime : String?
    var requirePasschange : String?
    var ecKeyPublicValue  : String?
    
    var personEmail : String?
    var personCurrentAddress : String?
    var wardName : String?
    var districtName : String?
    var provinceName : String?
    var countryName : String?
    
    init() {
        
    }
    
    init(data : SignUpStoreModel) {
        self = data
    }
    
    init(data : SignUpInforModel) {
        self.channelCode = data.channelCode
        self.functionCode = data.functionCode
        self.idNumber = data.idNumber
        self.keyPublicAlias = data.keyPublicAlias
        self.password = data.password
        self.personFirstName = data.personFirstName
        self.personLastName = data.personLastName
        self.personMiddleName = data.personMiddleName
        self.personMobilePhone = data.personMobilePhone
        self.terminalId = data.terminalId
        self.terminalInfo = data.terminalInfo
        self.username = data.username
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.customerId = data.customerId
        self.nickname = data.nickname
        self.groupId = data.groupId
        self.userId = data.userId
        self.dateCreated = data.dateCreated
        self.walletId = data.walletId
        SQLHelper.replaceKey(mKey: data.masterKey ?? CipherKey.Key)
        CommonService.setLastAccessTimeKey(data: data.lastAccessTime ?? "")
        self.masterKey = "null"
        self.auditNumber = data.auditNumber
        self.accountIdt = data.accountIdt
        self.otptimeCreated = data.otptimeCreated
        self.otpid = data.otpid
        self.otpvalue = data.otpvalue
        self.otptimeExpired = data.otptimeExpired
        self.otptimeRenew = data.otptimeRenew
        self.otpnumberOfFailure = data.otpnumberOfFailure
        
        self.transactionCode = data.transactionCode
        self.cuKeyPublicValue = data.cuKeyPublicValue
        self.lastAccessTime = "null"
        self.requirePasschange = data.requirePasschange
        self.ecKeyPublicValue  = data.ecKeyPublicValue
        
        self.personEmail  = data.personEmail
        self.personCurrentAddress  = data.personCurrentAddress
        self.wardName = data.wardName
        self.districtName = data.districtName
        self.provinceName = data.provinceName
        self.countryName = data.countryName
        
    }
    
    init(data : SignUpInforModel,request : SignUpRequestModel) {
        self.channelCode = data.channelCode
        self.functionCode = data.functionCode
        self.idNumber = data.idNumber
        self.keyPublicAlias = data.keyPublicAlias
        self.password = request.password
        self.personFirstName = request.personFirstName
        self.personLastName = request.personLastName
        self.personMiddleName = request.personMiddleName
        self.personMobilePhone = request.personMobilePhone
        self.terminalId = request.terminalId
        self.terminalInfo = request.terminalInfo
        self.username = request.username
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.customerId = data.customerId
        self.nickname = data.nickname
        self.groupId = data.groupId
        self.userId = data.userId
        self.dateCreated = data.dateCreated
        self.walletId = data.walletId
        SQLHelper.replaceKey(mKey: data.masterKey ?? CipherKey.Key)
        CommonService.setLastAccessTimeKey(data: data.lastAccessTime ?? "")
        self.masterKey = "null"
        self.auditNumber = data.auditNumber
        self.accountIdt = data.accountIdt
        self.otptimeCreated = data.otptimeCreated
        self.otpid = data.otpid
        self.otpvalue = data.otpvalue
        self.otptimeExpired = data.otptimeExpired
        self.otptimeRenew = data.otptimeRenew
        self.otpnumberOfFailure = data.otpnumberOfFailure
        
        self.transactionCode = data.transactionCode
        self.cuKeyPublicValue = data.cuKeyPublicValue
        self.lastAccessTime = "null"
        self.requirePasschange = data.requirePasschange
        self.ecKeyPublicValue  = data.ecKeyPublicValue
        
        self.personEmail  = data.personEmail
        self.personCurrentAddress  = data.personCurrentAddress
        self.wardName = data.wardName
        self.districtName = data.districtName
        self.provinceName = data.provinceName
        self.countryName = data.countryName
        
    }
    
    init(data : SignInNoneWalletValidatedOTPData,viewModel : SignInWithNoneWalletViewModel) {
        self.channelId = data.channelId?.description
        self.channelCode = data.channelCode
        self.functionCode = data.functionCode
        self.idNumber = data.idNumber ?? ""
        self.keyPublicAlias = data.keyPublicAlias
        self.password = data.token
        self.personFirstName = data.personFirstName ?? ""
        self.personLastName = data.personLastName ?? ""
        self.personMiddleName = data.personMiddleName ?? ""
        self.personMobilePhone = data.personMobilePhone ?? ""
        self.terminalId = data.terminalId
        self.terminalInfo = data.terminalInfo
        self.username = data.username
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId?.description
        self.customerId = data.customerId
        self.nickname = "null"
        self.groupId = "0"
        self.userId = data.userId ?? ""
        self.dateCreated = "null"
        self.walletId = viewModel.walletId ?? ""
        SQLHelper.replaceKey(mKey: viewModel.masterKey ?? CipherKey.Key)
        CommonService.setLastAccessTimeKey(data: viewModel.lastAccessTime ?? "")
        self.masterKey = "null"
        self.auditNumber = "null"
        self.accountIdt = "0"
        self.otptimeCreated = "null"
        self.otpid = "null"
        self.otpvalue = "null"
        self.otptimeExpired = "null"
        self.otptimeRenew = "null"
        self.otpnumberOfFailure = "null"
        
        self.transactionCode  = "null"
        self.cuKeyPublicValue = "null"
        self.lastAccessTime = "null"
        self.requirePasschange = "null"
        self.ecKeyPublicValue  = data.ecKeyPublicValue
        
        self.personEmail  = data.personEmail
        self.personCurrentAddress  = data.personCurrentAddress
        self.wardName = data.wardName
        self.districtName = data.districtName
        self.provinceName = data.provinceName
        self.countryName = data.countryName
    }
}
