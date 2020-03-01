//
//  CashInvalidResponseModel.swift
//  ecash
//
//  Created by phong070 on 8/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation

struct CashInvalidEntityModel : Codable {
    let countryCode  : String?
    let issuerCode : String?
    let decisionNo : String?
    let serial : Int?
    let value : Int?
    let actived : String?
    let expired : String?
    let accountSignature : String?
    let cycle : Int?
    let treasureSignature : String?
    let transactionSignature : String?
    let previousHash : String?

    init(countryCode : String, issuerCode : String,decisionNo : String, serial : Int, value : Int,actived : String, expired : String,accountSignature : String, cycle : Int, treasureSignature : String,transactionSignature : String,previousHash : String) {
        self.countryCode = countryCode
        self.issuerCode = issuerCode
        self.decisionNo = decisionNo
        
        self.serial = serial
        self.value = value
        self.actived = actived
        self.expired = expired
        self.accountSignature = accountSignature
        self.cycle = cycle
        self.treasureSignature = treasureSignature
        self.transactionSignature = transactionSignature
        self.previousHash = previousHash
    }
}
