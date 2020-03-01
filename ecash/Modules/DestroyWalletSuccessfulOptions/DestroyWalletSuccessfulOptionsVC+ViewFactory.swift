//
//  DestroyWalletSuccessfulOptionsVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension DestroyWalletSuccessfulOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewPupup.setCorner(corner: 3, color: .white)
        
        self.imgIcon.image = UIImage(named: AppImages.IC_CHECK)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.DestroyAccountSuccessfully)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.lbTitle.textAlignment = .center
        self.lbTitle.numberOfLines = 0
        self.lbTitle.lineBreakMode = .byWordWrapping
        
        if let mData = CommonService.getShareUpdatedForgotPasswordCompleted() {
            self.lbTitle.text = mData.title
        }
        
        btnDone.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Done)?.uppercased(), for: .normal)
        btnDone.addTarget(self, action: #selector(actionDone), for: .touchUpInside)
        btnDone.setTitleColor(.white, for: .normal)
        btnDone.cornerButton(corner: 5, color: AppColors.BLUE)
    }
}
