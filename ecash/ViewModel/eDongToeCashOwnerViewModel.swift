//
//  eDongToeCashOwnerViewModel.swift
//  ecash
//
//  Created by phong070 on 9/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongToeCashOwnerViewModel : Codable {
    var cashEnc : String?
    var id : String?
    var sender : String?
    var receiver : Int?
    var time : String?
    var type : String?
    var content : String?
    var refId : Int?
    
    //eDong to ecash owner
    init(data : eDongToeCashData) {
        self.cashEnc = data.cashEnc?.replace(target: "\\", withString: "") ?? ""
        self.id = data.id ?? ""
        self.sender = data.receiver?.description ?? ""
        self.receiver = data.receiver ?? 0
        self.time = data.time ?? "0"
        self.type = data.type ?? ""
        self.content = data.content ?? "null"
        self.refId = data.refId ?? 0
    }
}
