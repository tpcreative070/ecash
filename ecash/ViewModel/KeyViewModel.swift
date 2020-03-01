//
//  PushNotificationViewModel.swift
//  ecash
//
//  Created by phong070 on 9/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class KeyViewModel  : Codable {
    var type:String?
    var channelKp : String?
    var clientKp : String?
    var clientKs : String?
    init(data : KeyResponseModel) {
        self.type = data.type
        self.channelKp = data.channelKp
        self.clientKp = data.clientKp
        self.clientKs = data.clientKs
        CommonService.setKeychainFirebaseData(storeInfo: KeychainFirebaseStoreModel(data: self))
        CommonService.setChannelPublicKey(data: self.channelKp ?? "")
        Utils.logMessage(message: "channel public key \(data.self.clientKs ?? "")")
    }
}

enum EnumType : String {
    case ECASH_KEYS_INITIAL = "ECASH_KEYS_INITIAL"
}
