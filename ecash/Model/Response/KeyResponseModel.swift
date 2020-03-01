//
//  PushNotificationResponseModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class KeyResponseModel : Decodable {
  var type : String?
  var channelKp : String?
  var clientKp : String?
  var clientKs : String?
  private enum CodingKeys : String, CodingKey {
      case type   = "type"
      case channelKp   = "channelKp"
      case clientKp = "clientKp"
      case clientKs   = "clientKs"
  }
  required public init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     self.type = try container.decodeIfPresent(String.self, forKey: .type)
     self.channelKp = try container.decodeIfPresent(String.self, forKey: .channelKp)
     self.clientKp = try container.decodeIfPresent(String.self, forKey: .clientKp)
     self.clientKs = try container.decodeIfPresent(String.self, forKey: .clientKs)
  }
}
