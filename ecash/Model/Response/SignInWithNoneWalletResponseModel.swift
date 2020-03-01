//
//  SignInWithNoneWalletRequestModel.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInWithNoneWalletResponseModel : BaseResponseModel {
    var responseData : SignInWithNonWalletData
      private enum CodingKeys: String, CodingKey {
          case responseData   = "responseData"
      }
      required public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          responseData = try container.decodeIfPresent(SignInWithNonWalletData.self, forKey: .responseData) ?? SignInWithNonWalletData()
          try super.init(from: decoder)
      }
}

class SignInWithNonWalletData : Decodable {
    var walletId : String?
    var lastAccessTime : String?
    var masterKey : String?
    var channelSignature : String?
    var transactionCode : String?
    var userId : String?
    var channelId : String?
    var channelCode : String?
    
    private enum CodingKeys: String, CodingKey {
        case walletId = "walletId"
        case lastAccessTime = "lastAccessTime"
        case masterKey = "masterKey"
        case channelSignature = "channelSignature"
        case transactionCode = "transactionCode"
        case userId = "userId"
        case channelId = "channelId"
        case channelCode = "channelCode"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.walletId = try container.decodeIfPresent(String.self, forKey: .walletId)
        }
        catch {
            let result  = try container.decodeIfPresent(Int.self, forKey: .walletId)
            self.walletId = result?.description
        }
        self.lastAccessTime = try container.decodeIfPresent(String.self, forKey: .lastAccessTime)
        self.masterKey = try container.decodeIfPresent(String.self, forKey: .masterKey)
        self.channelSignature = try container.decodeIfPresent(String.self, forKey: .channelSignature)
        self.transactionCode = try container.decodeIfPresent(String.self, forKey: .transactionCode)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.channelId = try container.decodeIfPresent(String.self, forKey: .channelId)
        self.channelCode = try container.decodeIfPresent(String.self, forKey: .channelCode)
    }
      
    init() {
          
    }
}
