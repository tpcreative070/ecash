//
//  MyWalletVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension MyWalletVC {
    
    func initUI(){
       self.imgScanner.isUserInteractionEnabled = true
       self.imgScanner.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionScanner(sender:))))
       options.tabView.style = .segmented
       options.tabView.itemView.selectedTextColor = AppColors.BLUE
       options.tabView.itemView.textColor = AppColors.GRAY
       options.tabView.additionView.backgroundColor = AppColors.BLUE
       swipeMenuView.reloadData(options: options)
       self.navigationController?.isNavigationBarHidden = true
       self.imgScanner.image = UIImage(named: AppImages.IC_QRCODE)
       self.imgLogo.image = UIImage(named: AppImages.IC_LOGO)
    }
    
    func addedView(){
        myWallet = mainStoryBoard.instantiateViewController(withIdentifier: Controller.tabWallet) as? TabWalletVC
        myWallet?.title = LanguageHelper.getTranslationByKey(LanguageKey.MyWallet) ?? "My Wallet"
        addChild(myWallet ?? TabProfileVC())
        myProfile = mainStoryBoard.instantiateViewController(withIdentifier: Controller.tabProfile) as? TabProfileVC
        myProfile?.title = LanguageHelper.getTranslationByKey(LanguageKey.MyProfile) ?? "My Profile"
        addChild(myProfile ?? TabProfileVC())
    }
}

