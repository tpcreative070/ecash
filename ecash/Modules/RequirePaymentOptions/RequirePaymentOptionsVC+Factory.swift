//
//  RequirePaymentOptionsVC+Factory.swift
//  ecash
//
//  Created by ECAPP on 1/13/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

extension RequirePaymentOptionsVC {
    func initUI(){
        let center = NSTextAlignment.center
        self.rootView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.popupView.setRadius(corner: 3,color: AppColors.WHITE_COLOR)
        self.imgIcon.image = UIImage(named: AppImages.IC_PAYMENT)
        
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.PaymentRequest)
        self.lbTitle.textAlignment = center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE + 2)
        
        self.lbTitleAccountECash.text = LanguageHelper.getTranslationByKey(LanguageKey.AccountECashWallet)
        self.lbTitleAccountECash.textAlignment = center
        
        self.lbTitleRequire.text = LanguageHelper.getTranslationByKey(LanguageKey.RequireYourPayment)?.lowercased()
        self.lbTitleRequire.textAlignment = center
        
        self.lbTitleWith.text = LanguageHelper.getTranslationByKey(LanguageKey.WithContentPaymentAs)?.lowercased()
        self.lbTitleWith.textAlignment = center
        
        self.lbTitleName.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbTitleName.textAlignment = center
        
        self.lbTitleAmount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbTitleAmount.textAlignment = center
        
        self.lbTitleContent.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbTitleContent.textAlignment = center
        
        self.btConfirm.addTarget(self, action: #selector(actionConfirm), for: UIControl.Event.touchUpInside)
        self.btConfirm.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Payment)?.uppercased(), for: .normal)
        self.btConfirm.setTitleColor(.white, for: .normal)
        self.btConfirm.cornerButton(corner: 5, color: AppColors.BLUE)
        
    }
    
    func bindingViewModel() {
        self.viewModel.customerNameBinding.bind { value in self.lbTitleName.text = value }
        self.viewModel.amountBinding.bind { value in self.lbTitleAmount.text = value }
        self.viewModel.contentBinding.bind { value in
            if (value != "nil") {
                self.lbTitleContent.text = value
            } else {
                self.lbTitleContent.text = ""
            }
        }
        viewModel.doBindingUpdate()
    }
}


