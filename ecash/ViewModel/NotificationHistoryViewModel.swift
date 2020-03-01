//
//  NotificationHistoryViewModel.swift
//  ecash
//
//  Created by phong070 on 11/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class NotificationHistoryViewModel : Codable, NotificationHistoryViewModelDelegate {
    
    var groupIdView: Int {
        return groupId ?? 0
    }
    
    var titleView: String{
        return title ?? ""
    }
    
    var messageView: String{
        return message ?? ""
    }
    
    var createdDateView: String{
        return createdDate ?? ""
    }
    
    var title : String?
    var message : String?
    var createdDate : String?
    var groupId : Int?
    
    init(data : NotificationHistoryEntityModel){
        self.title = data.title
        self.message = data.message
        self.createdDate = data.createdDate
        self.groupId = Int(data.id ?? 0)
    }
    init() {
        
    }
}
