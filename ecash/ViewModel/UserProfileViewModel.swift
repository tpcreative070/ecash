//
//  UserProfileViewModel.swift
//  ecash
//
//  Created by phong070 on 9/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class UserProfileViewModel : Codable , UserProfileViewModelDeletegate{
    var phoneNumberView: String? {
        return phoneNumber ?? ""
    }
    var emailView: String? {
        return email ?? ""
    }
    var addressView: String? {
        return address ?? ""
    }
    var idNumberView: String? {
        return idNumber ?? ""
    }
    var eCashPhoneNumberView: String? {
        return phoneNumber ?? ""
    }
    var fullNameView: String?{
        return "\(firstName ?? "") \(middleName ?? "") \(lastName ?? "")"
    }
    var eCashIdView: String? {
        return eCashId ?? ""
    }
    var eCashBalanceView: String? {
        return "\(eCashBalance?.toMoney() ?? "0".toMoney())"
    }
    var eDongIdView: String? {
        return eDongId ?? ""
    }
    var eDongBalanceView: String?{
       let mAvailable = eDongAvailable ?? 0
       return "\(mAvailable.description.toMoney())"
    }
    
    var idNumber : String?
    var firstName : String?
    var middleName : String?
    var lastName  : String?
    var eCashId : String?
    var eCashBalance : String?
    var eDongId : String?
    var eDongBalance : String?
    var eDongusableBalance : String?
    var eDongMinBalance : Int?
    var eDongAccLock : String?
    var eDongAvailable : Int?
    var phoneNumber : String?
    var address : String?
    var email : String?
    var listAccount = [AccountInfoDataVM]()
    var listeDong = [String]()
    
    init() {
        if let signUpData = CommonService.getSignUpStoreData(){
            self.eCashId = signUpData.walletId?.description ?? ""
            self.firstName = signUpData.personFirstName ?? ""
            self.middleName = signUpData.personMiddleName ?? ""
            self.lastName = signUpData.personLastName ?? ""
            self.phoneNumber = signUpData.personMobilePhone ?? ""
            self.idNumber = signUpData.idNumber ?? ""
            self.email = signUpData.personEmail ?? ""
            self.address = signUpData.personCurrentAddress ?? ""
            if let availableList = SQLHelper.getTotaleCash(){
                self.eCashBalance = availableList.description
            }
        }
    }

    init(data : [AccountInfoData]) {
        if let signUpData = CommonService.getSignUpStoreData(){
            self.eCashId = signUpData.walletId?.description ?? ""
            self.firstName = signUpData.personFirstName ?? ""
            self.middleName = signUpData.personMiddleName ?? ""
            self.lastName = signUpData.personLastName ?? ""
            self.phoneNumber = signUpData.personMobilePhone ?? ""
            self.idNumber = signUpData.idNumber ?? ""
            self.email = signUpData.personEmail ?? ""
            self.address = signUpData.personCurrentAddress ?? ""
            if let availableList = SQLHelper.getTotaleCash(){
                self.eCashBalance = availableList.description
            }
        }
        self.listAccount = data.map({ (result) -> AccountInfoDataVM in
            self.listeDong.append(result.accountIdt?.description ?? "")
            return AccountInfoDataVM(data: result)
        })
        
        if self.listAccount.count>0{
            let account = listAccount[0]
            self.eDongId = account.accountIdt?.description
            self.eDongBalance = account.accBalance?.description
            self.eDongusableBalance = account.usableBalance?.description
            self.eDongMinBalance = account.minBalance
            self.eDongAccLock = account.accLock?.description
            let available = (self.eDongBalance?.toInt() ?? 0) - (self.eDongAccLock?.toInt() ?? 0)
            if available > 0 {
                self.eDongAvailable = available
            }else{
                self.eDongAvailable = 0
            }
            CommonService.seteDongStoreData(storeInfo: eDongStoreModel(data: account))
        }
    }
}

class AccountInfoDataVM : Codable{
    var accountType : Int?
    var accLock: Int?
    var accountStatus : String?
    var accountIdt : String?
    var accBalance : Int?
    var usableBalance : Int?
    var minBalance : Int?
    init(data : AccountInfoData) {
        self.accountType = data.accountType
        self.accLock = Int(data.accLock ?? 0)
        self.accountStatus = data.accountStatus
        self.accountIdt = data.accountIdt?.description
        self.accBalance = Int(data.accBalance ?? 0)
        self.usableBalance = Int(data.usableBalance ?? 0)
        self.minBalance = Int(data.minBalance ?? 0)
    }
}
