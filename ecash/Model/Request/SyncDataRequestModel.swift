//
//  SyncDataRequestModel.swift
//  ecash
//
//  Created by phong070 on 8/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SyncDataRequestModel : Codable {
    var auditNumber : String?
    let url : String
    let fileName : String
    let pathFile : String
    init(url : String, fileName : String, pathFile : String) {
        self.url = url
        self.fileName = fileName
        self.pathFile = pathFile
    }
}
