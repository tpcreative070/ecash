//
//  TransferMultipleListViewModel.swift
//  ecash
//
//  Created by phong070 on 12/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransferMultipleViewModel : TransferCashMultipleViewModelDeletegate ,Codable {
  
        var moneyView: String? {
            return money ?? "0".toMoney()
        }
        
        var groupId : Int {
            return money?.toInt() ?? 0
        }
        
        var countView: String? {
            return list.count.description
        }
        
        var counteCashIdArray: Int {
            var countWalletId = eCashIdArray.count
            if countWalletId == 0{
                countWalletId = 1
            }
            return countWalletId
        }
        
        var count : Int {
            return list.count
        }
        var countSelected: Int = 0
        var money : String?
        var list = [CashLogsEntityModel]()
        var eCashIdArray = [String]()
       
        init(money : String,data : [CashLogsEntityModel],eCashIdArray : [String]) {
            Utils.logMessage(object: data)
            self.list = data
            self.money = money
            self.countSelected = 0
            self.eCashIdArray = eCashIdArray
        }
        
}
