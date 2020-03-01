//
//  NotificationHistoryViewModelList.swift
//  ecash
//
//  Created by phong070 on 11/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class NotificationHistoryViewModelList  : NotificationHistoryViewModelListDelegate {
    
    var currentCell: NotificationHistoryViewModel?
    var listNotificationHistory: [NotificationHistoryViewModel] = [NotificationHistoryViewModel]()
    var responseToView: ((String) -> ())?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    func getNotificationList(){
        if let mData = SQLHelper.getNotificationHistoryList() {
            self.listNotificationHistory = mData.map { (value) -> NotificationHistoryViewModel in
                return NotificationHistoryViewModel(data: value)
            }
            self.listNotificationHistory = self.listNotificationHistory.sorted {$0.groupIdView > $1.groupIdView}
            responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
            for index in self.listNotificationHistory {
                SQLHelper.updateNotificationHistory(index: Int64(index.groupId ?? 0))
            }
        }
    }
}
