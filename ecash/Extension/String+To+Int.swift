//
//  String+To+Int.swift
//  ecash
//
//  Created by phong070 on 9/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
   func toInt() ->Int{
    let value = Int(self)
    if value != nil {
        return value ?? 0
    }
    return 0
   }
}
