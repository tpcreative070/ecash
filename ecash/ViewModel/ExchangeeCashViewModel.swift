//
//  ExchangeeCashViewModel.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExchangeeCashViewModel : ExchangeeCashViewModelDelegate, Codable {
    var moneyView: String {
        return money?.toMoney() ?? "0".toMoney()
    }
    var countView: String {
        return count?.description ?? "0"
    }
    
    var groupId : Int {
        return money?.toInt() ?? 0
    }
    
    var count : Int?
    var money : String?
    var list = [CashLogsEntityModel]()
    
    var cashEnc : String?
    var id : String?
    var sender : String?
    var receiver : Int?
    var time : String?
    var type : String?
    var content : String?
    var refId : Int?
    
    init(money : String,data : [CashLogsEntityModel]) {
        Utils.logMessage(object: data)
        self.list = data
        self.money = money
        self.count = list.count
    }
    
    //Response exchange cash
    init(data : ExchangeCashData) {
        self.cashEnc = data.cashEnc?.replace(target: "\\", withString: "") ?? ""
        self.id = data.id ?? ""
        self.sender = data.receiver?.description ?? ""
        self.receiver = data.receiver ?? 0
        self.time = data.time ?? "0"
        self.type = data.type ?? ""
        self.content = data.content ?? "null"
    }
}
