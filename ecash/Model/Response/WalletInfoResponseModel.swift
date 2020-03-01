//
//  WalletInfoResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class WalletInfoResponseModel : BaseResponseModel {
    
    var responseData : WalletInfoData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(WalletInfoData.self, forKey: .responseData) ?? WalletInfoData()
        try super.init(from: decoder)
    }
}

class WalletInfoData : Decodable {
    var customerId : Int?
    var ecKpValue : String?
    var ecKpAlias : String?
    var idType : String?
    var personLastName : String?
    var idNumber : String?
    var personFirstName : String?
    var personMobilePhone : String?
    var personMiddleName : String?
    var deviceInfo : String?
    
    private enum CodingKeys: String, CodingKey {
        case customerId = "customerId"
        case ecKpValue = "ecKpValue"
        case ecKpAlias = "ecKpAlias"
        case idType  = "idType"
       
        case idNumber = "idNumber"
        case personFirstName = "personFirstName"
        case personMiddleName = "personMiddleName"
        case personLastName = "personLastName"
        case personMobilePhone = "personMobilePhone"
        case deviceInfo = "deviceInfo"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idType =  try container.decodeIfPresent(String.self, forKey: .idType)
        idNumber =  try container.decodeIfPresent(String.self, forKey: .idNumber)
        personFirstName =  try container.decodeIfPresent(String.self, forKey: .personFirstName)
        personMiddleName =  try container.decodeIfPresent(String.self, forKey: .personMiddleName)
        personLastName =  try container.decodeIfPresent(String.self, forKey: .personLastName)
        personMobilePhone =  try container.decodeIfPresent(String.self, forKey: .personMobilePhone)
        do {
            customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        }
        catch {
            let result  = try container.decodeIfPresent(String.self, forKey: .customerId)
            customerId = Int(result ?? "0")
        }
        ecKpValue = try container.decodeIfPresent(String.self, forKey: .ecKpValue)
        ecKpAlias = try container.decodeIfPresent(String.self, forKey: .ecKpAlias)
        deviceInfo = try container.decodeIfPresent(String.self, forKey : .deviceInfo)
    }
    
    init() {
    }
}
