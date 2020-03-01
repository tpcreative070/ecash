//
//  UserViewModel.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import UIKit
struct SignInViewModelKey {
    public static let EMAIL = "email"
    public static let PASSWORD = "password"
    public static let ACCOUNTNUMBER = "accountnumber"
    public static let ID = "id"
    public static let PhoneNumber = "phone_number"
    public static let FULLNAME = "fullname"
    public static let CONFIRM = "confirm"
}

class UserViewModel : UserViewModelDelegate {
    var avatarBinding: Bindable<UIImage> = Bindable(UIImage())
    var transactionCode: String?
    var finalPassword: String = ""
    var userNameBinding: Bindable<String> = Bindable("")
    var phoneNumberBinding: Bindable<String> = Bindable("")
    var fullNameBinding: Bindable<String> = Bindable("")
    
    var isContactBinding: Bindable<Bool> = Bindable(false)
    var readOnlyUsernameBinding: Bindable<Bool> = Bindable(false)
    
    var isSignIn: Bool? = false
    
    var otpCode: String?
    
    var responseToView: ((String) -> ())?
    
    var focusTextField: UITextField?
    
    var existingValue: Bindable<AlertData> = Bindable(AlertData(codeAction : "" ,name: "", nameValue: "", message: ""))
    var id: String? {
        didSet {
            validateId()
        }
    }
    
    var phoneNumber: String? {
        didSet {
            validatePhoneNumber()
        }
    }
    
    private let userService: UserService
    
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())

    var email: String? {
        didSet{
            validateEmail()
        }
    }
    
    var password: String? {
        didSet {
            validatePassword()
        }
    }
    
    var username: String? {
        didSet {
            validateUsername()
        }
    }
    
    var fullName: String? {
        didSet{
            validateFullname()
        }
    }
    
    var confirm: String?{
        didSet{
            validateConfirm()
        }
    }
    
    var navigate: (() -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    /**
     Validation for password field
     */
    func validatePassword() {
        if password == nil || !ValidatorHelper.minLength(password){
            errorMessages.value[SignInViewModelKey.PASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(password,minLength: 6) || !ValidatorHelper.maxLength(password, maxLength: 20){
             errorMessages.value[SignInViewModelKey.PASSWORD] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: SignInViewModelKey.PASSWORD)
        }
    }
    
    /**
     Validation for email field
     */
    func validateEmail() {
        if email == nil || !ValidatorHelper.minLength(email) {
            errorMessages.value[SignInViewModelKey.EMAIL] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorEmailRequired) ?? ""
        }
        else if !ValidatorHelper.isValidEmail(email){
            errorMessages.value[SignInViewModelKey.EMAIL] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorEmailInvalid) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: SignInViewModelKey.EMAIL)
        }
    }
    
    /**
     Validate Username
    */
    func validateUsername(){
        if username == nil || !ValidatorHelper.minLength(username) {
            errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorUserNameRequired ) ?? ""
        }
        else if username?.containsWhitespace ?? false {
             errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorUserNameInvalid) ?? ""
        }
        else if CommonService.isFirstInitialized() && (username ?? "").isSpecialCharacter(){
            debugPrint(CommonService.getCurrentSignUpUsername() ?? "")
            errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] =  LanguageHelper.getTranslationByKey(LanguageKey.UsernameCouldNotContainSpecialCharacter) ?? ""
        }
        else if !ValidatorHelper.minLength(username,minLength: 3) || !ValidatorHelper.maxLength(username, maxLength: 18){
            errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorUserNameInvalid ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: SignInViewModelKey.ACCOUNTNUMBER)
        }
    }
    
    /**
     ValidateFullname
    */
    func validateFullname(){
        if fullName == nil || !ValidatorHelper.minLength(fullName,minLength: 3) {
            errorMessages.value[SignInViewModelKey.FULLNAME] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorFullNameRequired ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: SignInViewModelKey.FULLNAME)
        }
    }
    
    /**
     ValidateId
    */
    func validateId(){
        if id == nil || !ValidatorHelper.minLength(id) {
            errorMessages.value[SignInViewModelKey.ID] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorIdRequired ) ?? ""
        }
        
        else if !ValidatorHelper.minLength(id, minLength: 9) || !ValidatorHelper.maxLength(id, maxLength: 12) || id?.count == 10 || id?.count == 11{
            errorMessages.value[SignInViewModelKey.ID] =  LanguageHelper.getTranslationByKey(LanguageKey.IdMustBeDigitNumber) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: SignInViewModelKey.ID)
        }
    }
    
    /**
     ValidatePhonenumber
    */
    func validatePhoneNumber(){
        if phoneNumber == nil || !ValidatorHelper.minLength(phoneNumber) {
            errorMessages.value[SignInViewModelKey.PhoneNumber] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPhoneNumberRequired) ?? ""
        }
        else if !ValidatorHelper.minLength(phoneNumber, minLength: 10) || !ValidatorHelper.maxLength(phoneNumber, maxLength: 10){
            errorMessages.value[SignInViewModelKey.PhoneNumber] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPhoneNumberInvalid) ?? ""
        }
        else {
            debugPrint("Verified phone number...")
            errorMessages.value.removeValue(forKey: SignInViewModelKey.PhoneNumber)
        }
    }
    
    /**
     ValidateConfirm
     */
    func validateConfirm(){
        if confirm == nil || !ValidatorHelper.minLength(confirm) {
            errorMessages.value[SignInViewModelKey.CONFIRM] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorConfirmRequired ) ?? ""
        }
        else if !ValidatorHelper.minLength(confirm,minLength: 6) || !ValidatorHelper.maxLength(confirm, maxLength: 20){
            errorMessages.value[SignInViewModelKey.CONFIRM] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordLength ) ?? ""
        }
        else if password != confirm {
            errorMessages.value[SignInViewModelKey.CONFIRM] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorPasswordDoNotMatch ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: SignInViewModelKey.CONFIRM)
        }
    }
    
    /**
     do login
     */
    func doLogin() {
        validatePassword()
        validateUsername()
        if ( errorMessages.value.count > 0 ) {
            return
        }
        let encypted = password?.elGamalEncrypt(receiverPublickey: CipherKey.PublicServerKey)
        guard let encryptedPassword = encypted else  {
            debugPrint("Error created encrypt value")
            return
        }
        guard let finalPassword = CommonService.getValueFromArray(data: encryptedPassword, insert: "$") else{
            debugPrint("Error created final password")
            return
        }
        self.finalPassword = finalPassword
        debugPrint("Final password \(finalPassword)")
        showLoading.value = true
        let user = SignInRequestModel(channelCode: EnumChannelName.MB001.rawValue, functionCode: EnumFunctionName.SIGN_IN_USER.rawValue , terminalId: CommonService.getUniqueId(), token: finalPassword , transactionId: "", username: username ?? "" , uuid: CommonService.getUniqueId())
        //Utils.logMessage(object: user)
        userService.signIn(data: user) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                       Utils.logMessage(object: response)
                     if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        CommonService.setSignInData(storeInfo: SignInStoreModel(data: response.responseData))
                        self.responseToView!(EnumResponseToView.SIGN_IN_SUCCESS.rawValue)
                     }
                     else if response.responseCode == EnumResponseCode.USER_NOT_ACTIVE.rawValue{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                                self.responseToView!(EnumResponseToView.USER_NOT_ACTIVE.rawValue)
                            })
                        )
                        self.onShowError?(okAlert)
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
     Checking existing value
    */
    func isCanUse()->Bool {
        let value = existingValue.value
        if value.name == "" {
            return true
        }
        return false
    }
    
    /**
     Checking idNumber and Phone number
     */
    func doCheckingIdNumberAndPhoneNumber(){
        validateId()
        validatePhoneNumber()
        showLoading.value = true
        let data = CheckExistingUserRequestModel(channelCode: EnumChannelName.MB001.rawValue, functionCode: EnumFunctionName.CHECKING_ID_NUMBER_PHONE_NUMBER.rawValue, idNumber: id ?? "",personMobilePhone: phoneNumber ?? "")
        userService.checkingIdnumberAndPhoneNumber(data: data) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        if let mResponseHandle = self.checkParamsResponse(data: response){
                               self.existingValue.value = mResponseHandle
                        }
                    }else{
                        self.existingValue.value = AlertData(codeAction: "",name: "", nameValue: "", message: "")
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
    
    func checkParamsResponse(data : CheckExistingUserResponseModel) -> AlertData? {
        let responseChecking = data.responseData
        if responseChecking.idNumber != ""{
            return AlertData(codeAction: EnumResponseAction.ERROR_IDNUMBER_PHONENUMBER.rawValue,name: LanguageHelper.getTranslationByKey(LanguageKey.IdNumber), nameValue: self.id ?? "", message: LanguageHelper.getTranslationByKey(LanguageKey.AlreadyExisted)?.lowercased())
        }
        else if responseChecking.personMobilePhone != "" {
            return AlertData(codeAction: EnumResponseAction.ERROR_IDNUMBER_PHONENUMBER.rawValue,name: LanguageHelper.getTranslationByKey(LanguageKey.PhoneNumber), nameValue: self.phoneNumber ?? "", message: LanguageHelper.getTranslationByKey(LanguageKey.AlreadyExisted)?.lowercased())
        }
        return nil
    }
    
    /**
     Checking username
     */
    func doCheckingUsername(){
        validateUsername()
        showLoading.value = true
        let data = CheckExistingUserRequestModel(channelCode: EnumChannelName.MB001.rawValue, functionCode: EnumFunctionName.CHECKING_USERNAME.rawValue, username : username ?? "")
        userService.checkingUsername(data: data) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                     if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                         self.existingValue.value =  AlertData(codeAction : EnumResponseAction.EXISTING_USERNAME.rawValue,name: LanguageHelper.getTranslationByKey(LanguageKey.Username), nameValue: self.username ?? "", message: response.responseMessage)
                     }else if  response.responseCode == EnumResponseCode.USER_IS_NOT_EXISTED.rawValue {
                          self.existingValue.value = AlertData(codeAction : "" ,name: "", nameValue: "", message: "")
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
     Sign Up
    */
    func doSignUp(){
        validateUsername()
        validateFullname()
        validateId()
        validatePhoneNumber()
        validatePassword()
        validateConfirm()
        if ( errorMessages.value.count > 0 ) {
            return
        }
        let name = fullName?.toSeparatedName()
        guard let nameObject = name else {
            return
        }
        let encypted = password?.elGamalEncrypt(receiverPublickey: CipherKey.PublicServerKey)
        guard let encryptedPassword = encypted else  {
            debugPrint("Error created encrypt value")
            return
        }
        
        guard let key = ELGamalHelper.instance.generateECKey() else {
                   debugPrint("Error created key")
                   return
        }

        guard let finalPassword = CommonService.getValueFromArray(data: encryptedPassword, insert: "$") else{
            debugPrint("Error created final password")
            return
        }
        self.finalPassword = finalPassword
        debugPrint("Ready")
        debugPrint(key)
        debugPrint("Final password \(finalPassword)")
        let data = SignUpRequestModel(channelCode: EnumChannelName.MB001.rawValue, functionCode: EnumFunctionName.SIGN_UP_USER.rawValue, idNumber: id ?? "", keyPublicAlias: "\(username ?? "")001", ecKeyPublicValue: key.publicKey ?? "", nickname: "\(username ?? "")", password: finalPassword, personFirstName: nameObject.firstName ?? "", personLastName: nameObject.lastName ?? "", personMiddleName: nameObject.middleName ?? "", personMobilePhone: phoneNumber ?? "", terminalId: CommonService.getUniqueId(), terminalInfo: DeviceHelper.getDeviceInfo(), username: username ?? "")
        self.showLoading.value = true
        userService.signUp(data: data) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    var codeAction = ""
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        codeAction = EnumResponseAction.CREATED_SUCCESSFULLY.rawValue
                        CommonService.setKeychainData(storeInfo: KeychainDeviceStoreModel(data: key))
                        CommonService.setSignUpData(storeInfo: SignUpStoreModel(data: response.responseData,request: data))
                    }else{
                        codeAction = EnumResponseAction.ERROR.rawValue
                    }
                    self.existingValue.value =  AlertData(codeAction : codeAction,name: LanguageHelper.getTranslationByKey(LanguageKey.Username), nameValue: self.username ?? "", message: response.responseMessage)
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
     Active account
    */
    func doActiveAccount(){
        debugPrint("Active account")
        showLoading.value = true
        guard let mOTPCode = otpCode else {
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                message: LanguageHelper.getTranslationByKey(LanguageKey.ErrorOTPRequest),
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
            )
            self.onShowError?(okAlert)
            return
        }
        
        var data = ActiveAccountRequestModel(otpValue: mOTPCode)
        if let mIsSignIn = isSignIn{
            if mIsSignIn{
                 data = ActiveAccountRequestModel(otpValue: mOTPCode, transactionCode: transactionCode ?? "0")
            }
        }
        userService.activeAccount(data: data) { result  in
        self.showLoading.value = false
        switch result {
        case .success(let userResult):
                if let response = userResult{
                     Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        Utils.logMessage(object: response)
                        CommonService.setActiveAccountData(storeInfo: ActiveAccountStoreModel(data: response.responseData))
                        self.responseToView!(EnumResponseToView.ACTIVE_SUCCESS.rawValue)
                    }
                    else if response.responseCode == EnumResponseCode.OTP_INVALID.rawValue {
                         self.responseToView!(EnumResponseToView.OTP_INVALID.rawValue)
                    }
                    else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                            message: response.responseMessage,
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                                self.responseToView!(EnumResponseToView.OTP_INVALID.rawValue)
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
        self.phoneNumberBinding.value = data.personMobilePhone ?? ""
        self.fullNameBinding.value = "\(data.personFirstName ?? "") \(data.personMiddleName ?? "") \(data.personLastName ?? "")"
        if let mAvatar = CommonService.getLargeAvatar() {
            avatarBinding.value = mAvatar.doConvertBase64StringToImage()
        }
    }
    
    
    func doResendOTP(){
        debugPrint("Active account")
        showLoading.value = true
        userService.resendOTP(data: ReSendOTPRequestModel(finalPassword: self.finalPassword)) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        Utils.logMessage(object: response)
                        self.transactionCode = response.responseData.transactionCode?.description ?? "0"
                        self.responseToView!(EnumResponseToView.RESEND_OTP_CODE.rawValue)
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                                         action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") }))
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
    
    func checkContactPermission(){
        GrantPermission.checkContactPermission { (data) in
            switch (data){
            case .authorized:
                debugPrint("authorized")
                self.requestContactPermission()
                break
            case .denied:
                self.openAppSetting()
                debugPrint("denied")
                break
            case .notDetermined:
                 self.requestContactPermission()
                 debugPrint("notDetermined")
                break
            case .restricted:
                debugPrint("restricted")
                break
            default :
                break
            }
        }
    }
    
    func requestContactPermission(){
        GrantPermission.requestContactPermission { (data) in
            if data {
                if let mValue =  ContactHelper.instance.getContact(){
                    debugPrint("getContact...")
                    Utils.logMessage(object: mValue)
                }
            }
        }
    }
    
    func openAppSetting() {
        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}
