//
//  Data+String.swift
//  ecash
//
//  Created by phong070 on 8/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Data {
    func toString() -> String?{
        return String(data: self, encoding: .utf8)
    }
}
