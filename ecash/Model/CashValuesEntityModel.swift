//
//  CashValuesEntityModel.swift
//  ecash
//
//  Created by phong070 on 12/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class CashValuesEntityModel : Codable {
    var value : Int64?
    init(value : Int64) {
        self.value = value
    }
}
