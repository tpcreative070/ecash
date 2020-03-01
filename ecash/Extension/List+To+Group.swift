//
//  List+To+Group.swift
//  ecash
//
//  Created by phong070 on 9/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        return Dictionary.init(grouping: self, by: key)
    }
}
