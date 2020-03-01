//
//  TransactionsTimeoutEntityModel.swift
//  ecash
//
//  Created by phong070 on 11/4/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import Foundation

class TransactionsTimeoutEntityModel : Codable {
    var transactionSignature : String?
    var transactionTime : Int64?
    var status  : Int?
    var confirmedTime  : Int64?
    
    init(transactionSignature : String, transactionTime : Int64,status : Int,confirmedTime : Int64) {
        self.transactionSignature = transactionSignature
        self.transactionTime = transactionTime
        self.status = status
        self.confirmedTime = confirmedTime
    }
}
