//
//  SignUpResponseModel.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignUpResponseModel : BaseResponseModel {
    var responseData : SignUpInforModel
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(SignUpInforModel.self, forKey: .responseData) ?? SignUpInforModel()
        try super.init(from: decoder)
    }
}

class SignUpInforModel : Decodable {
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
   
    var transactionCode : String?
    var cuKeyPublicValue : String?
    var lastAccessTime : String?
    var requirePasschange : String?
    var ecKeyPublicValue  : String?
    
    var otptimeCreated : String?
    var otpid : String?
    var otpvalue : String?
    var otptimeExpired : String?
    var otptimeRenew : String?
    var otpnumberOfFailure : String?
    
    var personEmail : String?
    var personCurrentAddress : String?
    var wardName : String?
    var districtName : String?
    var provinceName : String?
    var countryName : String?
    
    init() {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case channelCode   = "channelCode"
        case functionCode = "functionCode"
        case idNumber    = "idNumber"
        case keyPublicAlias  = "keyPublicAlias"
        case keyPublicValue    = "keyPublicValue"
        case password    = "password"
        case personFirstName    = "personFirstName"
        case personLastName    = "personLastName"
        case personMiddleName    = "personMiddleName"
        case personMobilePhone    = "personMobilePhone"
        case terminalId    = "terminalId"
        case terminalInfo    = "terminalInfo"
        case username    = "username"
        case channelSignature    = "channelSignature"
        case functionId    = "functionId"
        case customerId    = "customerId"
        case nickname    = "nickname"
        case groupId    = "groupId"
        case userId    = "userId"
        case dateCreated    = "dateCreated"
        case walletId    = "walletId"
        case masterKey    = "masterKey"
        case auditNumber  = "auditNumber"
        case accountIdt  = "accountIdt"
        case otptransactionCode  = "otptransactionCode"
        case otptimeCreated  = "otptimeCreated"
        case otpid  = "otpid"
        case otpvalue = "otpvalue"
        case otptimeExpired = "otptimeExpired"
        case otptimeRenew = "otptimeRenew"
        case otpnumberOfFailure  = "otpnumberOfFailure"
        
        case transactionCode = "transactionCode"
        case lastAccessTime = "lastAccessTime"
        case cuKeyPublicValue = "cuKeyPublicValue"
        case requirePasschange = "requirePasschange"
        case ecKeyPublicValue  = "ecKeyPublicValue"
        
        case personEmail = "personEmail"
        case personCurrentAddress = "personCurrentAddress"
        case wardName = "wardName"
        case districtName = "districtName"
        case provinceName = "provinceName"
        case countryName = "countryName"
        
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        idNumber = try container.decodeIfPresent(String.self, forKey: .idNumber)
        keyPublicAlias = try container.decodeIfPresent(String.self, forKey: .keyPublicAlias)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        personFirstName = try container.decodeIfPresent(String.self, forKey: .personFirstName)
        personLastName = try container.decodeIfPresent(String.self, forKey: .personLastName)
      
        personMiddleName = try container.decodeIfPresent(String.self, forKey: .personMiddleName)
        personMobilePhone = try container.decodeIfPresent(String.self, forKey: .personMobilePhone)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        terminalInfo = try container.decodeIfPresent(String.self, forKey: .terminalInfo)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        
        do{
            let functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
            self.functionId = functionId?.description
        }catch {
            functionId = try container.decodeIfPresent(String.self, forKey: .functionId)
        }
        
        do{
            let customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
            self.customerId = customerId?.description
        }catch {
            customerId = try container.decodeIfPresent(String.self, forKey: .customerId)
        }
        
        nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        
        do{
            let groupId = try container.decodeIfPresent(Int.self, forKey: .groupId)
            self.groupId = groupId?.description
        }catch {
            groupId = try container.decodeIfPresent(String.self, forKey: .groupId)
        }
        
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
        dateCreated = try container.decodeIfPresent(String.self, forKey: .dateCreated)
        
        do{
           let walletId = try container.decodeIfPresent(Int.self, forKey: .walletId)
           self.walletId = walletId?.description
        }catch {
           walletId = try container.decodeIfPresent(String.self, forKey: .walletId)
        }
        
       
        masterKey = try container.decodeIfPresent(String.self, forKey: .masterKey)
        auditNumber  = try container.decodeIfPresent(String.self, forKey: .auditNumber)
        
        do{
            let accountIdt  = try container.decodeIfPresent(Int.self, forKey: .accountIdt)
            self.accountIdt = accountIdt?.description
        }catch {
             accountIdt  = try container.decodeIfPresent(String.self, forKey: .accountIdt)
        }
        
        otptimeCreated  = try container.decodeIfPresent(String.self, forKey: .otptimeCreated)
        otpid  = try container.decodeIfPresent(String.self, forKey: .otpid)
        otpvalue = try container.decodeIfPresent(String.self, forKey: .otpvalue)
        otptimeExpired = try container.decodeIfPresent(String.self, forKey: .otptimeExpired)
        otptimeRenew = try container.decodeIfPresent(String.self, forKey: .otptimeRenew)
        otpnumberOfFailure  = try container.decodeIfPresent(String.self, forKey: .otpnumberOfFailure)
        transactionCode = try container.decodeIfPresent(String.self, forKey: .transactionCode)
        cuKeyPublicValue = try container.decodeIfPresent(String.self, forKey: .cuKeyPublicValue)
        lastAccessTime = try container.decodeIfPresent(String.self, forKey: .lastAccessTime)
        requirePasschange = try container.decodeIfPresent(String.self, forKey: .requirePasschange)
        ecKeyPublicValue  = try container.decodeIfPresent(String.self, forKey: .ecKeyPublicValue)
        
        personEmail = try container.decodeIfPresent(String.self, forKey: .personEmail)
        personCurrentAddress =  try container.decodeIfPresent(String.self, forKey: .personCurrentAddress)
        wardName =  try container.decodeIfPresent(String.self, forKey: .wardName)
        districtName = try container.decodeIfPresent(String.self, forKey: .districtName)
        provinceName = try container.decodeIfPresent(String.self, forKey: .provinceName)
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
    }
}


