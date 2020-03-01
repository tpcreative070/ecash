//
//  ForgetPasswordViewModel.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct ForgotPasswordViewModelKey {
    public static let USERNAME = "username"
    public static let OTPCODE = "otpcode"
    public static let NEWPASSWORD = "newPassword"
    public static let CONFIRMPASSWORD = "confirmPassword"
}

class ForgotPasswordViewModel : ForgotPasswordViewModelDelegate {
    var isForgorPassword: Bool? = true
    var userId: String?
    var transactionCode: String? 
    var username: String? {
        didSet {
            validateUsername()
        }
    }
    var readOnlyUsernameBinding: Bindable<Bool> = Bindable(false)
    var userNameBinding: Bindable<String> = Bindable("")
    
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
    
    var responseToView: ((String) -> ())?
    
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    var otpCode: String? {
        didSet {
            validateOTPCode()
        }
    }
    
    /**
     ValidatePhonenumber
     */
    func validateUsername(){
        if username == nil || !ValidatorHelper.minLength(username) {
            errorMessages.value[ForgotPasswordViewModelKey.USERNAME] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPhoneNumberRequired) ?? ""
        }
        else if CommonService.isFirstInitialized() && ((username ?? "").isSpecialCharacter()){
            errorMessages.value[ForgotPasswordViewModelKey.USERNAME] =  LanguageHelper.getTranslationByKey(LanguageKey.UsernameCouldNotContainSpecialCharacter) ?? ""
        }
        else {
            debugPrint("Verified phone number...")
            errorMessages.value.removeValue(forKey: ForgotPasswordViewModelKey.USERNAME)
        }
    }
    
    /**
     Validation for otp
     */
    func validateOTPCode(){
        if otpCode == nil || !ValidatorHelper.minLength(otpCode) {
            errorMessages.value[ForgotPasswordViewModelKey.OTPCODE] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorOTPRequest) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: ForgotPasswordViewModelKey.OTPCODE)
        }
    }
    
    /**
     Validation for password field
     */
    func validateNewPassword() {
        if newPassword == nil || !ValidatorHelper.minLength(newPassword){
            errorMessages.value[ForgotPasswordViewModelKey.NEWPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorNewPasswordRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(newPassword,minLength: 6) || !ValidatorHelper.maxLength(newPassword, maxLength: 20){
            errorMessages.value[ForgotPasswordViewModelKey.NEWPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: ForgotPasswordViewModelKey.NEWPASSWORD)
        }
    }
    
    /**
     ValidateConfirm
     */
    func validateConfirmPassword(){
        if confirmPassword == nil || !ValidatorHelper.minLength(confirmPassword) {
            errorMessages.value[ForgotPasswordViewModelKey.CONFIRMPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorConfirmPasswordRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(confirmPassword,minLength: 6) || !ValidatorHelper.maxLength(confirmPassword, maxLength: 20){
            errorMessages.value[ForgotPasswordViewModelKey.CONFIRMPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength) ?? ""
        }
        else if confirmPassword != newPassword {
            errorMessages.value[ChangePasswordViewModelKey.CONFIRMPASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordDoNotMatch ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: ForgotPasswordViewModelKey.CONFIRMPASSWORD)
        }
    }
    
    private let userService: UserService
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    func doGetIntent(){
        if let mData = CommonService.getShareOTP(){
            self.transactionCode = mData.transactionCode
            self.userId = mData.userId
            self.username = mData.userName
        }
    }
    
    func doReadOnlyUsername(){
        readOnlyUsernameBinding.value = false
        guard  let mSignUp = CommonService.getSignUpStoreData() else {
            readOnlyUsernameBinding.value = false
            return
        }
        
        guard let _ = mSignUp.username else {
            readOnlyUsernameBinding.value = false
            return
        }
        readOnlyUsernameBinding.value = true
        updatedUI(data: mSignUp)
    }
    
    func updatedUI(data : SignUpStoreModel){
        self.userNameBinding.value = data.username ?? ""
        self.username = data.username ?? ""
    }
    
    /**
     do send otp
     */
    func doSendOTP() {
        if (isForgorPassword ?? false) {
            validateUsername()
        }
        showLoading.value = true
        userService.sendOTP(data: SendOTPRequestModel(username: username ?? "")) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        self.transactionCode = response.responseData.transactionCode ?? ""
                        self.userId =  response.responseData.userId ?? ""
                        CommonService.sendDataToOTP(data: OTPShareData(userId : self.userId ?? "",transactionCode: self.transactionCode ?? "",userName: self.username ?? ""), isResponse: false)
                        self.responseToView!(EnumResponseToView.SENT_OTP_SUCCESSFULLY.rawValue)
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
    
    /**
     do updated forgot password
     */
    func doUpdatedForgotPassword() {
        validateNewPassword()
        validateConfirmPassword()
        showLoading.value = true
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
        userService.updatedForgotPassword(data: UpdatedForgotPasswordRequestModel(newPassword: finalPassword,userId: userId ?? "",transactionCode:transactionCode ?? "" , otpCode: otpCode ?? "")) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        self.responseToView!(EnumResponseToView.UPDATED_FORGOT_PASSWORD_SUCCESSFULLY.rawValue)
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
