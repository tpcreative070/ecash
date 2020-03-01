//
//  EditProfileViewModel.swift
//  ecash
//
//  Created by phong070 on 12/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
struct EditProfileViewModelKey {
    public static let FULLNAME = "fullname"
    public static let ADDRESS = "address"
    public static let IDNUMBER = "idNumber"
    public static let EMAIL = "email"
}
class EditProfileViewModel : EditProfileViewModelDelegate  {
    
    var avatarBinding: Bindable<UIImage> = Bindable(UIImage())
    var responseToView: ((String) -> ())?
    
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String,String>())
    
    var fullNameBinding: Bindable<String> = Bindable("")
    
    var addressBinding: Bindable<String> = Bindable("")
    
    var idNumberBinding: Bindable<String> = Bindable("")
    
    var emailBinding: Bindable<String> = Bindable("")
    
    var fullName: String? {
        didSet{
            validateFullname()
        }
    }
    
    var address: String? {
        didSet {
            validateAddress()
        }
    }
    
    var idNumber: String?{
        didSet {
            validateIdNumber()
        }
    }
    
    var email: String?{
        didSet{
            validateEmail()
        }
    }
    
    /**
        ValidateFullname
    */
    func validateFullname(){
        if fullName == nil || !ValidatorHelper.minLength(fullName) {
            errorMessages.value[EditProfileViewModelKey.FULLNAME] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorFullNameRequired) ?? ""
        }
        else {
            debugPrint("Verified phone number...")
            errorMessages.value.removeValue(forKey: EditProfileViewModelKey.FULLNAME)
        }
    }
    
    /**
          ValidateFullname
      */
      func validateAddress(){
          if address == nil || !ValidatorHelper.minLength(address) {
            errorMessages.value[EditProfileViewModelKey.ADDRESS] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorAddressRequired) ?? ""
          }
          else {
              debugPrint("Verified phone number...")
            errorMessages.value.removeValue(forKey: EditProfileViewModelKey.ADDRESS)
          }
    }
    
    /**
       Validation for email field
       */
      func validateEmail() {
          if email == nil || !ValidatorHelper.minLength(email) {
              errorMessages.value[EditProfileViewModelKey.EMAIL] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorEmailRequired) ?? ""
          }
          else if !ValidatorHelper.isValidEmail(email){
              errorMessages.value[EditProfileViewModelKey.EMAIL] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorEmailInvalid) ?? ""
          }
          else {
              errorMessages.value.removeValue(forKey: EditProfileViewModelKey.EMAIL)
          }
      }
    
    /**
       ValidateId
      */
      func validateIdNumber(){
          if idNumber == nil || !ValidatorHelper.minLength(idNumber) {
              errorMessages.value[SignInViewModelKey.ID] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorIdRequired ) ?? ""
          }
          
          else if !ValidatorHelper.minLength(idNumber, minLength: 9) || !ValidatorHelper.maxLength(idNumber, maxLength: 12) || idNumber?.count == 10 || idNumber?.count == 11{
            errorMessages.value[EditProfileViewModelKey.IDNUMBER] =  LanguageHelper.getTranslationByKey(LanguageKey.IdMustBeDigitNumber) ?? ""
          }
          else {
              errorMessages.value.removeValue(forKey: EditProfileViewModelKey.IDNUMBER)
          }
      }
       
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    private let userService: UserService
    init(userService: UserService = UserService()) {
        self.userService = userService
    }
    
    
    
    /**
        do edit profile
    */
    func doEditProfile() {
        validateFullname()
        validateAddress()
        validateIdNumber()
        validateEmail()
        
        if ( errorMessages.value.count > 0 ) {
            return
        }
        
        let name = fullName?.toSeparatedName()
        guard let nameObject = name else {
            return
        }
        
        showLoading.value = true
        userService.editProfile(data : EditProfileRequestModel(firstName: nameObject.firstName ?? "", middleName: nameObject.middleName ?? "", lastName: nameObject.lastName ?? "", email: email ?? "", address: address ?? "",mIdNumber: idNumber ?? "")) { result  in
               self.showLoading.value = false
               switch result {
               case .success(let userResult):
                   if let response = userResult{
                       Utils.logMessage(object: response)
                       if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                           self.responseToView!(EnumResponseToView.EDITED_PROFILE_SUCCESSFULLY.rawValue)
                        if var mSignUpData = CommonService.getSignUpStoreData(){
                            mSignUpData.personFirstName = nameObject.firstName ?? ""
                            mSignUpData.personMiddleName = nameObject.middleName ?? ""
                            mSignUpData.personLastName = nameObject.lastName ?? ""
                            mSignUpData.personCurrentAddress = self.address ?? ""
                            mSignUpData.idNumber = self.idNumber ?? ""
                            mSignUpData.personEmail = self.email ?? ""
                            CommonService.setSignUpData(storeInfo: mSignUpData)
                        }
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Success) ?? "Success",
                            message: LanguageHelper.getTranslationByKey(LanguageKey.UpdatedSuccessfully),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                                self.responseToView!(EnumResponseToView.UPDATED_SUCCESSFULLY.rawValue)
                            })
                        )
                        self.onShowError?(okAlert)
                       }else{
                           let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message:  LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0",param: self.idNumber ?? ""),
                               action: AlertAction(buttonTitle: "Ok", handler: {
                                   print("Ok pressed!")
                               })
                           )
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
           do edit profile
       */
    func doUploadProfile(data : GalleryOptionsData) {
           showLoading.value = true
           userService.uploadAvatar(data : UploadAvatarRequestModel(data: data)) { result  in
                  self.showLoading.value = false
                  switch result {
                  case .success(let userResult):
                      if let response = userResult{
                          Utils.logMessage(object: response)
                          if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                            if let mSignInData = CommonService.getSignInData(){
                                mSignInData.large = data.bIconLarge
                                mSignInData.medium = data.bIconMedium
                                mSignInData.small = data.bIconSmall
                                CommonService.setSignInData(storeInfo: mSignInData)
                            }
                          }else{
                              let okAlert = SingleButtonAlert(
                                title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                  message: userResult?.responseMessage,
                                  action: AlertAction(buttonTitle: "Ok", handler: {
                                      print("Ok pressed!")
                                  })
                              )
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
    
    func doBindingUpdate(){
        guard let mSignUpData = CommonService.getSignUpStoreData() else {
            return
        }
        self.fullNameBinding.value = "\(mSignUpData.personFirstName ?? "") \(mSignUpData.personMiddleName ?? "") \(mSignUpData.personLastName ?? "")"
        
        if mSignUpData.personCurrentAddress != "" && mSignUpData.personCurrentAddress != nil{
             self.addressBinding.value = mSignUpData.personCurrentAddress ?? "Null"
        }
        
        if mSignUpData.personEmail != "" && mSignUpData.personEmail != nil{
            self.emailBinding.value = mSignUpData.personEmail ?? "Null"
        }
        self.idNumberBinding.value = mSignUpData.idNumber ?? ""
        if let mAvatar = CommonService.getLargeAvatar() {
            avatarBinding.value = mAvatar.doConvertBase64StringToImage()
        }
    }
    
}
