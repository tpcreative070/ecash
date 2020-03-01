//
//  TabWalletVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TabWalletVC {
    func initUI(){
        self.imgAvatar.image = UIImage(named: AppImages.IC_AVATAR)
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.borderColor = .clear
        self.imgHelp.image = UIImage(named: AppImages.IC_HELP)
        self.imgNextHelp.image = UIImage(named: AppImages.IC_NEXT_IOS)?.withRenderingMode(.alwaysTemplate)
        self.imgNextHelp.tintColor = AppColors.GRAY_LIGHT_TEXT
        self.imgCloseAccount.image = UIImage(named: AppImages.IC_DESTROY)
        self.imgNextCloseAccount.image = UIImage(named: AppImages.IC_NEXT_IOS)?.withRenderingMode(.alwaysTemplate)
        self.imgNextCloseAccount.tintColor = AppColors.GRAY_LIGHT_TEXT
        self.imgExitAccount.image = UIImage(named: AppImages.IC_SIGN_OUT)
        self.imgNextExitAccount.image = UIImage(named: AppImages.IC_NEXT_IOS)?.withRenderingMode(.alwaysTemplate)
        self.imgNextExitAccount.tintColor = AppColors.GRAY_LIGHT_TEXT
        
        self.lbFullname.text = "Nguyen Van A"
        self.lbFullname.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        let id = "1323232323"
        self.lbeCashId.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeCashId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        let idValue  = "\(LanguageHelper.getTranslationByKey(LanguageKey.eCashId) ?? ""): \(id)"
        self.lbeCashId.attributedText = idValue.toColorAttribute(value: id, color: AppColors.BLUE)
        let balance = "3.500.000VND"
        self.lbBalance.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbBalance.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        let balanceValue  = "\(LanguageHelper.getTranslationByKey(LanguageKey.eCashBalance) ?? ""): \(balance)"
        self.lbBalance.attributedText = balanceValue.toColorAttribute(value: balance, color: AppColors.BLUE)
        
        self.lbHelp.text = LanguageHelper.getTranslationByKey(LanguageKey.Help)
        self.lbHelp.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbCloseAccount.text = LanguageHelper.getTranslationByKey(LanguageKey.DeleteAccount)
        self.lbCloseAccount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbExitAccount.text = LanguageHelper.getTranslationByKey(LanguageKey.SignOut)
        self.lbExitAccount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.viewHelp.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionHelp(sender:))))
        self.viewDelete.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionDelete(sender:))))
        self.viewSignOut.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionSignOut(sender:))))
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
            self.lbFullname.text = data
        }
        self.viewModel.eCashIdBinding.bind { data in
            let idValue  = "\(LanguageHelper.getTranslationByKey(LanguageKey.eCashId) ?? ""): \(data)"
            self.lbeCashId.attributedText = idValue.toColorAttribute(value: data, color: AppColors.BLUE)
        }
        self.viewModel.eCashBalanceBinding.bind { data in
            self.log(message: "TabWallet update cash balance")
            //self.lbBalance.text = "\(LanguageHelper.getTranslationByKey(LanguageKey.eCashBalance) ?? ""): \(data)"
            let cashValue  = "\(LanguageHelper.getTranslationByKey(LanguageKey.eCashBalance) ?? ""): \(data)"
            self.lbBalance.attributedText = cashValue.toColorAttribute(value: data, color: AppColors.BLUE)
        }
        self.viewModel.responseToView =  {[weak self] data in
            if data == EnumResponseToView.SIGN_OUT_SUCCESS.rawValue {
                CommonService.signOutGlobal()
                WebSocketClientHelper.instance.socket.disconnect()
                Navigator.pushViewMainStoryboard(from: self!,identifier : Controller.signin,isNavigation: false)
            }else if data == EnumResponseToView.DELETE_ACCOUNT_SUCCESSFULLY.rawValue {
                CommonService.signOutGlobal()
                WebSocketClientHelper.instance.socket.disconnect()
                CommonService.deleteAccount()
                SQLHelper.initCipher(isDelete: true)
                CommonService.setMasterKey(data: CipherKey.Key)
                SQLShareHelper.shared.setConnection(db: nil)
                CommonService.setIsNewApp(value: true)
                self?.tabBarController?.selectedIndex = 0
                Navigator.pushViewMainStoryboard(from: self!,identifier : Controller.destroyWalletSuccessfulOptions,isNavigation: false,isTransparent: true,present : true)
            }
            else if data == EnumResponseToView.ECASH_AVAILABLE.rawValue {
                CommonService.sendDataToDestroyWalletOptions(data: DestroyWalletOptionsData(balance: self?.viewModel.eCashAvailable), isResponse: false)
                Navigator.pushViewMainStoryboard(from: self!,identifier : Controller.destroyWalletOptions,isNavigation: false,isTransparent: true, present : true)
            }else if data == EnumResponseToView.NO_ECASH.rawValue {
                self?.doAlertMessage(message: LanguageHelper.getTranslationByKey(LanguageKey.AreYouSureDeleteThisAccount) ?? "")
            }
        }
        self.viewModel.avatarBinding.bind { (value) in
            self.imgAvatar.image = value
        }
        viewModel.doBindingDataToView(data: nil)
    }
    
    func doCheckSignOut() {
          if let mData =  CommonService.getIsSignOut(){
              if mData {
                  tabBarController?.selectedIndex = 0
                  CommonService.setIsSignOut(value: !mData)
              }
          }
    }
}

extension TabWalletVC : SingleButtonDialogPresenter {
    
}
