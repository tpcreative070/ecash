//
//  MyQRCodeModel.swift
//  ecash
//
//  Created by phong070 on 12/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class MyQRcodeModel : Codable {
    var fullname : String?
    var personMobiPhone : String?
    var publicKey : String?
    var terminalInfo : String?
    var walletId : Int64?
    
    init() {
        guard let mSignUpData = CommonService.getSignUpStoreData() else {
            return
        }
        self.fullname = "\(mSignUpData.personFirstName ?? "") \(mSignUpData.personMiddleName ?? "") \(mSignUpData.personLastName ?? "")"
        self.personMobiPhone = mSignUpData.personMobilePhone ?? ""
        self.publicKey = CommonService.getPublicKey()
        self.terminalInfo = DeviceHelper.getDeviceInfo()
        self.walletId  = Int64(mSignUpData.walletId ?? "0")
    }
    
}
