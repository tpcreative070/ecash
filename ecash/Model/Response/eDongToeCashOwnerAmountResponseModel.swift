//
//  eDongToeCashOwnerAmountResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongToeCashOwnerAmountResponseModel : BaseResponseModel {
    var responseData : eDongToeCashOwnerAmountData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(eDongToeCashOwnerAmountData.self, forKey: .responseData) ?? eDongToeCashOwnerAmountData()
        try super.init(from: decoder)
    }
}

class eDongToeCashOwnerAmountData : Decodable {
    var amount : Int?
    var channelCode : String?
    var creditAccount : String?
    var debitAccount : String?
    var functionCode : String?
    var receiver : String?
    var sender  : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId : Int?
    var refId : Int?
    var auditNumber : Int?
    var transLockRefId : Int?
    var glAccRefId : String?
    var time : String?
    var type : String?
    var cashEnc : String?
    var id : String?
    
    
    private enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case channelCode = "channelCode"
        case creditAccount = "creditAccount"
        case debitAccount = "debitAccount"
        case functionCode = "functionCode"
        case receiver = "receiver"
        case sender = "sender"
        case sessionId = "sessionId"
        case terminalId = "terminalId"
        case token = "token"
        case username = "username"
        case channelSignature = "channelSignature"
        case customerId = "customerId"
        case functionId = "functionId"
        case channelId = "channelId"
        case refId = "refId"
        case auditNumber = "auditNumber"
        case transLockRefId = "transLockRefId"
        case glAccRefId = "glAccRefId"
        case time = "time"
        case type = "type"
        case cashEnc = "cashEnc"
        case id = "id"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        amount = try container.decodeIfPresent(Int.self, forKey: .amount)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        creditAccount = try container.decodeIfPresent(String.self, forKey: .creditAccount)
        debitAccount = try container.decodeIfPresent(String.self, forKey: .debitAccount)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        receiver = try container.decodeIfPresent(String.self, forKey: .receiver)
        sender = try container.decodeIfPresent(String.self, forKey: .sender)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        refId = try container.decodeIfPresent(Int.self, forKey: .refId)
        auditNumber = try container.decodeIfPresent(Int.self, forKey: .auditNumber)
        transLockRefId = try container.decodeIfPresent(Int.self, forKey: .transLockRefId)
        
        do {
            glAccRefId = try container.decodeIfPresent(String.self, forKey: .glAccRefId)
        }
        catch {
            let result  = try container.decodeIfPresent(Int.self, forKey: .glAccRefId)
            self.glAccRefId = result?.description
        }
        
        time = try container.decodeIfPresent(String.self, forKey: .time)
        cashEnc = try container.decodeIfPresent(String.self, forKey: .cashEnc)
        id = try container.decodeIfPresent(String.self, forKey: .id)
    }
    
    init() {
        
    }
    
    
    
}
