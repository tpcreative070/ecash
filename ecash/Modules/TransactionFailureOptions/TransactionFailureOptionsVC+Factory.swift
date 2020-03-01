//
//  TransactionFailureOptionsVC+Factory.swift
//  ecash
//
//  Created by ECAPP on 1/13/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

extension TransactionFailureOptionsVC{
    
    func initUI(){
        
        self.rootView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        self.popupView.setRadius(corner: 3,color: AppColors.WHITE_COLOR)
        
        self.imgIcon.image = UIImage(named: AppImages.IC_ERROR)
        
        let center = NSTextAlignment.center
        
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.CannotProcessPayment)
        self.lbTitle.textAlignment = center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE + 2)
        
        self.lbText1.text = LanguageHelper.getTranslationByKey(LanguageKey.CurrentWalletNotEnoughMoney)
        self.lbText1.textAlignment = center
        
        self.lbContent.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbContent.textAlignment = center
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.AmountEcashComfortable)
        
        self.lbText2.text = LanguageHelper.getTranslationByKey(LanguageKey.ToProcessTransaction)
        self.lbText2.textAlignment = center
        
        self.btClose.addTarget(self, action: #selector(actionClose), for: UIControl.Event.touchUpInside)
        self.btClose.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Close)?.uppercased(), for: .normal)
        self.btClose.setTitleColor(.white, for: .normal)
        self.btClose.cornerButton(corner: 5, color: AppColors.BLUE)
    }
    
    func bindingViewModel(){
        viewModel.content.bind { value in self.lbContent.text = value }
    }
    
}
