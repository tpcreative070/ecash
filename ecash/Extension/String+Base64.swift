//
//  String+Base64.swift
//  ecash
//
//  Created by phong070 on 8/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> Data? {
        var st = self;
        if (self.count % 4 <= 2){
            st += String(repeating: "=", count: (self.count % 4))
        }
        guard let data = Data(base64Encoded: st) else {
            return nil
        }
        return data
    }
}
