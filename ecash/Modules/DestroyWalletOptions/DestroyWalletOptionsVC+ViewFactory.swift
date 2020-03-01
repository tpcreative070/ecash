//
//  DestroyWalletOptionsVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension DestroyWalletOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewPupup.setCorner(corner: 3, color: .white)
        
        self.imgIcon.image = UIImage(named: AppImages.IC_ERROR)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.DestroyAccount)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.textAlignment = .center
        
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.DestroyContent)
        self.lbContent.textAlignment = .center
        self.lbContent.numberOfLines = 0
        self.lbContent.lineBreakMode = .byWordWrapping
        self.lbContent.textColor = AppColors.GRAY_LIGHT_TEXT
        
        btneCashToeCash.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.TransferToeCash)?.uppercased(), for: .normal)
        btneCashToeCash.addTarget(self, action: #selector(actioneCashToeCash), for: .touchUpInside)
        btneCashToeCash.setTitleColor(.white, for: .normal)
        btneCashToeCash.cornerButton(corner: 5, color: AppColors.BLUE)
        
        btnWithdraweCash.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.WithdraweCash)?.uppercased(), for: .normal)
        btnWithdraweCash.addTarget(self, action: #selector(actionWithdraweCash), for: .touchUpInside)
        btnWithdraweCash.setTitleColor(.white, for: .normal)
        btnWithdraweCash.cornerButton(corner: 5, color: AppColors.BLUE)
        
        
        btnExit.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Exit)?.uppercased(), for: .normal)
        btnExit.addTarget(self, action: #selector(actionExit), for: .touchUpInside)
        btnExit.setTitleColor(AppColors.BLUE, for: .normal)
        btnExit.setRadius(corner: 3, color: AppColors.BLUE)
        
    }
    
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        self.viewModel.contentBinding.bind { (value) in
            self.log(message: value)
            let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.DestroyContent) ?? "", arguments: [value])
            let valueAttribute = message.toColorAttribute(value: value,color: AppColors.BLACK_COLOR)
            debugPrint(valueAttribute)
            self.lbContent.attributedText = valueAttribute
        }
        self.viewModel.doGetIntent()
    }
}

extension DestroyWalletOptionsVC : SingleButtonDialogPresenter {
    
}
