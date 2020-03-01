//
//  PublicKeyeCashReleaseResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PublicKeyeCashReleaseResponseModel : BaseResponseModel {
    var responseData : PublicKeyeCashReleaseData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(PublicKeyeCashReleaseData.self, forKey: .responseData) ?? PublicKeyeCashReleaseData()
        try super.init(from: decoder)
    }
}

class PublicKeyeCashReleaseData : Decodable {
    
    var channelCode : String?
    var decisionCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId  : Int?
    var decisionAcckp : String?
    var decisionTrekp : String?

    private enum CodingKeys: String, CodingKey {
        case channelCode = "channelCode"
        case decisionCode = "decisionCode"
        case functionCode = "functionCode"
        case sessionId = "sessionId"
        case terminalId = "terminalId"
        case token  = "token"
        case username = "username"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case channelId  = "channelId"
        case decisionAcckp = "decisionAcckp"
        case decisionTrekp = "decisionTrekp"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        decisionCode = try container.decodeIfPresent(String.self, forKey: .decisionCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        decisionAcckp = try container.decodeIfPresent(String.self, forKey: .decisionAcckp)
        decisionTrekp = try container.decodeIfPresent(String.self, forKey: .decisionTrekp)
    }
    
    init() {
        
    }
}
