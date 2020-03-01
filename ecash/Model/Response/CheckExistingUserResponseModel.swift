//
//  CheckExistingUserResponseModel.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class CheckExistingUserResponseModel : BaseResponseModel {
    var responseData : CheckExistingUserData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(CheckExistingUserData.self, forKey: .responseData) ?? CheckExistingUserData()
        try super.init(from: decoder)
    }
}

class CheckExistingUserData : Codable {
    var channelCode : String?
    var functionCode : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var idNumber : String?
    var personMobilePhone : String?
    
    private enum CodingKeys: String, CodingKey {
        case channelCode  = "channelCode"
        case functionCode = "functionCode"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case idNumber  = "idNumber"
        case personMobilePhone = "personMobilePhone"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        idNumber = try container.decodeIfPresent(String.self, forKey: .idNumber)
        personMobilePhone = try container.decodeIfPresent(String.self, forKey: .personMobilePhone)
    }
    
    init() {
        
    }
}
