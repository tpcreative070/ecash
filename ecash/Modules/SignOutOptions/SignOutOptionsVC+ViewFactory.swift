//
//  SignOutOptionsVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension SignOutOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewPupup.setCorner(corner: 3, color: .white)
        
        self.imgIcon.image = UIImage(named: AppImages.IC_SIGN_OUT_RED)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.SignOut)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.textAlignment = .center
        
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.DoYouWantExitThisSession)
        self.lbContent.textAlignment = .center
        self.lbContent.numberOfLines = 0
        self.lbContent.lineBreakMode = .byWordWrapping
    
        btnYes.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Yes), for: .normal)
        btnYes.addTarget(self, action: #selector(actionYes), for: .touchUpInside)
        btnYes.setTitleColor(.white, for: .normal)
        btnYes.cornerButton(corner: 5, color: AppColors.BLUE)
        
        btnNo.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.No), for: .normal)
        btnNo.addTarget(self, action: #selector(actionNo), for: .touchUpInside)
        btnNo.setTitleColor(AppColors.BLUE, for: .normal)
        btnNo.setRadius(corner: 3, color: AppColors.BLUE)
    }
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
       
        self.viewModel.responseToView =  {[weak self] data in
            if data == EnumResponseToView.SIGN_OUT_SUCCESS.rawValue {
                CommonService.signOutGlobal()
                WebSocketClientHelper.instance.socket.disconnect()
                Navigator.pushViewMainStoryboard(from: self!,identifier : Controller.signin,isNavigation: false,present : true)
                self?.dismiss()
            }
        }
    }
    
}

extension SignOutOptionsVC : SingleButtonDialogPresenter {
    
}
