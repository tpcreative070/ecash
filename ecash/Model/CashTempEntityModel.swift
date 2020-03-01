//
//  CashTempEntityModel.swift
//  ecash
//
//  Created by phong070 on 12/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class CashTempEntityModel : Codable {
    var id  : Int64?
    var senderAccountId : Int64?
    var content : String?
    var transactionSignature  : String?
    var receiveDate : String?
    var status : Bool?
    var fullName : String?
    
    init(id : Int64, senderAccountId : Int64,content : String, transactionSignature : String, receiveDate : String, status : Bool,fullName : String) {
        self.id = id
        self.senderAccountId = senderAccountId
        self.content = content
        self.transactionSignature = transactionSignature
        self.receiveDate = receiveDate
        self.status = status
        self.fullName = fullName
    }
    
    init(data : TransferDataModel) {
        if data.sender?.isNumeric ?? 0  {
            self.senderAccountId = Int64(data.sender ?? "0")
        }else{
            self.senderAccountId = 0
        }
        self.content = JSONSerializerHelper.toJson(data)
        self.transactionSignature = data.id
        self.receiveDate = data.time
        self.status = false
        self.id = Int64(data.refId ?? "0")
    }
    
    init(transactionSignature : String) {
        self.transactionSignature = transactionSignature
        self.receiveDate = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatSendEnc)
    }
}
