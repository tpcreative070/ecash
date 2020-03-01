//
//  QRCodeModel.swift
//  ecash
//
//  Created by phong070 on 10/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class QRCodeModel : Codable{
    var cycle : Int?
    var total : Int?
    var content : String?
    var isDisplay : Bool?
    var time : String?
    var type : String? = nil
    
    init(cycle : Int, total : Int, content : String, isDisplay : Bool) {
        self.cycle = cycle
        self.total = total
        self.content = content
        self.isDisplay = isDisplay
        self.time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardTransaction)
    }
    
    /*Show/hide item*/
    init(data : QRCodeModel, isDisplay : Bool) {
        self.cycle = data.cycle
        self.total = data.total
        self.content = data.content
        self.isDisplay = isDisplay
        self.time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardTransaction)
    }
    //

    init() {
        
    }
}
