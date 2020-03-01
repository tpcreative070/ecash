//
//  StoreKeyModel.swift
//  ecash
//
//  Created by phong070 on 9/7/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class StoreKeyResponseModel : Codable {
    
}

struct StoreKeyEntityModel : Codable {
    var username : String?
    var privateKey : String?
    var publicKey : String?
}
