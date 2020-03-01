//
//  Int+Bool.swift
//  ecash
//
//  Created by phong070 on 9/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Int {
    var boolValue: Bool { return self != 0 }
}

extension Int64 {
    var boolValue: Bool { return self != 0 }
}
