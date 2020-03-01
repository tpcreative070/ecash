//
//  ConfigurationStoreModel.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
struct ConfigurationStoreModel: Codable {
    var isAutoLogin: Bool
    var isUseDefault: Bool
    var serverUrl: String
    init(isAutoLogin: Bool, isUseDefault: Bool, serverUrl: String) {
        self.isAutoLogin = isAutoLogin
        self.isUseDefault = isUseDefault
        self.serverUrl = serverUrl
    }
}
