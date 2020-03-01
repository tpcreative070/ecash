//
//  String+SubString.swift
//  ecash
//
//  Created by phong070 on 10/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension String {
    func substringsOfLength(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        return results.map { String($0) }
    }
}
