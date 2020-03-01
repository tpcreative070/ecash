//
//  ArrayString+String.swift
//  ecash
//
//  Created by phong070 on 8/13/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension  String {
    func arrayToString(value : [String]) ->String{
       return value.joined(separator:"-")
    }
}
