//
//  ContactViewModel.swift
//  ecash
//
//  Created by phong070 on 10/7/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ContactsViewModel  : Codable ,ContactsViewModelDeletegate{
    
    var checkShowView: Bool {
       return check
    }
    
    var firstCharacterView: String {
        return firstCharacter ?? ""
    }
    var nameView: String {
        return fullName ?? ""
    }
    
    var walletIdView: String {
        return walletId ?? ""
    }
    
    var phoneNumberView: String {
        return phoneNumber ?? ""
    }
    
    var groupId: Int {
        return createdDate?.toInt() ?? 0
    }
    
    var firstCharacter : String?
    var fullName : String?
    var walletId : String?
    var phoneNumber : String?
    var deviceInfo : String?
    var publicKeyValue : String?
    var createdDate : String?
    var check : Bool = false
   
    init(data : ContactsEntityModel, index : Int) {
        self.firstCharacter = data.fullName?.first?.description.uppercased()
        self.fullName = data.fullName
        self.walletId = data.walletId?.description
        self.phoneNumber = data.phone
        self.deviceInfo = data.mobileInfo
        self.publicKeyValue = data.publicKeyValue
        self.createdDate = (index + 1).description
    }
    
    init(data : WalletData, searchData : SearchByPhoneData) {
        self.fullName = "\(searchData.personFirstName ?? "") \(searchData.personMiddleName ?? "") \(searchData.personLastName ?? "")"
        self.walletId = data.walletId?.description
        self.phoneNumber = searchData.personMobilePhone
        self.deviceInfo = data.terminalInfo
        self.publicKeyValue = data.ecPublicKey
    }
    
    init(data : WalletInfoData , walletId : String) {
        self.walletId = walletId
        self.phoneNumber = data.personMobilePhone
        self.publicKeyValue = data.ecKpValue
        self.fullName = "\(data.personFirstName ?? "") \(data.personMiddleName ?? "") \(data.personLastName ?? "")"
        self.deviceInfo = data.deviceInfo ?? ""
    }
}
