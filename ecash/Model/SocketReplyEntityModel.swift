//
//  SocketReplyEntityModel.swift
//  ecash
//
//  Created by phong070 on 10/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SocketReplyEntityModel : Codable {
    var replyId : String?
    
    init(replyId : String) {
        self.replyId = replyId
    }
    
}
