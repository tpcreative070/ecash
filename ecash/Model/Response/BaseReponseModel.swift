//
//  BaseReponseModel.swift
//  vietlifetravel
//
//  Created by Mac10 on 7/3/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
class BaseResponseModel : Decodable{
    var success : Bool?
    var msg : String?
    var responseCode : String?
    var responseMessage : String?
    private enum CodingKeys: String, CodingKey {
        case success = "success"
        case  msg = "msg"
        case responseCode  = "responseCode"
        case responseMessage = "responseMessage"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
        msg = try container.decodeIfPresent(String.self, forKey: .msg)
        responseCode = try container.decodeIfPresent(String.self, forKey : .responseCode)
        responseMessage = try container.decodeIfPresent(String.self, forKey : .responseMessage)
        if let mResponseCode = responseCode {
            if mResponseCode == EnumResponseCode.SESSION_NOT_EXISTED.rawValue {
                 NotificationCenter.default.post(name: .didRecieveUnauthorized, object: nil)
                 debugPrint("SESSION_NOT_EXISTED....")
            }
        }
    }
}
