//
//  ChangePasswordResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ChangePasswordResponseModel  : BaseResponseModel{
    var responseData : ChangePasswordData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(ChangePasswordData.self, forKey: .responseData) ?? ChangePasswordData()
        try super.init(from: decoder)
    }
}

class ChangePasswordData  :  Decodable{
    var channelCode : String?
    var functionCode : String?
    var password : String?
    var token : String?
    var userId : Int?
    var username :String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId : Int?
    var requirePassChange : String?
 
    
    private enum CodingKeys: String, CodingKey {
        case channelCode = "channelCode"
        case functionCode = "functionCode"
        case password = "password"
        case token = "token"
        case userId = "userId"
        case username = "username"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case channelId = "channelId"
        case requirePassChange = "requirePassChange"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        requirePassChange = try container.decodeIfPresent(String.self, forKey: .requirePassChange)
    }
    
    init() {
        
    }
    
    
}
