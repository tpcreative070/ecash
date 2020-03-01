//
//  String+Data.swift
//  ecash
//
//  Created by phong070 on 8/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func toData() -> Data?{
        return self.data(using: .utf8)
    }
}
