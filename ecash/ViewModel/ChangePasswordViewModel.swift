//
//  ChangePasswordViewModel.swift
//  ecash
//
//  Created by phong070 on 11/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct ChangePasswordViewModelKey {
    public static let OLDPASSWORD = "oldPassword"
    public static let NEWPASSWORD = "newPassword"
    public static let CONFIRMPASSWORD = "confirmPassword"
}
class ChangePasswordViewModel : ChangePasswordViewModelDelegate {
    var oldValue: String?
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())
    var oldPassword: String? {
        didSet {
            validateOldPassword()
        }
    }
    
    var newPassword: String? {
        didSet{
            validateNewPassword()
        }
    }
    
    var confirmPassword: String? {
        didSet{
            validateConfirmPassword()
        }
    }
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    var responseToView: ((String) -> ())?
    
    private let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    /**
     Validation for password field
     */
    func validateOldPassword() {
        if oldPassword == nil || !ValidatorHelper.minLength(oldPassword){
            errorMessages.value[ChangePasswordViewModelKey.OLDPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorOldPasswordRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(oldPassword,minLength: 6) || !ValidatorHelper.maxLength(oldPassword, maxLength: 20){
            errorMessages.value[ChangePasswordViewModelKey.OLDPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: ChangePasswordViewModelKey.OLDPASSWORD)
        }
    }
    
    /**
     Validation for password field
     */
    func validateNewPassword() {
        if newPassword == nil || !ValidatorHelper.minLength(newPassword){
            errorMessages.value[ChangePasswordViewModelKey.NEWPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorNewPasswordRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(newPassword,minLength: 6) || !ValidatorHelper.maxLength(newPassword, maxLength: 20){
            errorMessages.value[ChangePasswordViewModelKey.NEWPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: ChangePasswordViewModelKey.NEWPASSWORD)
        }
    }
   
    /**
     ValidateConfirm
     */
    func validateConfirmPassword(){
        if confirmPassword == nil || !ValidatorHelper.minLength(confirmPassword) {
            errorMessages.value[ChangePasswordViewModelKey.CONFIRMPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorConfirmPasswordRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(confirmPassword,minLength: 6) || !ValidatorHelper.maxLength(confirmPassword, maxLength: 20){
            errorMessages.value[ChangePasswordViewModelKey.CONFIRMPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength) ?? ""
        }
        else if confirmPassword != newPassword {
            errorMessages.value[ChangePasswordViewModelKey.CONFIRMPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordDoNotMatch ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: ChangePasswordViewModelKey.CONFIRMPASSWORD)
        }
    }
    
    /**
     do login
     */
    func doChangePassword() {
        validateOldPassword()
        validateNewPassword()
        validateConfirmPassword()
     
        if ( errorMessages.value.count > 0 ) {
            return
        }
        let encypted = newPassword?.elGamalEncrypt(receiverPublickey: CipherKey.PublicServerKey)
        guard let encryptedPassword = encypted else  {
            debugPrint("Error created encrypt value")
            return
        }
        guard let finalPassword = CommonService.getValueFromArray(data: encryptedPassword, insert: "$") else{
            debugPrint("Error created final password")
            return
        }
        let encyptedOld = oldPassword?.elGamalEncrypt(receiverPublickey: CipherKey.PublicServerKey)
        guard let encryptedOldPassword = encyptedOld else  {
            debugPrint("Error created encrypt value")
            return
        }
        guard let finalOldPassword = CommonService.getValueFromArray(data: encryptedOldPassword, insert: "$") else{
            debugPrint("Error created final password")
            return
        }
        
        showLoading.value = true
        userService.changePassword(data: ChangePasswordRequestModel(oldPassword : finalOldPassword,newPassword: finalPassword)) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        
                        if var mSignUpData = CommonService.getSignUpStoreData() {
                            mSignUpData.password = finalPassword
                            CommonService.setSignUpData(storeInfo: mSignUpData)
                        }
                        
                        if let mSignInData = CommonService.getSignInData() {
                            mSignInData.token = finalPassword
                           CommonService.setSignInData(storeInfo: mSignInData)
                        }
                        
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Success) ?? "Success",
                            message: LanguageHelper.getTranslationByKey(LanguageKey.ChangedPasswordSuccessfully),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                                self.responseToView!(EnumResponseToView.CHANGED_PASSWORD_SUCCESSFULLY.rawValue)
                            })
                        )
                        self.onShowError?(okAlert)
                    }else{
                         let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                message:  CommonService.getErrorMessageFromSystem(code: response.responseCode ?? "0"),
                                                       action: AlertAction(buttonTitle: "Ok", handler: {
                                                       print("Ok pressed!")
                        }))
                        self.onShowError?(okAlert)
                    }
                }
                break
            case .failure( let error ):
                Utils.logMessage(object: error)
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
