//
//  ReceiveLixiOptionsViewModel.swift
//  ecash
//
//  Created by phong070 on 12/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ReceiveLixiOptionsViewModel : ReceiveLixiOptionsViewModelDeletegate , Codable {
    var moneyView: String {
        return money?.toMoney() ?? "0".toMoney()
    }
    
    var countView: String {
        return count?.description ?? "0"
    }
    
    var groupId : Int {
         return money?.toInt() ?? 0
    }

    var count: Int?
    var money : String?
   
    init(money : String,data : [CashLogsEntityModel]) {
        self.money = money
        self.count = data.count
    }
      
}
