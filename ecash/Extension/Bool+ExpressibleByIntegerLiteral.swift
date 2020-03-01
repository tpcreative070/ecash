//
//  Bool+ExpressibleByIntegerLiteral.swift
//  ecash
//
//  Created by phong070 on 9/16/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = value != 0
    }
}
