//
//  ReceiverResponseModel.swift
//  ecash
//
//  Created by phong070 on 8/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ReceiverReponseModel: Decodable {
    let  sender : String?
    let  receiver : String?
    let  time : String?
    let  type : String?
    let  content : String?
    let  id : String?
    let  cashEnc : String?

    private enum CodingKeys: String, CodingKey {
        case sender = "sender"
        case receiver = "receiver"
        case time = "time"
        case type = "type"
        case content = "content"
        case id = "id"
        case cashEnc = "cashEnc"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sender = try container.decodeIfPresent(String.self, forKey: .sender)
        receiver = try container.decodeIfPresent(String.self, forKey: .receiver)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        cashEnc = try container.decodeIfPresent(String.self, forKey: .cashEnc)
    }
}
