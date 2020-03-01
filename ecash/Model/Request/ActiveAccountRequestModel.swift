//
//  ActiveAccountRequestModel.swift
//  ecash
//
//  Created by phong070 on 9/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ActiveAccountRequestModel : Codable {
    var accountIdt : String?
    var auditNumber : String?
    var channelCode : String?
    var customerId : String?
    var functionCode : String?
    var idNumber : String?
    var userId : String?
    var channelSignature : String?
    var otpvalue : String?
    var transactionCode : String?
    var walletId : String?
    
    init(otpValue : String,transactionCode : String? = nil) {
        guard let mSignUpData = CommonService.getSignUpStoreData() else{
            return
        }
        
        self.accountIdt = mSignUpData.accountIdt ?? ""
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.channelCode = EnumChannelName.MB001.rawValue
        self.customerId = mSignUpData.customerId ?? ""
        self.functionCode = EnumFunctionName.ACTIVE_ACCOUNT.rawValue
        self.idNumber = mSignUpData.idNumber ?? ""
        self.otpvalue = otpValue
        
        self.transactionCode = mSignUpData.transactionCode ?? ""
        if let mTransactionCode = transactionCode {
              self.transactionCode = mTransactionCode
        }
        
        self.userId = mSignUpData.userId ?? ""
        self.walletId = mSignUpData.walletId ?? ""
        let alphobelCode =  "\(accountIdt!)\(auditNumber!)\(channelCode!)\(customerId!)\(functionCode!)\(idNumber!)\(otpvalue!)\(self.transactionCode!)\(userId!)\(walletId!)"
        debugPrint(alphobelCode)
        self.channelSignature = ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    init() {
        
    }
}
