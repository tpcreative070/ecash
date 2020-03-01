//
//  Dictionary+String.swift
//  ecash
//
//  Created by phong070 on 11/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension Dictionary {
  var json: String {
    let invalidJson = "Not a valid JSON"
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
      return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
    } catch {
      return invalidJson
    }
  }
  func printJson() {
    print(json)
  }
}
