//
//  String+ByteArray.swift
//  ecash
//
//  Created by phong070 on 8/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func toByteArray() ->[UInt8]{
        return [UInt8](self.utf8)
    }
}
