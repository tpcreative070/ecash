//
//  SideMenuModel.swift
//  ecash
//
//  Created by Tran Khuong on 8/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SideMenuModel : Decodable {
    var idMenu : Int?
    var iconUrl: String?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case iconUrl = "iconUrl"
        case name = "name"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMenu = try container.decodeIfPresent(Int.self, forKey: .id)
        iconUrl = try container.decodeIfPresent(String.self, forKey: .iconUrl)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    init() {}
}
