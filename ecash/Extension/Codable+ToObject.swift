//
//  Codable+ToObject.swift
//  ecash
//
//  Created by phong070 on 8/2/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

extension Encodable {
    func get<T : Codable>(value : T.Type) ->T?{
        do{
            let jsonData = JSONSerializerHelper.toJson(self).data(using: .utf8)
            if let jsonDataValue = jsonData{
                return try JSONDecoder().decode(value.self, from: jsonDataValue)
            }
        }catch{
            Utils.logMessage(message: "Could not cast data")
        }
        return value as? T
    }
}
