//
//  String+ToObject.swift
//  ecash
//
//  Created by phong070 on 9/13/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func toObject<T : Codable>(value : T.Type) ->T? {
        do {
            guard let mData = self.toData() else {
                return nil
            }
            let f = try JSONDecoder().decode(value.self, from: mData)
            return f
        } catch {
            print(error)
        }
        return nil
    }
}
