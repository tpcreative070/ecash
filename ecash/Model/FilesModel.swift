//
//  FilesModel.swift
//  ecash
//
//  Created by phong070 on 10/18/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class FilesModel : Codable {
    var name : String?
    var path : String?
    init(name : String, path : String) {
        self.name = name
        self.path = path
    }
}
