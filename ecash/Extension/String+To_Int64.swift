//
//  String+To_Int64.swift
//  ecash
//
//  Created by phong070 on 9/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func toInt64() ->Int64{
        let value = Int64(self)
        if value != nil {
            return value ?? 0
        }
        return 0
    }
}
