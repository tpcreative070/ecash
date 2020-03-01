//
//  eCashToeDongResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/10/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eCashToeDongResponseModel : BaseResponseModel {
    var responseData : eCashToeDongData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(eCashToeDongData.self, forKey: .responseData) ?? eCashToeDongData()
        try super.init(from: decoder)
    }
    
}

class eCashToeDongData : Decodable {
    
    var amount : Int?
    var cashEnc : String?
    var channelCode : String?
    var content : String?
    var creditAccount : String?
    var debitAccount : String?
    var functionCode : String?
    var id : String?
    var receiver : Int?
    var sender : String?
    var sessionId : String?
    var terminalId : String?
    var time : String?
    var token : String?
    var type : String?
    var username : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId : Int?
    var auditNumber : String?
    var transLockRefId : Int?
    var glAccRefId : String?
    
    init() {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case cashEnc = "cashEnc"
        case channelCode = "channelCode"
        case content = "content"
        case creditAccount = "creditAccount"
        case debitAccount = "debitAccount"
        case functionCode = "functionCode"
        case id = "id"
        case receiver = "receiver"
        case sender = "sender"
        case sessionId = "sessionId"
        case terminalId = "terminalId"
        case time = "time"
        case token = "token"
        case type = "type"
        case username = "username"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case channelId = "channelId"
        case auditNumber = "auditNumber"
        case transLockRefId = "transLockRefId"
        case glAccRefId = "glAccRefId"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
         amount =  try container.decodeIfPresent(Int.self, forKey: .amount)
         cashEnc =  try container.decodeIfPresent(String.self, forKey: .cashEnc)
         channelCode =  try container.decodeIfPresent(String.self, forKey: .channelCode)
         content =  try container.decodeIfPresent(String.self, forKey: .content)
         creditAccount =  try container.decodeIfPresent(String.self, forKey: .creditAccount)
         debitAccount =  try container.decodeIfPresent(String.self, forKey: .debitAccount)
         functionCode =  try container.decodeIfPresent(String.self, forKey: .functionCode)
         id =  try container.decodeIfPresent(String.self, forKey: .id)
         receiver =  try container.decodeIfPresent(Int.self, forKey: .receiver)
         sender =  try container.decodeIfPresent(String.self, forKey: .sender)
         sessionId =  try container.decodeIfPresent(String.self, forKey: .sessionId)
         terminalId =  try container.decodeIfPresent(String.self, forKey: .terminalId)
         time =  try container.decodeIfPresent(String.self, forKey: .time)
         token =  try container.decodeIfPresent(String.self, forKey: .token)
         type =  try container.decodeIfPresent(String.self, forKey: .type)
         username =  try container.decodeIfPresent(String.self, forKey: .username)
         channelSignature =  try container.decodeIfPresent(String.self, forKey: .channelSignature)
         customerId =  try container.decodeIfPresent(Int.self, forKey: .customerId)
         functionId =  try container.decodeIfPresent(Int.self, forKey: .functionId)
         channelId =  try container.decodeIfPresent(Int.self, forKey: .channelId)
         auditNumber =  try container.decodeIfPresent(String.self, forKey: .auditNumber)
         do {
            transLockRefId =  try container.decodeIfPresent(Int.self, forKey: .transLockRefId)
         }
         catch {
            let result  = try container.decodeIfPresent(String.self, forKey: .transLockRefId)
            transLockRefId = Int(result ?? "0")
         }
       
         do {
             glAccRefId = try container.decodeIfPresent(String.self, forKey: .glAccRefId)
         }
         catch {
             let result  = try container.decodeIfPresent(Int.self, forKey: .glAccRefId)
             self.glAccRefId = result?.description
         }
    }
}
