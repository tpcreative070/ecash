//
//  QRCodeSenderModel.swift
//  ecash
//
//  Created by phong070 on 10/18/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class QRCodeSenderModel : Codable {
    var sender : String?
    var receiver : String?
    var time : String?
    var type : String?
    var content : String?
    var id : String?
    var cashEnc : String?
    
    init(data : TransferDataModel) {
        self.sender = data.sender
        self.receiver = data.receiver
        self.time = data.time
        self.type = data.type
        self.content = data.content
        self.id = data.id
        self.cashEnc = data.cashEnc
    }
}
