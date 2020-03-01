//
//  AddContactModel.swift
//  ecash
//
//  Created by phong070 on 2/11/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class AddContactRequestModel : Codable {
    var addNewWalletId : String?
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var listWallets : [String]?
    var sessionId : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
     
    init(data : [String]) {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.listWallets = data
        self.addNewWalletId = data[0]
             
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.AddContact.rawValue
        self.sessionId = signInData.sessionId ?? ""
        self.token = signInData.token ?? ""
        self.username = signInData.username ?? ""
        self.walletId = CommonService.getWalletId() ?? ""
             
        let alphobelCode =  "\(addNewWalletId!)\(self.auditNumber!)\(self.channelCode ?? "")\(self.functionCode ?? "")\(listWallets!)\(self.sessionId ?? "")\(self.token ?? "")\(self.username ?? "")\(self.walletId ?? "")".replace(target: "\"", withString: "")
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }

}
