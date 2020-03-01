//
//  FindECashUtil.swift
//  ecash
//
//  Created by ECAPP on 1/22/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation

class FindECashUtil {
    public func recursiveFindeCashs(walletList: [CashLogsEntityModel], partialList: [CashLogsEntityModel], amount: Int64, completed: inout ([CashLogsEntityModel], Int64, [CashLogsEntityModel]) -> Void) {
        var remainAmount = amount
        var nextWalletList = walletList
        var nextListPartial = partialList
        if (walletList.count > 0) {
            var isBreaked = false
            var ind = 0
            while (isBreaked == false && ind < walletList.count) {
                let item = walletList[ind]
                let value = item.value ?? 0
                if (value <= remainAmount) {
                    isBreaked = true
                    remainAmount -= value
                    nextListPartial.append(item)
                    nextWalletList.remove(at: ind)
                    if(remainAmount <= 0){
                        // Completed get eCash page from Wallet for amount
                        print("------------Completed---------------")
                        completed(nextListPartial, remainAmount, nextWalletList)
                    } else {
                        // Continue get eCash page
                        print("------------Continue---------------")
                        recursiveFindeCashs(walletList: nextWalletList, partialList: nextListPartial, amount: remainAmount, completed: &completed)
                    }
                } else if (ind == walletList.count - 1) {
                    // Have reach end of Wallet
                    print("------------Reach End---------------")
                    completed(nextListPartial, remainAmount, nextWalletList)
                    isBreaked = true
                }
                ind += 1
            }
            
        } else {
            // Wallet have no money
            completed(nextListPartial, remainAmount, nextWalletList)
        }
    }
    
    // =========== This part working for eCash Exchange ===========
    public func recursiveGetArrayNeedExchange(remainAmount: Int64, partialArray: [CashLogsEntityModel]) -> DenominationsOptimal {
        let denominations = getOptilmalDenominations(money: remainAmount)
        let mutile: Int64 = remainAmount/denominations
        let wholeAmout = denominations * mutile
        let oddAmount = remainAmount - wholeAmout
        var nextArray = partialArray
        for _ in 0..<mutile {
            let item = CashLogsEntityModel(
                    id : 0,
                    countryCode : "nil",
                    issuerCode : "nil",
                    decisionNo : "nil",
                    serial   : Int64(0),
                    value  : denominations,
                    actived  : "nil",
                    expired  : "nil",
                    accountSignature  : "nil",
                    cycle  : 0,
                    treasureSignature  : "nil",
                    type  : true,
                    transactionSignature  : "nil",
                    previousHash : "nil"
            )
            nextArray.append(item)
        }
        if oddAmount <= 200 {
            print("====> Done < ====")
            return DenominationsOptimal(array: nextArray, remain: oddAmount)
        } else {
            print("====> Continue < ====")
            return recursiveGetArrayNeedExchange(remainAmount: oddAmount, partialArray: nextArray)
        }
    }
    
    public func getOptilmalDenominations(money: Int64) -> Int64 {
        let arrayDenominations = [Int64(200), Int64(500), Int64(1000), Int64(2000), Int64(5000), Int64(10000), Int64(20000), Int64(50000), Int64(100000), Int64(200000), Int64(500000)]
        var max = Int64(0)
        for value in arrayDenominations {
            if value <= money {
                max = value
            }
        }
        return max
    }
    // ================= End Of eCash Exchange ====================
}

struct DenominationsOptimal {
    var array: [CashLogsEntityModel] = []
    var remain: Int64 = 0
    init(array: [CashLogsEntityModel], remain: Int64) {
        self.array = array
        self.remain = remain
    }
}
