//
//  SocketRequestPaytoModel.swift
//  ecash
//
//  Created by ECAPP on 1/18/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation

struct SocketRequestPaytoModel : Codable {
    var sender: String
    var receiver: String
    var time: String
    var type: String
    var content: String
    var senderPublicKey: String
    var totalAmount: String
    var channelSignature: String
    var fullName: String? = ""
    var refId: String?
    
    init(sender: String, receiver: String, time: String, type: String, content: String, senderPublicKey: String, totalAmount: String, channelSignature: String, fullName: String? = "", refId: String? = nil) {
        self.sender = sender
        self.receiver = receiver
        self.time = time
        self.type = type
        self.content = content
        self.senderPublicKey = senderPublicKey
        self.totalAmount = totalAmount
        self.channelSignature = channelSignature
        self.fullName = fullName
        self.refId = refId
    }
    
    func getHashable() -> [String : Any]{
        return [
            "sender" : self.sender,
            "receiver" : self.receiver,
            "time" : self.time,
            "type" : self.type,
            "content" : self.content,
            "senderPublicKey" : self.senderPublicKey,
            "totalAmount" : self.totalAmount,
            "channelSignature" : self.channelSignature,
            "fullName" : self.fullName ?? ""
        ]
    }
}
