//
//  TransferDataSyncContactModel.swift
//  ecash
//
//  Created by phong070 on 10/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransferDataSyncContactModel : Codable{
    var receiver : String?
    var sender : Int?
    var refId : String?
    var time : String?
    var type : String?
    var channelId : String?
    var contacts : [TransferDataSyncContactData]?
    
    init(refId : String) {
        self.refId = refId
    }
}

class TransferDataSyncContactData : Codable {
    var customerId : Int?
    var walletId : Int?
    var ecPublicKey : String?
    var terminalInfo : String?
    var personMobilePhone : String?
}
