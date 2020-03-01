//
//  SignInWithNoneWalletResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/12/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInWithNoneWalletValidatedOTPResponseModel  : BaseResponseModel{
    var responseData : SignInNoneWalletValidatedOTPData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(SignInNoneWalletValidatedOTPData.self, forKey: .responseData) ?? SignInNoneWalletValidatedOTPData()
        try super.init(from: decoder)
    }
}

class SignInNoneWalletValidatedOTPData :Decodable {
    var channelCode : String?
    var channelId : String?
    var customerId : String?
    var userId : String?
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
    var personMobilePhone : String?
    var idNumber : String?
    
    var personEmail : String?
    var personCurrentAddress : String?
    var wardName : String?
    var districtName : String?
    var provinceName : String?
    var countryName : String?
    
    private enum CodingKeys: String, CodingKey {
        case channelCode  = "channelCode"
        case channelId  = "channelId"
        case customerId  = "customerId"
        case ecKeyPublicValue = "ecKeyPublicValue"
        case functionCode = "functionCode"
        case keyPublicAlias = "keyPublicAlias"
        case sessionId  = "sessionId"
        case terminalId = "terminalId"
        case terminalInfo = "terminalInfo"
        case token = "token"
        case username = "username"
        case channelSignature = "channelSignature"
        case functionId = "functionId"
        case walletId = "walletId"
        case masterKey = "masterKey"
        case personFirstName  = "personFirstName"
        case personLastName = "personLastName"
        case personMiddleName = "personMiddleName"
        case personMobilePhone  = "personMobilePhone"
        case idNumber = "idNumber"
        case userId = "userId"
        
        case personEmail = "personEmail"
        case personCurrentAddress = "personCurrentAddress"
        case wardName = "wardName"
        case districtName = "districtName"
        case provinceName = "provinceName"
        case countryName = "countryName"
               
    }
    
    init() {
        
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .channelId)
            channelId = result?.description
        }
        catch {
           channelId = try container.decodeIfPresent(String.self, forKey: .channelId)
        }
        
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .functionId)
            functionId = result?.description
        }
        catch {
           functionId = try container.decodeIfPresent(String.self, forKey: .functionId)
        }
        
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .customerId)
            customerId = result?.description
        }
        catch {
             customerId = try container.decodeIfPresent(String.self, forKey: .customerId)
        }
        
        do {
            let result  = try container.decodeIfPresent(Int.self, forKey: .walletId)
            walletId = result?.description
        }
        catch {
            walletId = try container.decodeIfPresent(String.self, forKey: .walletId)
        }
        
        do {
            let result  = try container.decodeIfPresent(Int.self, forKey: .idNumber)
            idNumber = result?.description
        }
        catch {
            idNumber = try container.decodeIfPresent(String.self, forKey: .idNumber)
        }
        
        do {
            let result  = try container.decodeIfPresent(Int.self, forKey: .userId)
            userId = result?.description
        }
        catch {
            userId = try container.decodeIfPresent(String.self, forKey: .userId)
        }
        
        
        ecKeyPublicValue = try container.decodeIfPresent(String.self, forKey: .ecKeyPublicValue)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        keyPublicAlias = try container.decodeIfPresent(String.self, forKey: .keyPublicAlias)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        terminalInfo = try container.decodeIfPresent(String.self, forKey: .terminalInfo)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
      
        masterKey = try container.decodeIfPresent(String.self, forKey: .masterKey)
        personFirstName  = try container.decodeIfPresent(String.self, forKey: .personFirstName)
        personLastName  = try container.decodeIfPresent(String.self, forKey: .personLastName)
        personMiddleName = try container.decodeIfPresent(String.self, forKey: .personMiddleName)
        personMobilePhone = try container.decodeIfPresent(String.self, forKey: .personMobilePhone)
        
        personEmail = try container.decodeIfPresent(String.self, forKey: .personEmail)
        personCurrentAddress =  try container.decodeIfPresent(String.self, forKey: .personCurrentAddress)
        wardName =  try container.decodeIfPresent(String.self, forKey: .wardName)
        districtName = try container.decodeIfPresent(String.self, forKey: .districtName)
        provinceName = try container.decodeIfPresent(String.self, forKey: .provinceName)
        countryName = try container.decodeIfPresent(String.self, forKey: .countryName)
    }
}
