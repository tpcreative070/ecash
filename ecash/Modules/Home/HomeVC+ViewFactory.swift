//
//  HomeVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension HomeVC {
    func initUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.imgScan.image = UIImage(named: AppImages.IC_QRCODE)
        self.imgScan.image = imgScan.image?.withRenderingMode(.alwaysTemplate)
        self.imgScan.tintColor = .white
        self.imgLogo.image = UIImage(named: AppImages.IC_LOGO)
        self.imgLogo.image = imgLogo.image?.withRenderingMode(.alwaysTemplate)
        self.imgLogo.tintColor = .white
        self.viewProfileInfo.setRadius(corner: 3,color: AppColors.GRAY_LIGHT)
        self.viewProfileInfo.setShadow(color: AppColors.GRAY,corner : 3)
        self.viewProfileInfo.backgroundColor = AppColors.WHITE_COLOR
        self.imgDropdown.image = UIImage(named: AppImages.IC_DROPDOWN)
        
        self.viewNotification.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionNotification(sender:))))
            
        self.viewLixi.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionLixi(sender:))))
        
        self.lbFullname.text = LanguageHelper.getTranslationByKey(LanguageKey.AccountName)
        self.lbFullname.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbFullname.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbFullnameValue.text = "Nguyen Van A"
        self.lbFullnameValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbFullnameValue.textAlignment  = .right

        self.lbeCashId.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashId)
        self.lbeCashId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeCashId.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeCashIdValue.text = "124323322442"
        self.lbeCashIdValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeCashIdValue.textAlignment  = .right
        
        self.lbeCashTotal.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashBalance)
        self.lbeCashTotal.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeCashTotal.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeCashTotalValue.text = "0".toMoney()
        self.lbeCashTotalValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbeCashTotalValue.textAlignment  = .right
        
        self.lbeDongId.text = LanguageHelper.getTranslationByKey(LanguageKey.eDongId)
        self.lbeDongId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongId.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeDongIdValue.text = "0979123123"
        self.lbeDongIdValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongIdValue.textAlignment  = .right
        
        self.lbeDongTotal.text = LanguageHelper.getTranslationByKey(LanguageKey.eDongBalance)
        self.lbeDongTotal.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongTotal.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeDongTotalValue.text = "0".toMoney()
        self.lbeDongTotalValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongTotalValue.textAlignment  = .right
        
        self.lbAddeCash.textAlignment = .center
        self.lbAddeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.AddeCash)
        self.lbAddeCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.imgAddeCash.image = UIImage(named: AppImages.IC_CIRCLE_CASH_IN)
        
        self.lbWithdraw.textAlignment = .center
        self.lbWithdraw.text = LanguageHelper.getTranslationByKey(LanguageKey.WithDraweCash)
        self.lbWithdraw.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.imgWithdraw.image = UIImage(named: AppImages.IC_CIRCLE_CASH_OUT)
        
        self.lbExchangeeCash.textAlignment = .center
        self.lbExchangeeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.ExchangeeCash)
        self.lbExchangeeCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.imgExchangeeCash.image = UIImage(named: AppImages.IC_CIRCLE_CASH_CHANGE)
        
        self.lbTransfer.textAlignment = .center
        self.lbTransfer.text = LanguageHelper.getTranslationByKey(LanguageKey.Transfer)
        self.lbTransfer.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.imgTransfer.image = UIImage(named: AppImages.IC_CIRCLE_TRANSFER)
        
        self.lbBadgeNumber.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.FOOTER_LABEL_FONT_SIZE - 4)
        self.lbBadgeNumber.text = "11"
        self.lbBadgeNumber.textAlignment = .center
        self.lbBadgeNumber.insets = CGSize(width: 1, height: 1)
        self.imgNotification.image = UIImage(named: AppImages.IC_BELL)
        self.imgNotification.image = imgNotification.image?.withRenderingMode(.alwaysTemplate)
        self.imgNotification.tintColor = .white
        
        //Lixi
        self.lbBadgeNumberLixi.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.FOOTER_LABEL_FONT_SIZE - 4)
        self.lbBadgeNumberLixi.text = "1"
        self.lbBadgeNumberLixi.textAlignment = .center
        self.lbBadgeNumberLixi.insets = CGSize(width: 1, height: 1)
        self.imgLixi.image = UIImage(named: AppImages.IC_LIXI)
    
        self.lbPaymentServices.text = LanguageHelper.getTranslationByKey(LanguageKey.PaymentServices)
        self.lbPaymentServices.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.lbPaymentServices.textColor = AppColors.BLUE
        self.viewAddedeCash.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionAddedeCash(sender:))))
        self.viewWithdraweCash.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionWithdraweCash(sender:))))
        self.viewExchangeeCash.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionExchangeeCash(sender:))))
        self.viewTransfer.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionTransfereCash(sender:))))
        self.viewDropDown.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionDropDown(sender:))))
        self.imgScan.isUserInteractionEnabled = true
        self.imgScan.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionScaner(sender:))))
        

        /*None Wallet id*/
        self.viewActionButton.setCorner(corner: 3, color: AppColors.ORANGE)
        self.viewActionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector
            (actionActiveAccount(sender:))))
        self.imgExclamation.image = UIImage(named: AppImages.IC_EXCLAMATION)
        self.lbActiveAccount.textAlignment = .center
        self.lbActiveAccount.textColor = AppColors.WHITE_COLOR
        self.lbActiveAccount.text = LanguageHelper.getTranslationByKey(LanguageKey.ActiveAccountNow)?.uppercased()
        self.lbActiveAccount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        
        self.lbeDongIdNone.text = LanguageHelper.getTranslationByKey(LanguageKey.eDongId)
        self.lbeDongIdNone.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeDongIdValueNone.text = "2334243434"
        self.lbeDongIdValueNone.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongIdValueNone.textAlignment  = .right
        self.imgDropdownNone.image = UIImage(named: AppImages.IC_DROPDOWN)
        
        self.lbeDongBalanceNone.text = LanguageHelper.getTranslationByKey(LanguageKey.eDongBalance)
        self.lbeDongBalanceNone.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeDongBalanceValueNone.text = "0".toMoney()
        self.lbeDongBalanceValueNone.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongBalanceValueNone.textAlignment  = .right
        self.viewDropDownNone.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionDropDownNone(sender:))))
        
        dropdowneDongNone.anchorView = viewDropDownNone
        dropdowneDongNone.bottomOffset = CGPoint(x: 0, y: dropdowneDongNone.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        dropdowneDongNone.dataSource = [
            "001",
            "002"
        ]
        
        // Action triggered on selection
        dropdowneDong.selectionAction = { [weak self] (index, item) in
            self?.lbeDongIdValue.text = item
        }
        
        setupCollectionView()
        bindViewModel()
        viewModel.getPaymentServicesList()
        viewCircle.backgroundColor = .clear
        imgCircle.contentMode = .scaleToFill
        imgCircle.image = UIImage(named: AppImages.IC_LIXI_BACKGROUND)
        addBackgroundStatusBarLixi()
        viewBackgroundHeader.backgroundColor = AppColors.GRAY_LIGHT
        viewBackgroundBody.backgroundColor = AppColors.GRAY_LIGHT
        
        dropdowneDong.anchorView = viewDropDown
        dropdowneDong.bottomOffset = CGPoint(x: 0, y: viewDropDown.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        // Action triggered on selection
        dropdowneDong.selectionAction = { [weak self] (index, item) in
          self?.lbeDongIdValue.text = item
        }
    }
    
    func addBackgroundStatusBarLixi(){
          let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
          statusBarView.backgroundColor = .clear
          view.addSubview(statusBarView)
          if DeviceHelper().hasNotch {
            constraintHeight.constant = -44
          }else{
            constraintHeight.constant = -20
          }
      }
      
    
    func bindViewModel() {
        viewModel.bindToSourceCollectionViewViewModels = {
            self.updateCollectionViewDataSource()
        }
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        self.viewModel.responseToView  = {[weak self] value in
            if value == EnumResponseToView.SignIn.rawValue {
                Navigator.pushViewMainStoryboard(from: self!,identifier : Controller.signin,isNavigation: false)
            }else if value == EnumResponseToView.Intro.rawValue {
                Navigator.pushViewMainStoryboard(from: self!,identifier : Controller.intro,isNavigation: false)
            }
            else if value == EnumResponseToView.REQUEST_OTP.rawValue {
                self?.showAlert()
            }
        }
        self.viewModel.fullNameBinding.bind { data in
            self.lbFullnameValue.text = data
        }
        self.viewModel.eCashIdBinding.bind { data in
            self.lbeCashIdValue.text = data
        }
        self.viewModel.eCashBalanceBinding.bind { data in
            self.lbeCashTotalValue.text = data
        }
        self.viewModel.eDongIdBinding.bind { data in
            self.lbeDongIdValue.text = data
            self.lbeDongIdValueNone.text = data
        }
        self.viewModel.eDongBalanceBinding.bind { data in
            self.lbeDongTotalValue.text = data
            self.lbeDongBalanceValueNone.text = data
        }
        self.viewModel.startSocket.bind { data in
            if data{
                 WebSocketClientHelper.instance.connect()
                 self.log(message: "Starting socket...")
            }
        }
        self.viewModel.requestActiveAccount.bind { data in
            if data {
                self.stackViewUserProfile.isHidden = true
                self.viewActiveAccount.isHidden = false
                self.imgAddeCash.image = UIImage(named: AppImages.IC_CIRCLE_CASH_IN_GRAY)
                self.imgWithdraw.image = UIImage(named: AppImages.IC_CIRCLE_CASH_OUT_GRAY)
                self.imgExchangeeCash.image = UIImage(named: AppImages.IC_CIRCLE_CASH_CHANGE_GRAY)
                self.imgTransfer.image = UIImage(named: AppImages.IC_CIRCLE_TRANSFER_GRAY)
                
                self.tabBarController?.tabBar.items?[1].isEnabled = false
                self.tabBarController?.tabBar.items?[2].isEnabled = false
                self.tabBarController?.tabBar.items?[3].isEnabled = false
            }else{
                self.stackViewUserProfile.isHidden = false
                self.viewActiveAccount.isHidden = true
                self.imgAddeCash.image = UIImage(named: AppImages.IC_CIRCLE_CASH_IN)
                self.imgWithdraw.image = UIImage(named: AppImages.IC_CIRCLE_CASH_OUT)
                self.imgExchangeeCash.image = UIImage(named: AppImages.IC_CIRCLE_CASH_CHANGE)
                self.imgTransfer.image = UIImage(named: AppImages.IC_CIRCLE_TRANSFER)
                self.tabBarController?.tabBar.items?[1].isEnabled = true
                self.tabBarController?.tabBar.items?[2].isEnabled = true
                self.tabBarController?.tabBar.items?[3].isEnabled = true
            }
        }
        
        ShareHomeSingleton.shared.bind{ [weak self] in
            debugPrint("ShareHomeSingleton.shared.bind....???")
            if let data = ShareHomeSingleton.shared.get(value: PassDataViewModel.self){
                self?.log(object: data)
                if data.identifier == EnumPassdata.NAVIGATION.rawValue {
                    if data.navigation.codeAction == EnumResponseAction.TRANSACTION.rawValue {
                        self?.viewModel.doGeteDongInfo()
                        self?.viewModel.isRefreshUI.value = true
                        debugPrint("ShareHomeSingleton.shared.bind....hey")
                    }
                }
            }
        }
        
        viewModel.isRefreshUI.bind { data in
            if data{
                self.viewModel.checkSession()
                self.viewModel.doStartSocket()
                self.viewModel.doRequestActiveAccount()
            }
        }
        
        viewModel.availableNotification.bind { (value) in
            self.doPostNotificationBadge(count: value)
        }
        viewModel.availableLixi.bind { (value) in
            self.doPostLixiBadge(count: value)
        }
        
        self.viewModel.eDongAccountListBinding.bind { data in
            self.dropdowneDong.dataSource = data
            self.dropdowneDongNone.dataSource = data
        }
        self.bindCollectionView()
        self.viewModel.doBindingDataToView()
        self.viewModel.doGeteDongInfo()
        self.viewModel.isRefreshUI.value = true
    }
    
    func doPostNotificationBadge(count : Int){
        self.lbBadgeNumber.isHidden = !count.boolValue
        if count > 0{
            self.lbBadgeNumber.text = count.description
            self.lbBadgeNumber.textAlignment = .center
            self.lbBadgeNumber.insets = CGSize(width: 1, height: 1)
            self.imgNotification.image = UIImage(named: AppImages.IC_BELL)
            self.imgNotification.image = imgNotification.image?.withRenderingMode(.alwaysTemplate)
            self.imgNotification.tintColor = .white
        }
    }
    
    func doPostLixiBadge(count : Int){
         self.lbBadgeNumberLixi.isHidden = !count.boolValue
         if count > 0{
             self.lbBadgeNumberLixi.text = count.description
             self.lbBadgeNumberLixi.textAlignment = .center
             self.lbBadgeNumberLixi.insets = CGSize(width: 1, height: 1)
         }
     }
     
    
    
    func updateCollectionViewDataSource() {
        self.collectionViewDataSource.items = self.viewModel.paymentServicesList
        self.collectionView.reloadData()
        debugPrint("updateCollectionViewDataSource")
    }
    
    func bindCollectionView(){
        /*Setup collectionview*/
        self.collectionViewDataSource = CollectionViewDataSource(cellIdentifier: EnumIdentifier.PaymentServices.rawValue,size: 100, items: self.viewModel.paymentServicesList){ cell , vm in
            cell.delegate = self
            cell.configView(viewModel: vm)
        }
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.delegate = self.collectionViewDataSource
    }
  
    func setupCollectionView(){
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: EnumIdentifier.PaymentServices.rawValue)
    }
    
    func connectWebsocket(){
          WebSocketClientHelper.instance.connect()
    }
    
    func showAlert(){
           showInputDialog(title: LanguageHelper.getTranslationByKey(LanguageKey.AddOTP),
                           subtitle:LanguageHelper.getTranslationByKey(LanguageKey.PleaseEnterTheOTPCode) ,
                           actionTitle: LanguageHelper.getTranslationByKey(LanguageKey.Active),
                           cancelTitle: LanguageHelper.getTranslationByKey(LanguageKey.Cancel),
                           inputPlaceholder: LanguageHelper.getTranslationByKey(LanguageKey.OTPCode),
                           inputKeyboardType: .numberPad)
           { (input:String?) in
              //Action here
            self.viewModel.otpValue = input
            self.viewModel.doSignInWithNoneWalletValidatedOTP()
           }
    }
    
    func onRegisterSingleton(){
        ShareSingleton.shared.bind{ [weak self] in
            debugPrint("ShareSingleton.shared.bind....")
            if let data = ShareSingleton.shared.get(value: PassDataViewModel.self){
                if data.identifier == EnumPassdata.NAVIGATION.rawValue {
                    if data.navigation.codeAction == EnumResponseAction.TRANSACTION.rawValue {
                        self?.viewModel.doGeteDongInfo()
                    }
                }
            }
         }
    }
    
}

extension HomeVC : SingleButtonDialogPresenter {
    
}

extension HomeVC : CollectionViewCellDelegate {
    func cellCodable(codable: Codable) {
    }
    func cellViewSelected(cell: CollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        log(message: "Index \(indexPath.row)")
//        onAlertComingSoon()
        switch indexPath.row {
        case 0:
            if !CommonService.isActiveAccount() {
                self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            } else {
                Navigator.pushViewMainStoryboard(from: self, identifier: Controller.payTo, isNavigation: false, present: true)
            }
            break;
        case 1:
            if !CommonService.isActiveAccount() {
                self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            } else {
                Navigator.pushViewMainStoryboard(from: self, identifier: Controller.toPay, isNavigation: false, present: true)
            }
            break;
        default:
            onAlertComingSoon()
        }
    }
}
