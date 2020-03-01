//
//  TransactionHistoryEntitiesModel.swift
//  ecash
//
//  Created by phong070 on 10/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class  TransactionHistoyEntityModel : Codable {
    var receiverName : String?
    var senderName : String?
    var receiverPhone : String?
    var senderPhone : String?
    var receiverId : String?
    var senderId : String?
    var transactionType : String?
    var transactionStatus : String?
    var transactionAmount : String?
    var transactionDate : String?
    var transactionDateTime : String?
    var transactionId : String?
    
    init(transactionId : String,receiverName : String,senderName : String,receiverPhone : String, senderPhone : String,transactionType : String,
         receiverId : String,
         senderId : String,
         transactionAmount : String,
         transactionStatus : String,
         transactionDate : String,transactionDateTime : String) {
        self.transactionId = transactionId
        self.transactionType = transactionType
        self.receiverId = receiverId
        self.senderId = senderId
        self.transactionAmount = transactionAmount
        self.transactionStatus = transactionStatus
        self.transactionDate = transactionDate
        self.transactionDateTime = transactionDateTime
        self.receiverName = receiverName
        self.senderName = senderName
        self.receiverPhone = receiverPhone
        self.senderPhone = senderPhone
        debugPrint("Status.....\(transactionStatus)")
        debugPrint("Type.....\(transactionType)")
        debugPrint("Receider Id.....\(receiverId)")
        debugPrint("Sender Id.....\(senderId)")
        debugPrint("Sender name:...\(senderName)")
        debugPrint("Receiver name:...\(receiverName)")
    }
    
}
