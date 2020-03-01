//
//  TemplateViewModel.swift
//  ecash
//
//  Created by phong070 on 1/17/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class TemplateViewModel : Codable, TemplateViewModelDelegate {
    
    var imgNameView: String {
        return imgName ?? ""
    }
    var codeView: String {
        return code ?? ""
    }
    var isSelectedView: Bool {
        return isSelected ?? false
    }
   
    var imgName : String?
    var code : String?
    var isSelected : Bool?
    init(data : TemplateModel) {
        self.imgName = data.imgName
        self.code = data.code
        self.isSelected = data.isSelected
    }
}
