//
//  SendDataModel.swift
//  ecash
//
//  Created by phong070 on 8/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SendDataModel : Codable {
    let p1 : String?
    let p2 : String?
    let p3 : String?
    init(p1 : String, p2 : String, p3 : String) {
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
    }
}
