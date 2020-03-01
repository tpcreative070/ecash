//
//  TransactionSuccessOptionsVC+Factory.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

extension TransactionSuccessOptionsVC {
    func initUI(){
        self.rootView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.popupView.setRadius(corner: 3,color: AppColors.WHITE_COLOR)
        self.imgIcon.image = UIImage(named: AppImages.IC_CHECK)
        
        let center = NSTextAlignment.center
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionSuccessful)
        self.lbTitle.textAlignment = center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE + 2)
        
        self.lbTitleAmount.text = LanguageHelper.getTranslationByKey(LanguageKey.YouHavePaid)
        self.lbTitleAmount.textAlignment = center
        
        self.lbAmount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbAmount.textAlignment = center
        
        self.lbTitleAccount.text = LanguageHelper.getTranslationByKey(LanguageKey.ForAccountECashWallet)
        self.lbTitleAccount.textAlignment = center
        
        self.lbAccount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbAccount.textAlignment = center
        
        self.btHome.addTarget(self, action: #selector(actionHome), for: UIControl.Event.touchUpInside)
        self.btHome.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.HomeScreen)?.uppercased(), for: .normal)
        self.btHome.setTitleColor(.white, for: .normal)
        self.btHome.cornerButton(corner: 5, color: AppColors.BLUE)
    }
    func bindingViewModel() {
        viewModel.amount.bind { value in self.lbAmount.text = value }
        viewModel.account.bind { value in self.lbAccount.text = value }
    }
}

extension TransactionSuccessOptionsVC: TransactionSuccessOptionsDelegate{
    func transactionSuccessOptionsResult(_ isSuccess: Bool?) {
        
    }
    
    
}
