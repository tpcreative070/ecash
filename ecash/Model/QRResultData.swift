//
//  QRResultData.swift
//  ecash
//
//  Created by ECAPP on 1/18/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation

class QRResultData: NSObject {
    var target: String
//    var value: String
    var valueObject: Any
    var valueObjectType: String
    
    init(target: String, valueObject: Any, valueObjectType: String) {
        self.target = target
        self.valueObject = valueObject
        self.valueObjectType = valueObjectType
    }
}
