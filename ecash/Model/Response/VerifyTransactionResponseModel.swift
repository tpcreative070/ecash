//
//  VerifyTransactionResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class VerifyTransactionResponseModel : BaseResponseModel {
    var responseData : VerifyTransactionData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(VerifyTransactionData.self, forKey: .responseData) ?? VerifyTransactionData()
        try super.init(from: decoder)
    }
}

class VerifyTransactionData : Codable {
    var channelCode : String?
    var functionCode : String?
    var lastAccessTime : String?
    var masterKey : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var walletId : Int?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId : Int?
    var phone : String?
    
    private enum CodingKeys: String, CodingKey {
        case channelCode  = "channelCode"
        case functionCode = "functionCode"
        case lastAccessTime = "lastAccessTime"
        case masterKey = "masterKey"
        case sessionId = "sessionId"
        case terminalId = "terminalId"
        case token = "token"
        case username = "username"
        case walletId = "walletId"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case channelId = "channelId"
        case phone = "phone"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        lastAccessTime = try container.decodeIfPresent(String.self, forKey: .lastAccessTime)
        masterKey = try container.decodeIfPresent(String.self, forKey: .masterKey)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        walletId = try container.decodeIfPresent(Int.self, forKey: .walletId)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
    }
    
    init() {
        
    }
    
    
    
}
