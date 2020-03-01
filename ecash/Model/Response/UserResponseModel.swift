//
//  UserResponseModel.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
class UserResponseModel : BaseResponseModel{
    let token : String?
    private enum CodingKeys: String, CodingKey {
        case  token = "token"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        try super.init(from: decoder)
    }
}
