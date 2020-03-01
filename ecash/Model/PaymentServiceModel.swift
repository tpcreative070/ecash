//
//  PaymentServiceModel.swift
//  ecash
//
//  Created by phong070 on 8/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PaymentServicesModel  {
    var icon : String
    var name : String
    var position : Int
    init() {
        self.icon = ""
        self.name = ""
        self.position = 0
    }
    init(icon : String, name : String, position : Int) {
        self.icon = icon
        self.name = name
        self.position = position
    }
}
