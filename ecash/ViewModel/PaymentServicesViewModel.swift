//
//  PaymentServicesViewModel.swift
//  ecash
//
//  Created by phong070 on 8/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PaymentServicesViewModel : PaymentServicesDelegate, Codable {
    var iconView: String {
        return self.icon ?? ""
    }
    
    var nameView: String {
        return self.name ?? ""
    }
    
    var icon : String?
    var name : String?
    var position : Int?
    init(data : PaymentServicesModel) {
        self.icon = data.icon
        self.name = data.name
        self.position = data.position
    }
}
