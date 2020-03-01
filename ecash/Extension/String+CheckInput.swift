//
//  String+CheckInput.swift
//  vietlifetravel
//
//  Created by phong070 on 7/10/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension String {
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
}
