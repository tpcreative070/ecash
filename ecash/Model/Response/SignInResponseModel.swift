//
//  SignInResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInResponseModel : BaseResponseModel {
    var responseData : SignInInfoModel
 
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(SignInInfoModel.self, forKey: .responseData) ?? SignInInfoModel()
        try super.init(from: decoder)
    }
}

class SignInInfoModel :Decodable {
    var channelCode : String?
    var functionCode : String?
    var terminalId : String?
    var token : String?
    var customerId : Int?
    var transactionId : String?
    var username : String?
    var userId : String?
    var uuid : String?
    var channelSignature : String?
    var functionId : String?
    var channelId : String?
    var sessionId : String?
    var result : Bool?
    var medium : String?
    var large : String?
    var small : String?
    
    var ChannelFunction : Dictionary<String,ChannelFunction>?
    
    private enum CodingKeys: String, CodingKey {
        case channelCode   = "channelCode"
        case functionCode   = "functionCode"
        case terminalId   = "terminalId"
        case token   = "token"
        case transactionId   = "transactionId"
        case username   = "username"
        case uuid   = "uuid"
        case channelSignature   = "channelSignature"
        case functionId   = "functionId"
        case channelId   = "channelId"
        case result   = "result"
        case customerId = "customerId"
        case sessionId = "sessionId"
        case ChannelFunction = "ChannelFunction"
        case userId = "userId"
        case medium  = "medium"
        case large = "large"
        case small = "small"
    }
    
    init() {
        
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        transactionId = try container.decodeIfPresent(String.self, forKey: .transactionId)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
        uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        functionId = try container.decodeIfPresent(String.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(String.self, forKey: .channelId)
        result = try container.decodeIfPresent(Bool.self, forKey: .result)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        ChannelFunction = try container.decodeIfPresent(Dictionary<String,ChannelFunction>.self, forKey: .ChannelFunction)
        small = try container.decodeIfPresent(String.self, forKey: .small)
        medium = try container.decodeIfPresent(String.self, forKey: .medium)
        large = try container.decodeIfPresent(String.self, forKey: .large)
    }
}

class ChannelFunction : Decodable {
    var functionId : Int?
    var functionCode : String?
    var functionName : String?
    var functionPath : String?
    var functionVisible : String?
    var functionAllias : String?
    var functionUri : String?
    private enum CodingKeys: String, CodingKey {
        case functionId   = "functionId"
        case functionCode   = "functionCode"
        case functionName   = "functionName"
        case functionPath   = "functionPath"
        case functionVisible   = "functionVisible"
        case functionAllias   = "functionAllias"
        case functionUri   = "functionUri"
    }
    
    init() {
        
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        functionName = try container.decodeIfPresent(String.self, forKey: .functionName)
        functionPath = try container.decodeIfPresent(String.self, forKey: .functionPath)
        functionVisible = try container.decodeIfPresent(String.self, forKey: .functionVisible)
        functionAllias = try container.decodeIfPresent(String.self, forKey: .functionAllias)
        functionUri = try container.decodeIfPresent(String.self, forKey: .functionUri)
    }
    
}
