//
//  ListAvailableViewModel.swift
//  ecash
//
//  Created by phong070 on 9/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ListAvailableViewModel : Codable , AvailableCashViewModelDeletegate {
    var moneyView: String? {
        return money ?? "0".toMoney()
    }
    
    var groupId : Int {
        return money?.toInt() ?? 0
    }
    
    var countView: String? {
        return list.count.description
    }
    
    var count : Int {
        return list.count
    }
    var countSelected: Int = 0
    var money : String?
    var list = [CashLogsEntityModel]()
    
   
    init(money : String,data : [CashLogsEntityModel]) {
        Utils.logMessage(object: data)
        self.list = data
        self.money = money
        self.countSelected = 0
    }
}
