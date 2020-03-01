//
//  PushNotificationResponseModel.swift
//  ecash
//
//  Created by phong070 on 11/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PushNotificationResponseModel : Decodable {
  var title : String?
  var body : String?
  private enum CodingKeys : String, CodingKey {
      case title   = "title"
      case body   = "body"
  }
  required public init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     self.title = try container.decodeIfPresent(String.self, forKey: .title)
     self.body = try container.decodeIfPresent(String.self, forKey: .body)
  }
}
