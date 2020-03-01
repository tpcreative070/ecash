//
//  eDongInfoViewModel.swift
//  ecash
//
//  Created by phong070 on 9/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class eDongInfoViewModel : Codable {
  
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId : String?
    var terminalInfo : String?
    var token : String?
    var username : String?
    var waletId : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : String?
    var channelId : Int?
    var totalPages : Int?
    var listAcc : [AccountInfoDataViewModel]?
    
    init(data : eDongInfoData) {
        self.auditNumber = data.auditNumber
        self.channelCode = data.channelCode
        self.functionCode = data.functionCode
        self.sessionId = data.sessionId
        self.terminalId = data.terminalId
        self.terminalInfo = data.terminalInfo
        self.token = data.token
        self.username = data.username
        self.waletId = data.waletId
        self.channelSignature = data.channelSignature
        self.customerId = data.customerId
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.totalPages = data.totalPages
        if let mData = data.listAcc {
            self.listAcc = mData.map({ (event) -> AccountInfoDataViewModel  in
                return AccountInfoDataViewModel(data: event)
            })
        }
    }
}


class AccountInfoDataViewModel : Codable {
    var accountType : Int?
    var accLock: Int?
    var accountStatus : String?
    var accountIdt : String?
    var accBalance : Int?
    
    init() {
    }
    
    init(data : AccountInfoData) {
        self.accountType = data.accountType
        self.accLock = Int(data.accLock ?? 0)
        self.accountStatus = data.accountStatus
        self.accountIdt = data.accountIdt?.description
        self.accBalance = Int(data.accBalance ?? 0)
    }
}
