//
//  ExchangeCashResponseModel.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExchangeCashResponseModel : BaseResponseModel {
    var responseData : ExchangeCashData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(ExchangeCashData.self, forKey: .responseData) ?? ExchangeCashData()
        try super.init(from: decoder)
    }
}

class ExchangeCashData : Codable {
    var receiver : Int?
    var cashEnc : String?
    var sender : String?
    var time : String?
    var id : String?
    var type : String?
    var content : String?
    
    private enum CodingKeys: String, CodingKey {
        case receiver = "receiver"
        case cashEnc = "cashEnc"
        case sender = "sender"
        case time = "time"
        case id = "id"
        case type  = "type"
        case content = "content"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        receiver = try container.decodeIfPresent(Int.self, forKey: .receiver)
        cashEnc = try container.decodeIfPresent(String.self, forKey: .cashEnc)
        sender = try container.decodeIfPresent(String.self, forKey: .sender)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        content = try container.decodeIfPresent(String.self, forKey : .content)
    }
    
    init() {
        
    }
}
