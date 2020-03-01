//
//  ECECash.swift
//  ecash
//
//  Created by ECAPP on 1/22/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class ToPayQRModel {
    
    var sender : String?
    var time : String?
    var type : String?
    var content : String?
    var senderPublicKey : String?
    var totalAmount : String?
    var channelSignature : String?
    
    init(sender : String?, time : String?, type : String?, content : String?, senderPublicKey : String?, totalAmount : String?, channelSignature : String?) {
        self.sender = sender
        self.time = time
        self.type = type
        self.content = content
        self.senderPublicKey = senderPublicKey
        self.totalAmount = totalAmount
        self.channelSignature = channelSignature
    }
    
    func toString() -> String {
        return
            """
        {"sender":"\(self.sender ??  "")","time":"\(self.time ??  "")","type":"\(self.type ??  "")","content":"\(self.content ??  "")","senderPublicKey":"\(self.senderPublicKey ??  "")","totalAmount":"\(self.totalAmount ??  "")","channelSignature":"\(self.channelSignature ??  "")"}
        """
    }
}
