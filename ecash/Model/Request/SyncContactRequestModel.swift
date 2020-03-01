//
//  SyncContactRequestModel.swift
//  ecash
//
//  Created by phong070 on 10/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SyncContactRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var listContacts : [String]?
    var phoneNumber : String?
    var sessionId : String?
    var token : String?
    var username : String?
    var walletId : String?
    var channelSignature : String?
  
    
    init() {
        guard let signInData = CommonService.getSignInData() else {
            return
        }
        
        guard let signUpData = CommonService.getSignUpStoreData() else {
            return
        }
        
        guard let mList = ContactHelper.instance.getRealContactPhoneNumber()else {
            return
        }
        
        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
        self.listContacts = mList
        
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.SYNC_CONTACT.rawValue
        self.phoneNumber = signUpData.personMobilePhone ?? ""
        self.sessionId = signInData.sessionId ?? ""
        self.token = signInData.token ?? ""
        self.username = signInData.username ?? ""
        self.walletId = CommonService.getWalletId() ?? ""
        
        let alphobelCode =  "\(auditNumber!)\(self.channelCode ?? "")\(self.functionCode ?? "")\(mList)\(self.phoneNumber ?? "")\(self.sessionId ?? "")\(self.token ?? "")\(self.username ?? "")\(self.walletId ?? "")".replace(target: "\"", withString: "")
        debugPrint(alphobelCode)
        self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
    init(data : [String]) {
          guard let signInData = CommonService.getSignInData() else {
              return
          }
          
          guard let signUpData = CommonService.getSignUpStoreData() else {
              return
          }
          
          self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
          self.listContacts = data
          
          self.channelCode = EnumChannelName.MB001.rawValue
          self.functionCode = EnumFunctionName.SYNC_CONTACT.rawValue
          self.phoneNumber = signUpData.personMobilePhone ?? ""
          self.sessionId = signInData.sessionId ?? ""
          self.token = signInData.token ?? ""
          self.username = signInData.username ?? ""
          self.walletId = CommonService.getWalletId() ?? ""
          
          let alphobelCode =  "\(auditNumber!)\(self.channelCode ?? "")\(self.functionCode ?? "")\(listContacts!)\(self.phoneNumber ?? "")\(self.sessionId ?? "")\(self.token ?? "")\(self.username ?? "")\(self.walletId ?? "")".replace(target: "\"", withString: "")
          debugPrint(alphobelCode)
          self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
      }

}
