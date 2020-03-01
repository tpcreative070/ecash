//
//  DecisionsDiaryEntityModel.swift
//  ecash
//
//  Created by phong070 on 9/21/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct DecisionsDiaryEntityModel : Codable  {
    var decisionNo :  String?
    var accountPublicKeyAlias : String?
    var accountPublicKeyValue  : String?
    var treasurePublicKeyAlias : String?
    var treasurePublicKeyValue : String?
    var systemDate  : Int64?
    
    init(decisionNo : String, accountPublicKeyValue  : String,  treasurePublicKeyValue : String ) {
        self.decisionNo = decisionNo
        self.accountPublicKeyAlias = "accountPublicKeyAlias"
        self.accountPublicKeyValue = accountPublicKeyValue
        self.treasurePublicKeyAlias = "treasurePublicKeyAlias"
        self.treasurePublicKeyValue = treasurePublicKeyValue
        self.systemDate = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatSendEnc).toInt64()
    }
    
    init( decisionNo :  String,
          accountPublicKeyAlias : String,
          accountPublicKeyValue  : String,
          treasurePublicKeyAlias : String,
          treasurePublicKeyValue : String,
          systemDate  : Int64) {
        self.decisionNo = decisionNo
        self.accountPublicKeyAlias = accountPublicKeyAlias
        self.accountPublicKeyValue = accountPublicKeyValue
        self.treasurePublicKeyAlias = treasurePublicKeyAlias
        self.treasurePublicKeyValue = treasurePublicKeyValue
        self.systemDate = systemDate
    }
    
    init(data : PublicKeyeCashReleaseData,decisionNo : String) {
        self.decisionNo = decisionNo
        self.accountPublicKeyAlias = "accountPublicKeyAlias"
        self.accountPublicKeyValue = data.decisionAcckp ?? ""
        self.treasurePublicKeyAlias = "treasurePublicKeyAlias"
        self.treasurePublicKeyValue = data.decisionTrekp ?? ""
        self.systemDate = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatSendEnc).toInt64()
    }
    
}
