//
//  PublicKeyOrganizeReleaseViewModel.swift
//  ecash
//
//  Created by phong070 on 9/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PublicKeyOrganizeReleaseViewModel: Codable {
    
    var channelCode : String?
    var functionCode : String?
    var issuerCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId : Int?
    var issuerKpValue : String?
    
    init(data : PublicKeyOrganizeReleaseData) {
        self.channelCode  = data.channelCode ?? ""
        self.functionCode  = data.functionCode ?? ""
        self.issuerCode  = data.issuerCode ?? ""
        self.sessionId  =  data.sessionId ?? ""
        self.terminalId  = data.terminalId ?? ""
        self.token = data.token ?? ""
        self.username  = data.username ?? ""
        self.channelSignature  = data.channelSignature ?? ""
        self.customerId  = data.customerId ?? 0
        self.functionId  = data.functionId ?? 0
        self.channelId  = data.channelId ?? 0
        self.issuerKpValue  = data.issuerKpValue ?? ""
    }
}
