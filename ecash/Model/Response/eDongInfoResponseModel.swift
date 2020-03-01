//
//  eDongInfoResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongInfoResponseModel : BaseResponseModel {
    var responseData : eDongInfoData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(eDongInfoData.self, forKey: .responseData) ?? eDongInfoData()
        try super.init(from: decoder)
    }
    
}


class eDongInfoData : Decodable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId : String?
    var terminalInfo : String?
    var token : String?
    var username : String?
    var waletId : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : String?
    var channelId : Int?
    var totalPages : Int?
    var listAcc : [AccountInfoData]?
    init() {
        
    }

    private enum CodingKeys: String, CodingKey {
        case auditNumber   = "auditNumber"
        case channelCode = "channelCode"
        case functionCode = "functionCode"
        case sessionId  = "sessionId"
        case terminalId  = "terminalId"
        case terminalInfo  = "terminalInfo"
        case token = "token"
        case username = "username"
        case waletId  = "waletId"
        case channelSignature  = "channelSignature"
        case customerId = "customerId"
        case functionId  = "functionId"
        case channelId  = "channelId"
        case totalPages = "totalPages"
        case listAcc  = "listAcc"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        auditNumber = try container.decodeIfPresent(String.self, forKey: .auditNumber)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        terminalId = try container.decodeIfPresent(String.self, forKey: .terminalId)
        terminalInfo = try container.decodeIfPresent(String.self, forKey: .terminalInfo)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        waletId = try container.decodeIfPresent(String.self, forKey: .waletId)
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .functionId)
            functionId = result?.description
        }
        catch {
            let result = try container.decodeIfPresent(String.self, forKey: .functionId)
            functionId = result
        }
        
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .channelId)
            channelId = result
        }
        catch {
            let result = try container.decodeIfPresent(String.self, forKey: .channelId)
            channelId = Int(result ?? "0")
        }
        
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        listAcc = try container.decodeIfPresent([AccountInfoData].self, forKey: .listAcc)
    }
}

class AccountInfoData : Decodable {
    var accountType : Int?
    var accLock: Double?
    var accountStatus : String?
    var accountIdt : String?
    var accBalance : Double?
    var usableBalance : Double?
    var minBalance : Double?
    init() {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case accountType   = "accountType"
        case accLock = "accLock"
        case accountStatus = "accountStatus"
        case accountIdt  = "accountIdt"
        case accBalance  = "accBalance"
        case usableBalance = "usableBalance"
        case minBalance  = "minBalance"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountType = try container.decodeIfPresent(Int.self, forKey: .accountType)
        accLock = try container.decodeIfPresent(Double.self, forKey: .accLock)
        accountStatus = try container.decodeIfPresent(String.self, forKey: .accountStatus)
        do {
            accountIdt = try container.decodeIfPresent(String.self, forKey: .accountIdt)
        }
        catch {
            let result = try container.decodeIfPresent(Int.self, forKey: .accountIdt)
            accountIdt = result?.description
        }
        accBalance = try container.decodeIfPresent(Double.self, forKey: .accBalance)
        usableBalance = try container.decodeIfPresent(Double.self, forKey: .usableBalance)
        minBalance = try container.decodeIfPresent(Double.self, forKey: .minBalance)
    }
}
