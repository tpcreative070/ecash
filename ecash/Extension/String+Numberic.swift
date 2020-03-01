//
//  String+Numberic.swift
//  ecash
//
//  Created by phong070 on 12/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
}
