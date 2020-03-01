//
//  TransactionQREntityModel.swift
//  ecash
//
//  Created by phong070 on 9/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransactionQREntityModel : Codable{
    var transactionSignature : String?
    var sequence : Int?
    var total : Int?
    var value : String?
    
    init(transactionSignature : String,sequence : Int,total : Int, value : String) {
        self.transactionSignature = transactionSignature
        self.sequence = sequence
        self.total = total
        self.value = value
    }
    
    init(data : QRCodeModel,transactionSignature : String) {
        self.sequence = data.cycle
        self.total = data.total
        self.value = JSONSerializerHelper.toJson(data)
        self.transactionSignature = transactionSignature
    }
    init() {
        
    }
}
