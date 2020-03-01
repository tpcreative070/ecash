//
//  SignOutOptionsViewModel.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignOutOptionsViewModel : SignOutOptionsViewModelDelegate {
    
    var responseToView: ((String) -> ())?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    
    
    private let userService : UserService
    init(userService : UserService = UserService()) {
        self.userService = userService
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
                        CommonService.setIsSignOut(value: true)
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                                action: AlertAction(buttonTitle: "Ok", handler: {
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
    
}
