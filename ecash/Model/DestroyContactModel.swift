//
//  DestroyContactModel.swift
//  ecash
//
//  Created by phong070 on 11/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class DestroyContactModel : Codable {
    var receiver : Int?
    var sender : Int?
    var time : String?
    var refId : String?
    var type : String?
    var channelId : Int?
}
