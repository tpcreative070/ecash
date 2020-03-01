//
//  IssuersDiaryEntityModel.swift
//  ecash
//
//  Created by phong070 on 10/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class IssuersDiaryEntityModel : Codable {
    var issuerCode  : String?
    var publicKeyAlias : String?
    var publicKeyValue : String?
    var systemDate : Int64?
    
    init(issuerCode  : String,
         publicKeyAlias : String,
         publicKeyValue : String,
         systemDate : Int64) {
        self.issuerCode = issuerCode
        self.publicKeyAlias = publicKeyAlias
        self.publicKeyValue = publicKeyValue
        self.systemDate = systemDate
    }
}
