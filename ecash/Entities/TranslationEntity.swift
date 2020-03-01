//
//  Translation.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
import RealmSwift

class TranslationEntity: Object {
  @objc dynamic var identify = UUID().uuidString + "-" + String(Date().getCurrentTimeUnix())
  @objc dynamic var lang = ""
  @objc dynamic var translations = ""
  
  override static func primaryKey() -> String? {
    return "lang"
  }
}
