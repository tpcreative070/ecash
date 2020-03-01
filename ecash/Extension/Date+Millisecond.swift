//
//  Date+Millisecond.swift
//  ecash
//
//  Created by phong070 on 11/15/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    init(millis: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(millis / 1000))
        self.addTimeInterval(TimeInterval(Double(millis % 1000) / 1000 ))
    }
}
