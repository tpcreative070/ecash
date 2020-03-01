//
//  AppConstant.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit

class ResponseErrorModel: Decodable {
  let name: String?
  let message: String?
  let error : String?
  let responseCode : String?
  let responseMessage : String?
  let code: Int?
  let status: Int?
  let type: String?
  
  private enum CodingKeys: String, CodingKey {
    case name   = "name"
    case message = "message"
    case error = "error"
    case responseCode = "responseCode"
    case responseMessage = "responseMessage"
    case code    = "code"
    case status  = "status"
    case type    = "type"
  }
  
  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    error = try container.decodeIfPresent(String.self, forKey: .error)
    responseCode = try container.decodeIfPresent(String.self, forKey: .responseCode)
    responseMessage = try container.decodeIfPresent(String.self, forKey: .responseMessage)
    code = try container.decodeIfPresent(Int.self, forKey: .code)
    status = try container.decodeIfPresent(Int.self, forKey: .status)
    type = try container.decodeIfPresent(String.self, forKey: .type)
  }
}
