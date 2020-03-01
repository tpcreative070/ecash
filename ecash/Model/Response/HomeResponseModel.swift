//
//  HomeResponseModel.swift
//  ecash
//
//  Created by phong070 on 8/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class HomeReponseModel: BaseResponseModel {
    let total : Int?
    let data : [UserInfoResponseModel]?
    private enum CodingKeys: String, CodingKey {
        case  total = "total"
        case data = "data"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = try container.decodeIfPresent(Int.self, forKey: .total)
        data = try container.decodeIfPresent([UserInfoResponseModel].self, forKey: .data)
        try super.init(from: decoder)
    }
}

class UserInfoResponseModel : Decodable {
    let id : Int?
    let email : String?
    let first_name : String?
    let last_name : String?
    let avatar : String?
    
    private enum CodingKeys: String, CodingKey {
        case  id = "id"
        case  email = "email"
        case  first_name = "first_name"
        case  last_name = "last_name"
        case  avatar = "avatar"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        first_name = try container.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try container.decodeIfPresent(String.self, forKey: .last_name)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
    }
}
