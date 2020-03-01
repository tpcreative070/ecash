//
//  ScannerResultViewModel.swift
//  ecash
//
//  Created by phong070 on 10/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

class ScannerResultViewModel : Codable, ScannerResultViewModelDelegate {
    var totalMoneyView: String {
        return totalMoney?.toMoney() ?? "0".toMoney()
    }
    
    var senderNameView: String {
        return "\(firstName ?? "") \(middleName ?? "") \(lastName ?? "")"
    }
    
    var phoneNumnerView: String {
        return phoneNumber ?? ""
    }
    
    var contentView: String {
        return content ?? ""
    }
    
    var cashList: [CashListViewModel] = [CashListViewModel]()
    var totalMoney : String?
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var phoneNumber : String?
    var content : String?
    
    init(transactionsId : String, walletId : String) {
        
        if let mData = SQLHelper.getContacts(key: Int64(walletId) ?? 0){
            let mName = mData.fullName?.toSeparatedName()
            self.firstName = mName?.firstName
            self.middleName = mName?.middleName
            self.lastName = mName?.lastName
            self.phoneNumber = mData.phone
        }else{
            self.firstName = ""
            self.middleName = ""
            self.lastName = ""
            self.phoneNumber = ""
        }
    
        if let mList = SQLHelper.getListCashLogs(transactionsId: transactionsId){
            let result = mList.group(by: {$0.value})
            var mMoney = 0
            Utils.logMessage(message: "Value........")
            Utils.logMessage(object: mList)
            result.enumerated().forEach { (index, element) in
                let mResult = (Int(element.key ?? 0) * element.value.count)
                mMoney += mResult
                debugPrint("keyyyyyyyyyyyyyy \(element.key?.description) -------  valueeeeeeeee \(element.value.count.description)")
                
                cashList.append(CashListViewModel(status: true, money: element.key?.description ?? "" , data: element.value))
            }
            self.totalMoney = mMoney.description
            Utils.logMessage(message: "Value........\(self.totalMoney ?? "0")")
        }
        
        if let mList = SQLHelper.getListCashInvaidLogs(transactionsId: transactionsId){
            let result = mList.group(by: {$0.value})
            result.enumerated().forEach { (index, element) in
                cashList.append(CashListViewModel(status: false, money: element.key?.description ?? "" , data: element.value))
            }
        }
        cashList = cashList.sorted{$0.groupId > $1.groupId}
        
        if let mData = SQLHelper.geteTransactionsLogs(key: transactionsId){
            self.content = mData.content
        }
    }
}

class CashListViewModel : CashViewModelDeletegate , Codable{
   
    var moneyView: String? {
        return money?.toMoney() ?? "0".toMoney()
    }

    var countView: String?{
        return count?.description ?? ""
    }
    
    var imageNameView: String? {
        return imageName ?? ""
    }
    
    var groupId : Int {
        return money?.toInt() ?? 0
    }
    
    var money : String?
    var count : Int?
    var imageName : String?

    init(status : Bool ,money : String,data : [CashLogsEntityModel]) {
        self.money = money
        self.count = data.count
        if status {
            self.imageName = AppImages.IC_CHECK_SUCCESS
        }else{
            self.imageName = AppImages.IC_CHECK_FAIL
        }
    }
}
