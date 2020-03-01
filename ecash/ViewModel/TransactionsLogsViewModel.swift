//
//  TransactionHistoryViewModel.swift
//  ecash
//
//  Created by Tuan Le Anh on 10/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransactionsLogsViewModel  : Codable ,TransactionsLogsViewModelDeletegate{
    
    var sortId: Int64 {
        let value = TimeHelper.getTime(timeString: transactionDateTime ?? "0", dateFormat: TimeHelper.StandardFormatTime)
        return value?.toMillis() ?? 0
    }
    
    var transactionIconView: String{
        var icon = ""
        if transactionType == EnumTransferType.ECASH_TO_ECASH.rawValue{
            if receiverId != CommonService.getWalletId() {
                icon =  "-"
            }else{
                icon = "+"
            }
        }
        else if transactionType == EnumTransferType.LIXI.rawValue {
            if receiverId != CommonService.getWalletId() {
                icon =  "-"
            }else{
                icon = "+"
            }
        }
        else if transactionType == EnumTransferType.EDONG_TO_ECASH.rawValue {
            icon = "+"
        }
        else if transactionType == EnumTransferType.ECASH_TO_EDONG.rawValue {
            icon = "-"
        }
        else if transactionType == EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue {
            if receiverId != CommonService.getWalletId() {
                icon =  "-"
            }else{
                icon = "+"
            }
        }
        self.transactionIcon = icon
        return icon
    }
    
    var fullNameView: String {
        return senderName ?? ""
    }
    
    var walletIdView: String {
        return receiverId ?? ""
    }
    
    var transactionTypeView: String {
        return transactionType ?? ""
    }
    
    var transactionStatusView: String {
        return transactionStatus ?? ""
    }
    
    var transactionAmountView: String {
        return transactionAmount ?? ""
    }
    
    var transactionDateView: String {
        return transactionDate ?? ""
    }
    
    var transactionDateTimeView: String {
        return TimeHelper.getString(time : TimeHelper.getTime(timeString: transactionDateTime ?? "0", dateFormat: TimeHelper.StandardFormatTime) ?? Date() , dateFormat: TimeHelper.StandardTransaction)
    }
    
    var receiverName : String?
    var senderName : String?
    var receiverPhone : String?
    var senderPhone : String?
    var receiverId : String?
    var senderId : String?
    var transactionType : String?
    var transactionStatus : String?
    var transactionAmount : String?
    var transactionDate : String?
    var transactionDateTime : String?
    var transactionId : String?
    var transactionIcon : String?
    
    init(transactionType : String,
         receiverId : String,
         senderId : String,
         transactionAmount : String,
         transactionStatus : String,
         transactionDate : String) {
        self.transactionType = transactionType
        self.receiverId = receiverId
        self.senderId = senderId
        self.transactionAmount = transactionAmount
        self.transactionStatus = transactionStatus
        self.transactionDate = transactionDate
    }
    
    init(data : TransactionHistoyEntityModel) {
        self.receiverId = data.receiverId
        self.senderId = data.senderId
        self.transactionType = data.transactionType
        self.transactionAmount = data.transactionAmount
        self.transactionStatus = data.transactionStatus
        self.transactionDate = data.transactionDate
        self.transactionDateTime = data.transactionDateTime
        self.transactionId = data.transactionId
        self.receiverName = data.receiverName
        self.senderName = data.senderName
        self.receiverPhone = data.receiverPhone
        self.senderPhone = data.senderPhone
        
        if transactionType != EnumTransferType.ECASH_TO_ECASH.rawValue {
            if transactionType == EnumTransferType.LIXI.rawValue {
                if senderId == CommonService.getWalletId() {
                    self.senderName = receiverName
                }
            }else{
                if let mSignUpData = CommonService.getSignUpStoreData(){
                    self.senderPhone = mSignUpData.personMobilePhone
                    self.senderName = "\(mSignUpData.personFirstName ?? "") \(mSignUpData.personMiddleName ?? "") \(mSignUpData.personLastName ?? "")"
                }
            }
        }else{
             if receiverId != CommonService.getWalletId() {
                self.senderName = data.receiverName
             }
        }
    }
}
