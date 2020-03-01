//
//  ReSendOTPResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ReSendOTPResponseModel : BaseResponseModel{
    var responseData : ReSendOTPData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(ReSendOTPData.self, forKey: .responseData) ?? ReSendOTPData()
        try super.init(from: decoder)
    }
}

class ReSendOTPData  :  Decodable{
    var channelCode : String?
    var functionCode : String?
    var token : String?
    var username : String?
    var walletId : Int?
    var channelSignature : String?
    var functionId : Int?
    var channelId : Int?
    var iconMedium : String?
    var nickname : String?
    var groupId : Int?
    var userId : Int?
    var customerId : Int?
    var iconLarge : String?
    var iconSmall : String?
    var otptimeCreated : String?
    var OTPId : Int?
    var otpvalue : String?
    var otptimeExpired : String?
    var transactionCode : Int?
    var otpStatus : String?
    var userID : Int?
    var otptimeRenew : String?
    var messageId : Int?
    var msgSentDate : String?
    
    
    private enum CodingKeys: String, CodingKey {
         case channelCode  = "channelCode"
         case functionCode = "functionCode"
         case token  = "token"
         case username  = "username"
         case walletId  = "walletId"
         case channelSignature  = "channelSignature"
         case functionId  = "functionId"
         case channelId  = "channelId"
         case iconMedium  = "iconMedium"
         case nickname  = "nickname"
         case groupId  = "groupId"
         case userId  = "userId"
         case customerId  = "customerId"
         case iconLarge  = "iconLarge"
         case iconSmall  = "iconSmall"
         case otptimeCreated  = "otptimeCreated"
         case OTPId  = "OTPId"
         case otpvalue  = "otpvalue"
         case otptimeExpired  = "otptimeExpired"
         case transactionCode  = "transactionCode"
         case otpStatus  = "otpStatus"
         case userID  = "userID"
         case otptimeRenew  = "otptimeRenew"
         case messageId  = "messageId"
         case msgSentDate  = "msgSentDate"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        walletId = try container.decodeIfPresent(Int.self, forKey: .walletId)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        iconMedium = try container.decodeIfPresent(String.self, forKey: .iconMedium)
        nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        groupId = try container.decodeIfPresent(Int.self, forKey: .groupId)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        iconLarge = try container.decodeIfPresent(String.self, forKey: .iconLarge)
        iconSmall = try container.decodeIfPresent(String.self, forKey: .iconSmall)
        otptimeCreated = try container.decodeIfPresent(String.self, forKey: .otptimeCreated)
        OTPId = try container.decodeIfPresent(Int.self, forKey: .OTPId)
        otpvalue = try container.decodeIfPresent(String.self, forKey: .otpvalue)
        otptimeExpired = try container.decodeIfPresent(String.self, forKey: .otptimeExpired)
        transactionCode = try container.decodeIfPresent(Int.self, forKey: .transactionCode)
        userID = try container.decodeIfPresent(Int.self, forKey: .userID)
        otptimeRenew = try container.decodeIfPresent(String.self, forKey: .otptimeRenew)
        messageId = try container.decodeIfPresent(Int.self, forKey: .messageId)
        msgSentDate = try container.decodeIfPresent(String.self, forKey: .msgSentDate)
    }
    
    init() {
        
    }
    
    
}

