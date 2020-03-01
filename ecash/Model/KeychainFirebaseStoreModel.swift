//
//  KeychainFireaseStoreModel.swift
//  ecash
//
//  Created by phong070 on 11/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class KeychainFirebaseStoreModel : Codable {
    var clientKp : String?
    var clientKs : String?
    init(data : KeyViewModel) {
        self.clientKp = data.clientKp
        self.clientKs = data.clientKs
    }
}
