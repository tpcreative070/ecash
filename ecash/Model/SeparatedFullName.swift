//
//  SeparatedFullName.swift
//  ecash
//
//  Created by phong070 on 9/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct SeparatedFullName {
    var firstName : String?
    var lastName : String?
    var middleName : String?
    init(firstName : String, lastName : String, middleName : String) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
    }
}
