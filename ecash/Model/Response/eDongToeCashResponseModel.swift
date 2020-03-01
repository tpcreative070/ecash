//
//  eDongToeCashResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/10/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongToeCashResponseModel : BaseResponseModel {
    
    var responseData : eDongToeCashData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(eDongToeCashData.self, forKey: .responseData) ?? eDongToeCashData()
        try super.init(from: decoder)
    }
    
}

class eDongToeCashData : Decodable {
    
    var cashEnc : String?
    var id : String?
    var sender : String?
    var receiver : Int?
    var time : String?
    var type : String?
    var content : String?
    var refId : Int?
    
    init() {
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case id  = "id"
        case cashEnc = "cashEnc"
        case sender  = "sender"
        case receiver  = "receiver"
        case time = "time"
        case type = "type"
        case content = "content"
        case refId = "refId"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id =  try container.decodeIfPresent(String.self, forKey: .id)
        cashEnc = try container.decodeIfPresent(String.self, forKey: .cashEnc)
        sender = try container.decodeIfPresent(String.self, forKey: .sender)
        receiver = try container.decodeIfPresent(Int.self, forKey: .receiver)
        time = try container.decodeIfPresent(String.self, forKey: .time)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        refId = try container.decodeIfPresent(Int.self, forKey: .refId)
    }
}

struct AddeCashEntityModel : Codable {
    var id : Int?
    var username : String?
    var countryCode : String?
    var issuerCode  : String?
    var decisionNo : String?
    var serialNo   : String?
    var parValue : String?
    var activeDate  : String?
    var expireDate  : String?
    var status  : String?
    var active  : Bool?
    
    init(id : Int,
         username : String,
         countryCode : String,
         issuerCode  : String ,
         decisionNo : String,
         serialNo   : String,
         parValue : String,
         activeDate  : String,
         expireDate  : String,
         status  : String,
         active  : Bool) {
        self.username = username
        self.countryCode = countryCode
        self.issuerCode = issuerCode
        self.decisionNo = decisionNo
        self.serialNo = serialNo
        self.parValue = parValue
        self.activeDate = activeDate
        self.expireDate = expireDate
        self.status = status
        self.active = active
        self.id = id
    }
    
    init() {
        
    }
    
    init(dataPackage : String) {
        let array = dataPackage.components(separatedBy: ";")
        if array.count >= 8{
            self.countryCode = array[0]
            self.issuerCode = array[1]
            self.decisionNo = array[2]
            self.serialNo = array[3]
            self.parValue = array[4]
            self.activeDate = array[5]
            self.expireDate = array[6]
            self.status = array[7]
        }
    }
}
