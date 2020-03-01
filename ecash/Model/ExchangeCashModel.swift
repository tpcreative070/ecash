//
//  ExchangeCashModel.swift
//  ecash
//
//  Created by phong070 on 10/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExchangeCashModel : Codable {
    var id : Int?
    var countryCode : String?
    var issuerCode : String?
    var decisionNo : String?
    var serial   : Int64?
    var value  : Int64?
    var actived  : String?
    var expired  : String?
    var accountSignature  : String?
    var cycle  : Int?
    var treasureSignature  : String?
    // Input/output
    var type  : Bool?
    var transactionSignature  : String?
    var previousHash : String?
    var verify : Bool?
    var data : String?
    
    init(data : CashLogsEntityModel) {
        self.id = data.id
        self.countryCode = data.countryCode
        self.issuerCode = data.issuerCode
        self.decisionNo = data.decisionNo
        self.serial = data.serial
        self.value = data.value
        self.actived = data.actived
        self.expired = data.expired
        self.accountSignature = data.accountSignature
        self.cycle = data.cycle
        self.treasureSignature = data.treasureSignature
        self.type = data.type
        self.transactionSignature = data.transactionSignature
        self.previousHash = data.previousHash
        self.verify = data.verify
        self.data = data.data
    }
    
    init() {
        
    }
}
