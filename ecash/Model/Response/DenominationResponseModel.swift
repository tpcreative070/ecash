//
//  DenominationResponseModel.swift
//  ecash
//
//  Created by phong070 on 12/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class DenominationResponseModel : BaseResponseModel {
      var responseData : DenominationData
      private enum CodingKeys: String, CodingKey {
          case responseData   = "responseData"
      }
      required public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          responseData = try container.decodeIfPresent(DenominationData.self, forKey: .responseData) ?? DenominationData()
          try super.init(from: decoder)
      }
}



class DenominationData : Decodable {
    var listDenomination : [DenominationDataObject]?
    private enum CodingKeys: String, CodingKey {
        case listDenomination   = "listDenomination"
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        listDenomination = try container.decodeIfPresent([DenominationDataObject].self, forKey: .listDenomination) ?? [DenominationDataObject]()
    }
    init() {
        
    }
}

class DenominationDataObject : Decodable {

    var denominationId : Int?
    var issuerId : Int?
    var value : Int?
    var denominationName : String?
      
    private enum CodingKeys: String, CodingKey {
        case denominationId = "denominationId"
        case issuerId = "issuerId"
        case value = "value"
        case denominationName = "denominationName"
    }
      
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.denominationId = try container.decodeIfPresent(Int.self, forKey: .denominationId)
        self.issuerId = try container.decodeIfPresent(Int.self, forKey: .issuerId)
        self.value = try container.decodeIfPresent(Int.self, forKey: .value)
        self.denominationName = try container.decodeIfPresent(String.self, forKey: .denominationName)
    }
    init() {
          
    }
}
