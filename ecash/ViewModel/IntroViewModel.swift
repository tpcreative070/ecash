//
//  IntroViewModel.swift
//  ecash
//
//  Created by phong070 on 11/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class IntroViewModel : IntroViewModelDelegate, Codable {
    var detailView: String {
        return detail ?? ""
    }
    var titleView: String{
        return title ?? ""
    }
    
    var imageView: String{
        return image ?? ""
    }

    var title : String?
    var detail  :String?
    var image : String?
    
    init(data : IntroModel) {
        self.title = data.title
        self.detail = data.detail
        self.image = data.image
    }
}
