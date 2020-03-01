//
//  TemplateModel.swift
//  ecash
//
//  Created by phong070 on 1/17/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class TemplateModel : Codable {
    var imgName : String?
    var code : String?
    var isSelected : Bool?
    
    init(imgName : String, code : String,isSelected : Bool) {
        self.imgName = imgName
        self.code = code
        self.isSelected = isSelected
    }
}
