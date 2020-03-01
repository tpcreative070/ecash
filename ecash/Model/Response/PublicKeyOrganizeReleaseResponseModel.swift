//
//  PublicKeyOrganizeReleaseResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PublicKeyOrganizeReleaseResponseModel : BaseResponseModel {
    var responseData : PublicKeyOrganizeReleaseData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(PublicKeyOrganizeReleaseData.self, forKey: .responseData) ?? PublicKeyOrganizeReleaseData()
        try super.init(from: decoder)
    }
}

class PublicKeyOrganizeReleaseData : Decodable {
    var channelCode : String?
    var functionCode : String?
    var issuerCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId : Int?
    var issuerKpValue : String?
    
    private enum CodingKeys: String, CodingKey {
        case channelCode = "channelCode"
        case functionCode = "functionCode"
        case issuerCode = "issuerCode"
        case sessionId = "sessionId"
        case terminalId = "terminalId"
        case token = "token"
        case username = "username"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case channelId = "channelId"
        case issuerKpValue = "issuerKpValue"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        issuerCode = try container.decodeIfPresent(String.self, forKey: .issuerCode)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        issuerKpValue = try container.decodeIfPresent(String.self, forKey: .issuerKpValue)
    }
    
    init() {
        
    }
}
