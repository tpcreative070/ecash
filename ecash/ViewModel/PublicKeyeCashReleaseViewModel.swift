//
//  PublicKeyeCashReleaseViewModel.swift
//  ecash
//
//  Created by phong070 on 9/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PublicKeyeCashReleaseViewModel : Codable {
    var channelCode : String?
    var decisionCode : String?
    var functionCode : String?
    var sessionId : String?
    var terminalId : String?
    var token : String?
    var username : String?
    var channelSignature : String?
    var customerId : Int?
    var functionId : Int?
    var channelId  : Int?
    var decisionAcckp : String?
    var decisionTrekp : String?
    init(data : PublicKeyeCashReleaseData) {
        self.channelCode = data.channelCode
        self.decisionCode = data.decisionCode
        self.functionCode = data.functionCode
        self.sessionId = data.sessionId
        self.terminalId = data.terminalId
        self.token = data.token
        self.username = data.username
        self.channelSignature = data.channelSignature
        self.customerId = data.customerId
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.decisionAcckp = data.decisionAcckp
        self.decisionTrekp = data.decisionTrekp
    }
    
    init(data : DecisionsDiaryEntityModel) {
        self.decisionCode = data.decisionNo
        self.decisionAcckp = data.accountPublicKeyValue
        self.decisionTrekp = data.treasurePublicKeyValue
    }
    
}
