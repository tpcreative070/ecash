//
//  HomeVC.swift
//  ecash
//
//  Created by phong070 on 8/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class HomeVC : BaseViewController {
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var imgScan : UIImageView!
    @IBOutlet weak var viewProfileInfo : UIView!
    @IBOutlet weak var lbFullname : ICLabel!
    @IBOutlet weak var lbFullnameValue : ICLabel!
    @IBOutlet weak var lbeCashId : ICLabel!
    @IBOutlet weak var lbeCashIdValue : ICLabel!
    @IBOutlet weak var lbeCashTotal : ICLabel!
    @IBOutlet weak var lbeCashTotalValue : ICLabel!
    @IBOutlet weak var lbeDongId : ICLabel!
    @IBOutlet weak var lbeDongIdValue : ICLabel!
    @IBOutlet weak var imgDropdown : UIImageView!
    @IBOutlet weak var lbeDongTotal : ICLabel!
    @IBOutlet weak var lbeDongTotalValue : ICLabel!
    @IBOutlet weak var imgAddeCash : UIImageView!
    @IBOutlet weak var imgWithdraw : UIImageView!
    @IBOutlet weak var imgExchangeeCash : UIImageView!
    @IBOutlet weak var imgTransfer : UIImageView!
    @IBOutlet weak var lbAddeCash : ICLabel!
    @IBOutlet weak var lbWithdraw : ICLabel!
    @IBOutlet weak var lbExchangeeCash : ICLabel!
    @IBOutlet weak var lbTransfer : ICLabel!
    @IBOutlet weak var lbBadgeNumber : ICBadgeSwift!
    @IBOutlet weak var imgNotification : UIImageView!
    @IBOutlet weak var lbPaymentServices : ICLabel!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var viewAddedeCash : UIView!
    @IBOutlet weak var viewWithdraweCash : UIView!
    @IBOutlet weak var viewExchangeeCash : UIView!
    @IBOutlet weak var viewTransfer : UIView!
    @IBOutlet weak var viewCircle : UIView!
    @IBOutlet weak var imgCircle : UIImageView!
    @IBOutlet weak var viewBackgroundHeader : UIView!
    @IBOutlet weak var viewBackgroundBody : UIView!
    @IBOutlet weak var viewRoot : ICViewHalf!
    @IBOutlet weak var viewDropDown : UIView!
    @IBOutlet weak var stackViewUserProfile : UIStackView!
    @IBOutlet weak var viewActiveAccount : UIView!
    @IBOutlet weak var viewActionButton : UIView!
    @IBOutlet weak var imgExclamation : UIImageView!
    @IBOutlet weak var lbActiveAccount : ICLabel!
    @IBOutlet weak var viewDropDownNone : UIView!
    @IBOutlet weak var lbeDongIdNone : ICLabel!
    @IBOutlet weak var lbeDongIdValueNone : ICLabel!
    @IBOutlet weak var imgDropdownNone : UIImageView!
    
    @IBOutlet weak var lbeDongBalanceNone : ICLabel!
    @IBOutlet weak var lbeDongBalanceValueNone : ICLabel!
    
    @IBOutlet weak var lbBadgeNumberLixi : ICBadgeSwift!
    @IBOutlet weak var imgLixi: UIImageView!
    @IBOutlet weak var viewLixi: UIView!
    @IBOutlet weak var constraintHeight : NSLayoutConstraint!
    lazy var dropdowneDong : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dropdowneDongNone : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var collectionViewDataSource :CollectionViewDataSource<CollectionViewCell,PaymentServicesViewModel>!
    let viewModel = HomeViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
//        if let key = CommonService.getPublicKey(){
//            log(message: "public key \(key)")
//        }
//
//        if let key = CommonService.getPrivateKey(){
//            log(message: "private key \(key)")
//        }
//
//        if let mDataValue = SQLHelper.getListeCashLogsTemporary() {
//            log(message: "cash log temporary")
//            log(object : mDataValue)
//        }
//
        if let mTransactiosLogs = SQLHelper.getListTransactionsLogs() {
            log(message: "Transactions logs")
            log(object : mTransactiosLogs)
        }
//
//        if let mCashlogs = SQLHelper.getListCashLogs() {
//            log(message: "cash log")
//            log(object : mCashlogs)
//        }
//
//        if let mCashlogsAvailable = SQLHelper.getListAvailable() {
//            log(message: "cash log available")
//            log(object : mCashlogsAvailable)
//        }
//
        if  let mDecisionDiary = SQLHelper.getListDecisionsDiary() {
            log(message: "Decision diary")
            log(object : mDecisionDiary)
        }
//
//        if let masterKey = CommonService.getMasterKey() {
//            debugPrint("Master key \(masterKey)")
//        }
//
//        if let key = CommonService.getKeychainData(){
//            log(object : key)
//        }
//
//        if let mCashInValid = SQLHelper.getListCashInvaidLogs(){
//            log(message: "Cash invalid")
//            log(object : mCashInValid)
//        }
//
//        if let mSignUp = CommonService.getSignUpStoreData() {
//            log(object : mSignUp)
//        }
//
//        if let mData = SQLHelper.getTransactionQR() {
//            log(message: "TransactionQR")
//            log(object : mData)
//        }
//
//        if let mData = SQLHelper.getNotificationHistoryList(){
//            log(object : mData)
//        }
        //let value = "Bundle version".infoForKey()
        //debugPrint("bundle version : \(value ?? "")")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    @objc func actionAddedeCash(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.addeCash, isNavigation: false)
//        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime()
    }
    
    @objc func actionWithdraweCash(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.withdraweCashMultiple, isNavigation: false)
    }
    
    @objc func actionExchangeeCash(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.exchangeeCash, isNavigation: false)
    }
    
    @objc func actionTransfereCash(sender : UITapGestureRecognizer){
        CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, eCash: nil), isResponse: false)
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transfereCashMultiple, isNavigation: false)
    }
    
    @objc func actionScaner(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        tabBarController?.selectedIndex = 2
    }
    
    @objc func actionDropDown(sender : UITapGestureRecognizer){
        dropdowneDong.show()
    }
    
    @objc func actionDropDownNone(sender : UITapGestureRecognizer){
        dropdowneDongNone.show()
    }
    
    @objc func actionActiveAccount(sender : UITapGestureRecognizer){
        viewModel.doSignInWithNoneWallet()
    }
    
    @objc func actionNotification(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.notificationHistory, isNavigation: false)
    }
    
    @objc func actionLixi(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.lixi, isNavigation: false)
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        onRegisterSingleton()
        CollectionViewCell.identifier = EnumIdentifier.PaymentServices
        viewModel.checkSession()
        viewModel.doBindingDataToView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func requestUpdateeDong() {
        self.viewModel.doGeteDongInfo()
    }
    
    override func requestCheckAvailableNotification() {
        self.viewModel.doCheckAvaiableNotification()
    }
    
    override func updateActionToView(data: String) {
        if EnumResponseToView.UPDATE_HOME_TO_LIXI.rawValue == data{
            self.viewModel.doCheckAvaliableLixi()
        }
    }
    
    override func updateActionToObjectView(obj: EventBusObjectData) {
        switch obj.type {
            case DataKeyType.StringOriginal:
                let data: String = obj.data as? String ?? ""
                if (obj.identify == EnumViewControllerNameIdentifier.PayToVC && data == "") {
                    tabBarController?.selectedIndex = 2
                }
//                if (obj.identify == EnumViewControllerNameIdentifier.GlobalUpdateEvent && data == EnumPassdata.UserDataDidChange.rawValue) {
//                    self.viewModel.doGeteDongInfo()
//                }
                break
            default:
                break
            }
    }
}

