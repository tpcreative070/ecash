//
//  MyQRCodeVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension MyQRCodeVC {
    func initUI(){
        self.lbTitle.textAlignment = .center
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.MyQRCode)?.uppercased()
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLUE
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        self.lbFullname.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 2)
        self.lbFullname.textAlignment = .center
        self.lbPhonenumber.textAlignment = .center
        
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.ScanQRCodeLetToEWallet)
        self.lbContent.textAlignment = .center
        
        self.lbSaved.text = LanguageHelper.getTranslationByKey(LanguageKey.SaveToDevice)
        self.lbSaved.textColor = AppColors.BLUE
        
        self.imgSaved.image = UIImage(named: AppImages.IC_DOWNLOAD)
        
        self.imgAvatar.image = UIImage(named: AppImages.IC_AVATAR)
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.borderColor = .clear
        self.viewSaved.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionSaved(sender:))))
    }
    
    func bindingViewModel() {
        viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATED_UI.rawValue{
                
            }
        }
        
        self.viewModel.fullNameBinding.bind { (value) in
            self.lbFullname.text = value
        }
        self.viewModel.phoneNumberBinding.bind { (value) in
            self.lbPhonenumber.text = value
        }
        self.viewModel.codeBinding.bind { (value) in
            self.imgCode.image = value
        }
        self.viewModel.avatarBinding.bind { (value) in
            self.imgAvatar.image = value
        }
        self.viewModel.doSetValue()
    }
    
}
