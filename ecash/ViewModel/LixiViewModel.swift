//
//  Lixi.swift
//  ecash
//
//  Created by phong070 on 12/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class LixiViewModel : LixiViewModelDelegate , Codable{
    
    var createdDateView: String {
        let mDate = TimeHelper.getTime(timeString:createdDate ?? "01012020 01:01:01", dateFormat: TimeHelper.FormatSendEnc)
        return mDate?.toString(withFormat: TimeHelper.StandardTransaction) ?? ""
    }
    
    var colorTitleView: UIColor {
        if let mStatus = status {
            if mStatus {
                return AppColors.GRAY_LIGHT_TEXT
            }else{
                return AppColors.BLACK_COLOR
            }
        }
        return AppColors.BLACK_COLOR
    }
    
    var colorDetailView: UIColor {
        if let mStatus = status {
            if mStatus {
                return AppColors.RED_COLOR
            }else{
                return AppColors.BLUE
            }
        }
        return AppColors.BLUE
    }
    
    var imgStatusName: String {
        if let mStatus = status {
            if mStatus {
                return AppImages.IC_LIXI_OPEN
            }else{
                return AppImages.IC_LIXI_CLOSE
            }
        }
       return ""
    }
    
    var isShowGift: Bool {
        if let mStatus = status {
            if mStatus {
                return false
            }else{
                return true
            }
        }
        return false
    }
    
    var titleView: String {
        if fullName != ""{
            return "\(LanguageHelper.getTranslationByKey(LanguageKey.LuckyMoneyFrom) ?? "") \(fullName ?? "")"
        }else{
            if walletIdSender == "0"{
                return "\(LanguageHelper.getTranslationByKey(LanguageKey.LuarNewYearFromECPAY) ?? "")"
            }else{
                return "\(LanguageHelper.getTranslationByKey(LanguageKey.LuckyMoneyFrom) ?? "") \(walletIdSender ?? "")"
            }
        }
    }
    
    var detailView: String {
         if let mStatus = status {
            if mStatus {
                return LanguageHelper.getTranslationByKey(LanguageKey.Opened) ?? "Opened"
            }else{
                return LanguageHelper.getTranslationByKey(LanguageKey.Lock) ?? "Lock"
            }
        }
        return ""
    }
    
    var title : String?
    var status : Bool?
    var fullName : String?
    var walletIdSender : String?
    var id : Int?
    var content : String?
    var createdDate : String?
    var noted : String?
    init(data : CashTempEntityModel) {
        self.status = data.status
        self.fullName = data.fullName
        self.walletIdSender = data.senderAccountId?.description
        self.id = Int(data.id ?? 0)
        self.content = data.content
        self.createdDate = data.receiveDate
        let mObject = content?.toObject(value: TransferDataModel.self)
        self.noted = mObject?.content ?? ""
        debugPrint("Fullname: \(self.fullName ?? "")")
        debugPrint("WalletId: \(self.walletIdSender ?? "")")
    }
}
