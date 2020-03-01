//
//  Tab.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TabProfileVC {
    func initUI(){
        self.imgAvatar.image = UIImage(named: AppImages.IC_AVATAR)
        self.imgAvatar.contentMode =  .scaleAspectFill
        self.imgAvatar.borderColor = .clear
        self.lbeCashId.text = LanguageHelper.getTranslationByKey(LanguageKey.WalletNumber)
        self.lbeCashId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbeCashId.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeCashIdValue.text = "112323232"
        self.lbeCashIdValue.textAlignment = .right
        self.lbeCashIdValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbFullName.text = LanguageHelper.getTranslationByKey(LanguageKey.FullNameTitle)
        self.lbFullName.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbFullName.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbFullNameValue.text = "Nguyen Van A"
        self.lbFullNameValue.textAlignment = .right
        self.lbFullNameValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        
        self.lbMyQRCode.text = LanguageHelper.getTranslationByKey(LanguageKey.MyQRCode)
        self.lbMyQRCode.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbMyQRCode.textColor = AppColors.GRAY_LIGHT_TEXT
        
        
        self.lbChangePassword.text = LanguageHelper.getTranslationByKey(LanguageKey.ChangePassword)
        self.lbChangePassword.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbChangePassword.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbChangePasswordValue.text = "*******"
        self.lbChangePasswordValue.textAlignment = .right
        self.lbChangePasswordValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        
        self.lbIdNumber.text = LanguageHelper.getTranslationByKey(LanguageKey.IdNumber)
        self.lbIdNumber.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbIdNumber.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbIdNumberValue.text = "33121212123"
        self.lbIdNumberValue.textAlignment = .right
        self.lbIdNumberValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbLanguage.text = LanguageHelper.getTranslationByKey(LanguageKey.Language)
        self.lbLanguage.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbLanguage.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbLanguageValue.textAlignment = .right
        self.lbLanguageValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        
        self.lbPhone.text = LanguageHelper.getTranslationByKey(LanguageKey.PhoneNumber)
        self.lbPhone.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbPhone.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbPhoneValue.textAlignment = .right
        self.lbPhoneValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbMail.text = LanguageHelper.getTranslationByKey(LanguageKey.EmailPlaceHolder)
        self.lbMail.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbMail.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbMailValue.textAlignment = .right
        self.lbMailValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbAddress.text = LanguageHelper.getTranslationByKey(LanguageKey.Address)
        self.lbAddress.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbAddress.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbAddressValue.textAlignment = .right
        self.lbAddressValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbAvatar.text = LanguageHelper.getTranslationByKey(LanguageKey.MyAvatar)
        self.lbAvatar.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbAvatar.textColor = AppColors.GRAY_LIGHT_TEXT
        
        self.imgAvatar.isUserInteractionEnabled = true
        self.imgAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionEditAvatar(sender:))))
        self.viewChangePassword.isUserInteractionEnabled = true
        self.viewChangePassword.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionChangePassword(sender:))))
        self.viewChangeLanguage.isUserInteractionEnabled = true
        self.viewChangeLanguage.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionChangeLanguage(sender:))))
        self.viewMyQRCode.isUserInteractionEnabled = true
               self.viewMyQRCode.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionMyQRCode(sender:))))
        
        self.viewFullName.isUserInteractionEnabled = true
        self.viewFullName.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionFullname(sender:))))
        self.viewIdnumber.isUserInteractionEnabled = true
        self.viewIdnumber.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionIdNumber(sender:))))
        
        self.viewMail.isUserInteractionEnabled = true
        self.viewMail.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionMail(sender:))))
        
        self.viewAddress.isUserInteractionEnabled = true
        self.viewAddress.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionAddress(sender:))))
        setUpValue()
        bindViewModel()
    }
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        self.viewModel.fullNameBinding.bind { data in
            self.lbFullNameValue.text = data
        }
        self.viewModel.eCashIdBinding.bind { data in
            self.lbeCashIdValue.text = data
        }
        self.viewModel.idNumberBinding.bind { data in
            self.lbIdNumberValue.text = data
            debugPrint("CMT...")
        }
        self.viewModel.avatarBinding.bind { (value) in
            self.imgAvatar.image = value
        }
        self.viewModel.phoneBinding.bind { (value) in
            self.lbPhoneValue.text = value
        }
        self.viewModel.emailBinding.bind { (value) in
            self.lbMailValue.text = value
        }
        self.viewModel.addressBinding.bind { (value) in
            self.lbAddressValue.text = value
        }
        viewModel.doBindingDataToView(data: nil)
    }
    
    func setUpValue(){
        if let mData = CommonService.getMultipleLanguages(){
            if mData == LanguageCode.English{
                lbLanguageValue.text = LanguageHelper.getTranslationByKey(LanguageKey.English)
            }else{
                lbLanguageValue.text = LanguageHelper.getTranslationByKey(LanguageKey.Vietnamese)
            }
        }else{
            lbLanguageValue.text = LanguageHelper.getTranslationByKey(LanguageKey.English)
            CommonService.setMultipleLanguages(value: LanguageCode.English)
        }
    }
}

extension TabProfileVC : SingleButtonDialogPresenter {
    
}

