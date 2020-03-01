//
//  SendOTPResponse.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SendOTPResponseModel : BaseResponseModel {
    
    var responseData : SendOTPData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(SendOTPData.self, forKey: .responseData) ?? SendOTPData()
        try super.init(from: decoder)
    }
}

class SendOTPData : Decodable {
    var transactionCode : String?
    var userId : String?
    var channelId : String?
   
    private enum CodingKeys: String, CodingKey {
        case transactionCode = "transactionCode"
        case userId = "userId"
        case channelId = "channelId"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.transactionCode = try container.decodeIfPresent(String.self, forKey: .transactionCode)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.channelId = try container.decodeIfPresent(String.self, forKey: .channelId)
    }
    
    init() {
        
    }
}
