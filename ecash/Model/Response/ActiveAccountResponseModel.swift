//
//  ActiveAccountResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ActiveAccountResponseModel : BaseResponseModel {
    var responseData : ActiveAccountModel
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(ActiveAccountModel.self, forKey: .responseData) ?? ActiveAccountModel()
        try super.init(from: decoder)
    }
}

class ActiveAccountModel : Decodable {

    var accountIdt : String?
    var channelCode : String?
    var customerId : String?
    var functionCode : String?
    var idNumber : String?
    var userId : String?
    var channelSignature : String?
    var functionId : Int?
    var channelId : String?
    var status : String?
    var id : String?
    var auditNumber : String?
    var approveStatus : String?
  
    init() {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case accountIdt   = "accountIdt"
        case channelCode = "channelCode"
        case customerId    = "customerId"
        case functionCode  = "functionCode"
        case idNumber    = "idNumber"
        case userId    = "userId"
        case channelSignature    = "channelSignature"
        case functionId    = "functionId"
        case channelId    = "channelId"
        case status    = "status"
        case id    = "id"
        case auditNumber    = "auditNumber"
        case approveStatus    = "approveStatus"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accountIdt  = try container.decodeIfPresent(String.self, forKey: .accountIdt)
        channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
        customerId = try container.decodeIfPresent(String.self, forKey: .customerId)
        functionCode = try container.decodeIfPresent(String.self, forKey: .functionCode)
        idNumber = try container.decodeIfPresent(String.self, forKey: .idNumber)
       
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .userId)
            userId = result?.description
        }
        catch {
            userId = try container.decodeIfPresent(String.self, forKey: .userId)
        }
        
        do {
            let result = try container.decodeIfPresent(Int.self, forKey: .id)
            id = result?.description
        }
        catch {
            id = try container.decodeIfPresent(String.self, forKey: .id)
        }
        
        channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        functionId = try container.decodeIfPresent(Int.self, forKey: .functionId)
        channelId = try container.decodeIfPresent(String.self, forKey: .channelId)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        auditNumber  = try container.decodeIfPresent(String.self, forKey: .auditNumber)
        approveStatus  = try container.decodeIfPresent(String.self, forKey: .approveStatus)
    }
}
