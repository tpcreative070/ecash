//
//  ContactsEntityModel.swift
//  ecash
//
//  Created by phong070 on 9/18/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI

struct ContactsEntityModel : Codable  {
    var walletId : Int64?
    var phone : String?
    var publicKeyValue : String?
    var fullName : String?
    var email : String?
    var address : String?
    var mobileInfo : String?
    var status : Int?
    var created : Int64?
    var modified : Int64?
    var destroyed : Int64?
    
    init(walletId : Int64,
         phone : String,
         publicKeyValue : String,
         fullName : String,
         email : String,
         address : String,
         mobileInfo : String,
         status : Int,
         created : Int64,
         modified : Int64,
         destroyed : Int64) {
        self.walletId = walletId
        self.phone = phone
        self.publicKeyValue = publicKeyValue
        self.fullName = fullName
        self.email = email
        self.address = address
        self.mobileInfo = mobileInfo
        self.status = status
        self.created = created
        self.modified = modified
        self.destroyed = destroyed
    }
    
    init(contact :CNContact,phoneNumber : String) {
        self.phone = phoneNumber.replace(target: "-", withString: "").replace(target: " ", withString: "").replace(target: "(", withString: "").replace(target: ")", withString: "")
        self.fullName = contact.givenName
    }
    
    init(data : TransferDataSyncContactData, fullName : String) {
        let time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)
        self.walletId = Int64(data.walletId ?? 0)
        self.phone = data.personMobilePhone
        self.publicKeyValue = data.ecPublicKey
        self.fullName = fullName
        self.email = ""
        self.address = ""
        self.mobileInfo = data.terminalInfo
        self.status = true.intValue
        self.created = Int64(time)
        self.modified = Int64(time)
        self.destroyed = Int64(time)
    }
    
    init(data : WalletInfoData,walletId : String) {
        let time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)
        self.walletId = Int64(walletId)
        self.phone = data.personMobilePhone
        self.publicKeyValue = data.ecKpValue
        self.fullName = "\(data.personFirstName ?? "") \(data.personMiddleName ?? "") \(data.personLastName ?? "")"
        self.email = ""
        self.address = ""
        self.mobileInfo = data.deviceInfo ?? ""
        self.status = true.intValue
        self.created = Int64(time)
        self.modified = Int64(time)
        self.destroyed = Int64(time)
    }
    
    init(data: MyQRcodeModel)
    {
        let time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)
        self.walletId = data.walletId
        self.phone = data.personMobiPhone
        self.publicKeyValue = data.publicKey
        self.fullName = data.fullname
        self.email = ""
        self.address = ""
        self.mobileInfo = data.terminalInfo
        self.status = true.intValue
        self.created = Int64(time)
        self.modified = Int64(time)
        self.destroyed = Int64(time)
    }

    
    init(data : ContactsViewModel) {
        let time = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)
        self.walletId = Int64(data.walletId ?? "0")
        self.phone = data.phoneNumber ?? ""
        self.mobileInfo = data.deviceInfo ?? ""
        self.publicKeyValue = data.publicKeyValue
        self.fullName = data.fullName ?? ""
        self.email = ""
        self.address = ""
        self.status = true.intValue
        self.created = Int64(time)
        self.modified = Int64(time)
        self.destroyed = Int64(time)
    }
    
    init() {
    }
}
