//
//  String+PhoneNumber.swift
//  ecash
//
//  Created by phong070 on 10/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func toPhoneNumber()->String?{
        var result = self
        if self.first != "0"{
            var mValue = self
            mValue  = "0\(mValue)"
            result =  mValue
        }else if self.contains("+84"){
            let mValue = self.replace(target: "+84", withString: "0")
            result = mValue
        }
        if result.count > 9 &&  result.count < 11 {
            return result
        }
        return nil
    }
}
