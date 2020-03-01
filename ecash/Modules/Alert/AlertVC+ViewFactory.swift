//
//  AlertVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 9/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension AlertVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.textAlignment = .center
        
        self.lbMessage.text = LanguageHelper.getTranslationByKey(LanguageKey.IdNumber)
        self.lbMessage.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.lbMessage.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbMessage.textAlignment = .center
        self.lbMessage.lineBreakMode = .byWordWrapping
        self.lbMessage.numberOfLines = 0
        
       
        self.btnClose.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        self.btnClose.setTitleColor(.white, for: .normal)
        self.btnClose.cornerButton(corner: 3, color: AppColors.BLUE)
        self.viewRoot.setRadius(corner: 3, color: .white)
        
        self.btnContinue.addTarget(self, action: #selector(actionContinue), for: .touchUpInside)
        self.btnContinue.setTitleColor(.white, for: .normal)
        self.btnContinue.cornerButton(corner: 3, color: AppColors.BLUE)
        self.btnContinue.isHidden = true
        data = ShareSignUpSingleton.shared.get(value: PassDataViewModel.self)
        guard let mData = data else {
            return
        }
        
        if mData.identifier == EnumPassdata.ALERT.rawValue {
            let alert = mData.alert
            if alert.codeAction == EnumResponseAction.CREATED_SUCCESSFULLY.rawValue {
                  self.imgError.image = UIImage(named: AppImages.IC_SUCCESS)
                  self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.Success)
                  self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close), for: .normal)
            }
            else if alert.codeAction == EnumResponseAction.EXISTING_USERNAME.rawValue {
                self.imgError.image = UIImage(named: AppImages.IC_ERROR)
                self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.AlreadyExisted)
                self.lbMessage.text = LanguageHelper.getTranslationByKey(LanguageKey.DoYouWantToSignIn)
                self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Yes), for: .normal)
                self.btnContinue.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.No), for: .normal)
                self.btnContinue.isHidden = false
                return
            }
            else{
                  self.imgError.image = UIImage(named: AppImages.IC_ERROR)
                  self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ErrorOcurred)
                  self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close), for: .normal)
            }
            let messageValue  = "\(alert.name ?? "") \(alert.nameValue ?? "") \(alert.message ?? "")"
            self.lbMessage.attributedText = messageValue.toColorAttribute(value: alert.nameValue ?? "", color: AppColors.BLACK_COLOR)
            log(object: mData.alert)
        }
        else if mData.identifier == EnumPassdata.ECASH_TO_EDONG.rawValue{
            self.imgError.image = UIImage(named: AppImages.IC_SUCCESS)
            self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionSuccessful)
            self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close), for: .normal)
            
            let eCashToeDong = mData.eCashToeDong
            let moneyValue = eCashToeDong.total?.toMoney() ?? "0".toMoney()
            let eDongValue = eCashToeDong.eDong ?? "0"
            let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.YouHaveWithdrawnFromeDong) ?? "", arguments: [moneyValue,eDongValue])
            let valueAttribute = message.toColorAttribute(value: moneyValue, value2: eDongValue,color: AppColors.BLACK_COLOR)
            self.lbMessage.attributedText = valueAttribute
            self.btnContinue.isHidden = false
            self.btnContinue.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Continue), for: .normal)
        }
        else if mData.identifier == EnumPassdata.EDONG_TO_ECASH.rawValue{
            self.imgError.image = UIImage(named: AppImages.IC_SUCCESS)
            self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionSuccessful)
            self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close), for: .normal)
            let eCashToeDong = mData.eDongToeCash
            let moneyValue = eCashToeDong.total?.toMoney() ?? "0".toMoney()
            let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.YouHaveAddedToeCash) ?? "", arguments: [moneyValue])
            let valueAttribute = message.toColorAttribute(value: moneyValue,color: AppColors.BLACK_COLOR)
            self.lbMessage.attributedText = valueAttribute
            self.btnContinue.isHidden = false
            self.btnContinue.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Continue), for: .normal)
        }
        else if mData.identifier == EnumPassdata.ECASH_TO_ECASH.rawValue{
            self.imgError.image = UIImage(named: AppImages.IC_SUCCESS)
            self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionSuccessful)
            self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close), for: .normal)
            let eCashToeCash = mData.eCashtoeCash
            let eCashValue = eCashToeCash.eCash ?? ""
            let moneyValue = eCashToeCash.total?.toMoney() ?? "0".toMoney()
            let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.YouHaveTransferredToeCash) ?? "", arguments: [moneyValue,eCashValue])
            let valueAttribute = message.toColorAttribute(value: moneyValue,value2: eCashValue,color: AppColors.BLACK_COLOR)
            self.lbMessage.attributedText = valueAttribute
            self.btnContinue.isHidden = false
            self.btnContinue.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Continue), for: .normal)
        }
        else if mData.identifier == EnumPassdata.EXCHANGE_CASH.rawValue {
            self.imgError.image = UIImage(named: AppImages.IC_SUCCESS)
            self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionSuccessful)
            self.btnClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close), for: .normal)
            let message   = LanguageHelper.getTranslationByKey(LanguageKey.YouHaveExchangedCash)
            self.lbMessage.text = message
            self.btnContinue.isHidden = false
            self.btnContinue.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Continue), for: .normal)
        }
       
    }
    
}
