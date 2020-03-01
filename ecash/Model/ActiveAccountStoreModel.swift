//
//  ActiveAccountStoreModel.swift
//  ecash
//
//  Created by phong070 on 9/10/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ActiveAccountStoreModel : Codable {
    var accountIdt : String?
    var channelCode : String?
    var customerId : String?
    var functionCode : String?
    var idNumber : String?
    var userId : String?
    var channelSignature : String?
    var functionId : Int?
    var channelId : String?
    var status : String?
    var id : String?
    var auditNumber : String?
    var approveStatus : String?
    
    init(data : ActiveAccountModel) {
        self.accountIdt = data.accountIdt
        self.channelCode = data.channelCode
        self.customerId = data.customerId
        self.functionCode = data.functionCode
        self.idNumber = data.idNumber
        self.userId = data.userId
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.status = data.status
        self.id = data.id
        self.auditNumber = data.auditNumber
        self.approveStatus = data.approveStatus
    }
}
