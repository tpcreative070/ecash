//
//  PushNotificationViewModel.swift
//  ecash
//
//  Created by phong070 on 11/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class PushNotificationViewModel : Codable {
    var title : String?
    var body : String?
    init(data : PushNotificationResponseModel) {
        self.title = data.title
        self.body = data.body
    }
}
