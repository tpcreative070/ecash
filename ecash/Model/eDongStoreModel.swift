//
//  eDongStoreModel.swift
//  ecash
//
//  Created by phong070 on 9/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongStoreModel : Codable {
    
    var accountType : Int?
    var accLock: Int?
    var accountStatus : String?
    var eDongId : String?
    var accBalance : Int?
    
    init(data : AccountInfoDataVM) {
        self.accountType = data.accountType
        self.accLock = data.accLock
        self.accountStatus = data.accountStatus
        self.eDongId = data.accountIdt
        self.accBalance = data.accBalance
    }
    
}
