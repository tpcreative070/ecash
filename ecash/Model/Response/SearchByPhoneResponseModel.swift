//
//  SearchByPhoneResponseModel.swift
//  ecash
//
//  Created by phong070 on 10/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SearchByPhoneResponseModel : BaseResponseModel {
    var responseData : SearchByPhoneData
    private enum CodingKeys: String, CodingKey {
        case responseData   = "responseData"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        responseData = try container.decodeIfPresent(SearchByPhoneData.self, forKey: .responseData) ?? SearchByPhoneData()
        try super.init(from: decoder)
    }
}

class SearchByPhoneData : Decodable {
    var customerStatus : String?
    var customerId : String?
    var personLastName : String?
    var idNumber : String?
    var personFirstName : String?
    var personMobilePhone : String?
    var personMiddleName : String?
    var wallets : [WalletData]?
    private enum CodingKeys: String, CodingKey {
        case customerStatus = "customerStatus"
        case customerId = "customerId"
        case personLastName = "personLastName"
        case idNumber = "idNumber"
        case personFirstName = "personFirstName"
        case personMobilePhone  = "personMobilePhone"
        case personMiddleName = "personMiddleName"
        case wallets = "wallets"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.customerStatus = try container.decodeIfPresent(String.self, forKey: .customerStatus)
        do {
            self.customerId  = try container.decodeIfPresent(String.self, forKey: .customerId)
        }
        catch {
           let result  = try container.decodeIfPresent(Int.self, forKey: .customerId)
           self.customerId  = result?.description
        }
        self.personLastName = try container.decodeIfPresent(String.self, forKey: .personLastName)
        self.idNumber = try container.decodeIfPresent(String.self, forKey: .idNumber)
        self.personFirstName = try container.decodeIfPresent(String.self, forKey: .personFirstName)
        self.personMobilePhone = try container.decodeIfPresent(String.self, forKey: .personMobilePhone)
        self.personMiddleName = try container.decodeIfPresent(String.self, forKey : .personMiddleName)
        self.wallets = try container.decodeIfPresent([WalletData].self, forKey: .wallets)
    }
    
    init() {
        
    }
}

class WalletData : Decodable {
    var customerId : Int?
    var walletId : Int?
    var ecPublicKey : String?
    var terminalInfo : String?
    
    private enum CodingKeys: String, CodingKey {
        case customerId = "customerId"
        case walletId = "walletId"
        case ecPublicKey = "ecPublicKey"
        case terminalInfo = "terminalInfo"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.customerId = try container.decodeIfPresent(Int.self, forKey: .customerId)
        self.walletId = try container.decodeIfPresent(Int.self, forKey: .walletId)
        self.ecPublicKey = try container.decodeIfPresent(String.self, forKey: .ecPublicKey)
        self.terminalInfo = try container.decodeIfPresent(String.self, forKey: .terminalInfo)
    }
    
    init() {
        
    }
}

