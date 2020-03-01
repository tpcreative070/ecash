//
//  HomeViewModelList.swift
//  ecash
//
//  Created by phong070 on 8/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class HomeViewModelList: HomeViewModelListDelegate {
    var availableLixi: Bindable<Int> = Bindable(0)
    var availableNotification: Bindable<Int> = Bindable(0)
    var eDeviceKey: ELGamalModel?
    var noneWalletInfo: SignInWithNoneWalletViewModel = SignInWithNoneWalletViewModel()
    var responseToView: ((String) -> ())?
    var otpValue: String?
    var idNumberBinding : Bindable<String> = Bindable("")
    var eCashPhoneNumber: Bindable<String> = Bindable("")
    var isRefreshUI: Bindable<Bool> = Bindable(true)
    var fullNameBinding: Bindable<String> = Bindable("TRAN VAN A")
    var eCashIdBinding: Bindable<String> = Bindable("2332451223")
    var eCashBalanceBinding: Bindable<String> = Bindable("1.000.000VND")
    var eDongIdBinding: Bindable<String> = Bindable("21233222")
    var eDongBalanceBinding: Bindable<String> = Bindable("2.000.000")
    var eDongAccountListBinding: Bindable<[String]> = Bindable([])
    
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    var requestActiveAccount: Bindable<Bool> = Bindable(false)
    
    var startSocket: Bindable<Bool> = Bindable(false)

    var bindToSourceCollectionViewViewModels: (() -> ())?
    var list: [HomeViewModel] = [HomeViewModel]()
    var alertMessage: Bindable<String> = Bindable("")
    var isTestEnvironment: Bindable<Bool> = Bindable(false)
    var bindToSourceViewModels: (() -> ())?
    
    private let productService: ProductService
    private let userService : UserService
    var paymentServicesList = [PaymentServicesViewModel]()
    
    init(productService: ProductService = ProductService(),userService : UserService = UserService()) {
        self.productService = productService
        self.userService = userService
    }
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    /**
     Init Payment services data
    */
    
    func getPaymentServicesList(){
        paymentServicesList.append(PaymentServicesViewModel(data: PaymentServicesModel(icon: AppImages.IC_PAYMENT, name: LanguageHelper.getTranslationByKey(LanguageKey.RequirePayTo) ?? "", position: 0)))
        paymentServicesList.append(PaymentServicesViewModel(data: PaymentServicesModel(icon: AppImages.IC_PAYTO, name: LanguageHelper.getTranslationByKey(LanguageKey.CreateToPay) ?? "", position: 1)))
        paymentServicesList.append(PaymentServicesViewModel(data: PaymentServicesModel(icon: AppImages.IC_ELECTRONIC, name: LanguageHelper.getTranslationByKey(LanguageKey.PayEVN) ?? "", position: 2)))
        paymentServicesList.append(PaymentServicesViewModel(data: PaymentServicesModel(icon: AppImages.IC_WATER, name: LanguageHelper.getTranslationByKey(LanguageKey.PayWATER) ?? "", position: 3)))
//        paymentServicesList.append(PaymentServicesViewModel(data: PaymentServicesModel(icon: AppImages.IC_SHOP, name: LanguageHelper.getTranslationByKey(LanguageKey.PaySupermarket) ?? "", position: 2)))
//        paymentServicesList.append(PaymentServicesViewModel(data: PaymentServicesModel(icon: AppImages.IC_CABLE, name: LanguageHelper.getTranslationByKey(LanguageKey.PayVTVCab) ?? "", position: 3)))
        bindToSourceCollectionViewViewModels!()
    }
    
    /**
     Validation for password field
     */
    func validateDepartureDate() {
    }
    
    /**
     Validation for email field
     */
    func validateReturnDate() {
    }
    
    func checkSession(){
        doCheckAvaiableNotification()
        doCheckAvaliableLixi()
        if let user = CommonService.getUsername(){
            if user == "" {
                if CommonService.getIsIntro(){
                    responseToView!(EnumResponseToView.SignIn.rawValue)
                }else{
                    responseToView!(EnumResponseToView.Intro.rawValue)
                }
            }else{
                if !CommonService.getIsIntro(){
                    responseToView!(EnumResponseToView.Intro.rawValue)
                }
            }
        }else{
            if CommonService.getIsIntro(){
                 responseToView!(EnumResponseToView.SignIn.rawValue)
            }else{
                 responseToView!(EnumResponseToView.Intro.rawValue)
            }
        }
    }
    
    func doCheckAvaiableNotification(){
        guard let mList = SQLHelper.getAvailableNotificationHistoryList()else {
            availableNotification.value = 0
            return
        }
        availableNotification.value = mList.count
    }
    
    func doCheckAvaliableLixi(){
        let mData = SQLHelper.getCountLixi()
        availableLixi.value = mData
    }
    
    func doProductList() {
        showLoading.value = true
        productService.productList() { result  in
            self.showLoading.value = false
            switch result {
            case .success(let response) :
                if let data = response?.data{
                    Utils.logMessage(object: data)
                    self.bindToSourceViewModels!()
                }
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                break
            }
        }
    }
    
    func eDongToeCash(){
        if !CommonService.isSigined() {
            return
        }
        showLoading.value = true
        productService.eDongToeCash(data: eDongToeCashRequestModel()) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let result) :
                if let response = result{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                      
                    }else{
                        let okAlert = SingleButtonAlert(
                                title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                                message:  CommonService.getErrorMessageFromSystem(code: response.responseCode ?? "0"),
                                action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                        }))
                        self.onShowError?(okAlert)
                    }
                }
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                break
            }
        }
    }
  
    func doGeteDongInfo(){
        if !CommonService.isSigined() {
            return
        }
        showLoading.value = true
        GlobalRequestApiHelper.shared.doGeteDongInfo(completion: { (result) -> () in
            self.showLoading.value = false
            if result.success ?? false{
                guard let mResponse = result.eDongInfoData else{
                    debugPrint("Debug")
                    self.doBindingDataToView()
                    return
                }
                self.doBindingDataToView(data:mResponse)
            }else{
               let okAlert = SingleButtonAlert(
                        title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                        message:  CommonService.getErrorMessageFromSystem(code: result.responseCode ?? "0"),
                        action: AlertAction(buttonTitle: "Ok", handler: {
                        print("Ok pressed!")
                }))
                self.onShowError?(okAlert)
            }
        })
    }
    
    /**
      doSignInWithNoneWalletValidatedOTP
    */
    func doSignInWithNoneWallet() {
            guard let key = ELGamalHelper.instance.generateECKey() else {
                        debugPrint("Error created key")
                        return
            }
        Utils.logMessage(message: "Device of key")
        self.eDeviceKey = key
        showLoading.value = true
        userService.signInWithNoneWallet(data: SignInWithNoneWalletRequestModel(data : key)) { result  in
               self.showLoading.value = false
               switch result {
               case .success(let userResult):
                   if let response = userResult{
                       Utils.logMessage(object: response)
                       if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                         self.noneWalletInfo = SignInWithNoneWalletViewModel(data: response.responseData)
                         self.responseToView!(EnumResponseToView.REQUEST_OTP.rawValue)
                       }else{
                           let okAlert = SingleButtonAlert(
                                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                    message:  LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                                    action: AlertAction(buttonTitle: "Ok", handler: {
                                                     print("Ok pressed!")
                            }))
                            self.onShowError?(okAlert)
                       }
                   }
                   break
               case .failure( let error ):
                   let okAlert = SingleButtonAlert(
                       title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                       message: error.message,
                       action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                   )
                   self.onShowError?(okAlert)
                   break
               }
           }
    }
    
    /**
     doSignInWithNoneWalletValidatedOTP
     */
    func doSignInWithNoneWalletValidatedOTP() {
        guard let key = eDeviceKey else {
                              debugPrint("Error created key")
                              return
        }
        showLoading.value = true
        userService.signInWithNoneWalletValidatedOTP(data: SignInWithNoneWalletValidatedOTPRequestModel(data : noneWalletInfo, mOTPValue: otpValue ?? "")) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        CommonService.setKeychainData(storeInfo: KeychainDeviceStoreModel(data: key))
                        CommonService.setSignUpData(storeInfo:SignUpStoreModel(data:response.responseData,viewModel: self.noneWalletInfo))
                        self.requestActiveAccount.value = false
                        self.startSocket.value = true
                        self.doGeteDongInfo()
                    }
                    else {
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? ""),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                self.responseToView!(EnumResponseToView.REQUEST_OTP.rawValue)
                                print("Ok pressed!")
                            }))
                        self.onShowError?(okAlert)
                    }
                }
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                break
            }
        }
    }
    
    func doRequestActiveAccount(){
        guard let _ = CommonService.getWalletId() else {
           requestActiveAccount.value = true
           doGeteDongInfo()
           return
        }
        requestActiveAccount.value = false
    }
    
    func doStartSocket(){
        guard let key = CommonService.getWalletId() else {
            startSocket.value = false
            return
        }
        debugPrint("socket preparing... !!!!\(key)")
        startSocket.value = true
    }
    
    func doBindingDataToView(data : eDongInfoData? = nil){
        guard let mData = data else {
            doBindingUpdate()
            return
        }
        
        guard let mAccountList = mData.listAcc else{
            doBindingUpdate()
            return
        }
        userProfile.value = UserProfileViewModel(data: mAccountList)
        doBindingUpdate()
    }
    
    func doBindingUpdate(){
        let profile = userProfile.value
        fullNameBinding.value = Bindable(UserProfileViewModel()).value.fullNameView ?? ""
        eCashIdBinding.value = profile.eCashIdView ?? ""
        eCashBalanceBinding.value = profile.eCashBalanceView ?? ""
        eDongIdBinding.value = profile.eDongIdView ?? ""
        eDongBalanceBinding.value = profile.eDongBalanceView ?? ""
        eDongAccountListBinding.value = profile.listeDong
    }
}
