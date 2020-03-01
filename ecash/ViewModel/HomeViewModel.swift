//
//  HomeViewModel.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit

class HomeViewModel : HomeViewModelDelegate , Codable  {
    var fullNameView: String {
        return "\(firstName ?? "") \(middleName ?? "") \(lastName ?? "")"
    }
    
    var eCashIdView: String {
        return eDongId ?? ""
    }
    
    var eCashBalanceView: String {
        return eCashBalance ?? ""
    }
    
    var eDongIdView: String {
        return eDongId ?? ""
    }
    
    var eDongBalanceView: String {
        return eDongBalance ?? ""
    }

    var firstName : String?
    var middleName : String?
    var lastName : String?
    var eCashId : String?
    var eCashBalance : String?
    var eDongId : String?
    var eDongBalance : String?
    
    init(data : eDongInfoViewModel) {
        guard let  signUp = CommonService.getSignUpStoreData() else{
            return
        }
        self.firstName = signUp.personFirstName
        self.middleName = signUp.personMiddleName
        self.lastName = signUp.personLastName
        self.eCashId = signUp.walletId?.description
        self.eCashBalance = ""
        self.eDongId = ""
        self.eDongBalance  = ""
    }
}
