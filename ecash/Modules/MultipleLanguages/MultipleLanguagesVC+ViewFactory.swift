//
//  MultipleLanguagesVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/12/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension MultipleLanguagesVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.imgIcon.image = UIImage(named: AppImages.IC_LANGUAGE)
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.ChooseYourLanguage)
        self.lbContent.lineBreakMode = .byWordWrapping
        self.lbContent.numberOfLines = 0
        self.lbContent.textAlignment = .center
        self.viewPupup.setCorner(corner: 3, color: .white)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.Language)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.textAlignment = .center
        
        
        btnEnglish.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.English), for: .normal)
        btnEnglish.addTarget(self, action: #selector(actionEnglish), for: .touchUpInside)
        
        btnVietnamese.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Vietnamese), for: .normal)
        btnVietnamese.addTarget(self, action: #selector(actionVietnamese), for: .touchUpInside)
        doUpdatedUI()
    }
    
    func doUpdatedUI(){
        if let mData = CommonService.getMultipleLanguages(){
            if mData == LanguageCode.English{
                btnEnglish.setTitleColor(.white, for: .normal)
                btnEnglish.setCorner(corner: 3, color: AppColors.BLUE)
                
                btnVietnamese.setTitleColor(AppColors.GRAY_LIGHT_TEXT, for: .normal)
                btnVietnamese.setRadius(corner: 3, color: AppColors.GRAY_LIGHT_TEXT)
            }else{
                btnVietnamese.setTitleColor(.white, for: .normal)
                btnVietnamese.setCorner(corner: 3, color: AppColors.BLUE)
                              
                btnEnglish.setTitleColor(AppColors.GRAY_LIGHT_TEXT, for: .normal)
                btnEnglish.setRadius(corner: 3, color: AppColors.GRAY_LIGHT_TEXT)
            }
        }
    }
}
