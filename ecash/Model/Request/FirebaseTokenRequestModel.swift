//
//  FirebaseTokenRequestModel.swift
//  ecash
//
//  Created by phong070 on 11/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class FirebaseTokenRequestModel : Codable {
    var app_name : String
    var channel_code : String
    var created_date : String
    var status : String
    var terminal_info : String
    var token : String
    init() {
        self.app_name = ConfigKey.AppName.infoForKey() ?? ""
        self.channel_code = EnumChannelName.MB001.rawValue
        self.created_date = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardFormatTime)
        self.status = "0"
        self.terminal_info = DeviceHelper.getDeviceInfo()
        self.token = CommonService.getFirebaseToken() ?? ""
    }
}
