//
//  MyWalletViewModel.swift
//  ecash
//
//  Created by phong070 on 9/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class MyWalletViewModel  : MyWalletViewModelDelegate {
    var avatarBinding: Bindable<UIImage> = Bindable(UIImage())
    var eCashAvailable: String = "0"
    var idNumberBinding: Bindable<String> = Bindable("")
    var eCashPhoneNumber: Bindable<String> = Bindable("")
    var fullNameBinding: Bindable<String> = Bindable("")
    
    var eCashIdBinding: Bindable<String> = Bindable("")
    
    var eCashBalanceBinding: Bindable<String> = Bindable("")
    
    var eDongIdBinding: Bindable<String> = Bindable("")
    
    var eDongBalanceBinding: Bindable<String> = Bindable("")
    
    var eDongAccountListBinding: Bindable<[String]> = Bindable([])
    
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    var navigate: (() -> ())?
    
    var responseToView: ((String) -> ())?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
  
    private let userService : UserService
    private let productService : ProductService
    init(productService: ProductService = ProductService(),userService : UserService = UserService()) {
        self.productService = productService
        self.userService = userService
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
        //let userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
        let profile = userProfile.value
        fullNameBinding.value = Bindable(UserProfileViewModel()).value.fullNameView ?? ""
        eCashIdBinding.value = profile.eCashIdView ?? ""
        eCashBalanceBinding.value = profile.eCashBalanceView ?? ""
        eDongIdBinding.value = profile.eDongIdView ?? ""
        eDongBalanceBinding.value = profile.eDongBalanceView ?? ""
        eDongAccountListBinding.value = profile.listeDong
        if let mAvatar = CommonService.getLargeAvatar() {
            avatarBinding.value = mAvatar.doConvertBase64StringToImage()
        }
    }
    
    /**
     do sign out
     */
    func doSignOut(){
        showLoading.value = true
        userService.signOut(data: SignOutRequestModel()) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        self.responseToView!(EnumResponseToView.SIGN_OUT_SUCCESS.rawValue)
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message:  LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                            print("Ok pressed!")
                        })
                        )
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
    
    /**
     do sign out
     */
    func doDeleteAccount(){
        showLoading.value = true
        userService.deleteAccount(data: DestroyWalletRequestModel()) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        self.responseToView!(EnumResponseToView.DELETE_ACCOUNT_SUCCESSFULLY.rawValue)
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                            message:  LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                            print("Ok pressed!")
                        })
                        )
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
    
    func doCheckeCashBalance(){
        guard let mData = SQLHelper.getListAvailable() else {
            responseToView!(EnumResponseToView.NO_ECASH.rawValue)
            return
        }
        if mData.count>0 {
            var totalMoney = Int64(0)
            for index in mData{
                totalMoney += Int64(index.value ?? 0)
            }
            self.eCashAvailable = totalMoney.description
            responseToView!(EnumResponseToView.ECASH_AVAILABLE.rawValue)
        }else{
            responseToView!(EnumResponseToView.NO_ECASH.rawValue)
        }
    }
    
    
    
}

