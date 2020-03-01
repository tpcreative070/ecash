//
//  String+SpecialCharacterUsername.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension  String{
    func isSpecialCharacter() -> Bool{
        if self.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) != nil {
            return true
        }
        return false
    }
}
