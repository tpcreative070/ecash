//
//  KeychainModel.swift
//  ecash
//
//  Created by phong070 on 9/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class KeychainDeviceStoreModel  : Codable{
    var privateKey : String?
    var publicKey : String?
   
    init(data : ELGamalModel) {
        self.privateKey = data.privateKey
        self.publicKey = data.publicKey
    }
    init() {
        
    }
}
