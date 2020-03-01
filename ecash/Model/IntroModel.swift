//
//  IntroModel.swift
//  ecash
//
//  Created by phong070 on 11/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class IntroModel : Codable {
    var title : String?
    var detail : String?
    var image : String?
    
    init(title : String,detail : String ,image : String) {
        self.title = title
        self.image = image
        self.detail = detail
    }
    
    init() {
        
    }
}
