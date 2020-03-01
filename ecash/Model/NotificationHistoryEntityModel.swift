//
//  NotificationHistoryEntityModel.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class NotificationHistoryEntityModel : Codable {
    var id : Int64?
    var title: String?
    var message : String?
    var createdDate : String?
    var isView : Bool?
    init(id : Int64,title : String, message : String, createdDate : String,isView : Bool) {
        self.id = id
        self.title = title
        self.message = message
        self.createdDate = createdDate
        self.isView = isView
    }
    
    init(data : PushNotificationViewModel) {
        self.title = data.title
        self.message = data.body
        self.createdDate = TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardTransaction)
        self.isView = false
    }
}
