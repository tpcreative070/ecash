//
//  String+ContainWhiteSpace.swift
//  ecash
//
//  Created by phong070 on 9/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
}
