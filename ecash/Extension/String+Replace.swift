//
//  File.swift
//  ecash
//
//  Created by phong070 on 8/2/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String{
    func replace(target: String, withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
