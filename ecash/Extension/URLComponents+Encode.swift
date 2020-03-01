//
//  URLComponents+Encode.swift
//  ecash
//
//  Created by phong070 on 9/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
