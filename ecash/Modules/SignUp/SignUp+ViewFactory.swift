//
//  SignUp+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension SignUpVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        lbTitle.textAlignment = .center
        lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.SignUp)
        lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        lbTitle.textColor = AppColors.BLUE
        textFieldUsername.lineColor = AppColors.GRAY_COLOR
        textFieldUsername.selectedLineColor = AppColors.GRAY
        textFieldUsername.selectedTitleColor = AppColors.GRAY
        textFieldUsername.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.AccountNumber)
        textFieldFullName.lineColor = AppColors.GRAY_COLOR
        textFieldFullName.selectedLineColor = AppColors.GRAY
        textFieldFullName.selectedTitleColor = AppColors.GRAY
        textFieldFullName.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.FullName)
        
        textFieldId.lineColor = AppColors.GRAY_COLOR
        textFieldId.selectedLineColor = AppColors.GRAY
        textFieldId.selectedTitleColor = AppColors.GRAY
        textFieldId.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterId)
        textFieldId.keyboardType = .numberPad
        
        textFieldPhoneNumber.lineColor = AppColors.GRAY_COLOR
        textFieldPhoneNumber.selectedLineColor = AppColors.GRAY
        textFieldPhoneNumber.selectedTitleColor = AppColors.GRAY
        textFieldPhoneNumber.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterPhoneNumber)
        textFieldPhoneNumber.keyboardType = .numberPad
        
        textFieldPassword.lineColor = AppColors.GRAY_COLOR
        textFieldPassword.selectedLineColor = AppColors.GRAY
        textFieldPassword.selectedTitleColor = AppColors.GRAY
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.Password)
        textFieldConfirmPassword.lineColor = AppColors.GRAY_COLOR
        textFieldConfirmPassword.selectedLineColor = AppColors.GRAY
        textFieldConfirmPassword.selectedTitleColor = AppColors.GRAY
        textFieldConfirmPassword.isSecureTextEntry = true
        textFieldConfirmPassword.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.ConfirmPassWord)
        btnSignUp.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.SignUp), for: .normal)
        btnSignUp.addTarget(self, action: #selector(actionSignUp), for: .touchUpInside)
        btnSignUp.setTitleColor(.white, for: .normal)
        btnSignUp.cornerButton(corner: 3, color: AppColors.BLUE)
        addTarget(textFieldUsername)
        addTarget(textFieldFullName)
        addTarget(textFieldId)
        addTarget(textFieldPhoneNumber)
        addTarget(textFieldPassword)
        addTarget(textFieldConfirmPassword)
    }
    
    func bindingViewModel() {
        btnSignUp.isEnabled = false
        btnSignUp.alpha = AppConstants.ALPHA_DISBALE
        viewModel?.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldUsername.errorMessage = errors[SignInViewModelKey.ACCOUNTNUMBER] ?? ""
                self?.textFieldFullName.errorMessage = errors[SignInViewModelKey.FULLNAME] ?? ""
                self?.textFieldId.errorMessage = errors[SignInViewModelKey.ID] ?? ""
                self?.textFieldPhoneNumber.errorMessage = errors[SignInViewModelKey.PhoneNumber] ?? ""
                self?.textFieldPassword.errorMessage = errors[SignInViewModelKey.PASSWORD] ?? ""
                self?.textFieldConfirmPassword.errorMessage = errors[SignInViewModelKey.CONFIRM] ?? ""
                self?.btnSignUp.isEnabled = false
                self?.btnSignUp.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0{
                    self?.textFieldUsername.errorMessage = ""
                    self?.textFieldFullName.errorMessage = ""
                    self?.textFieldId.errorMessage = ""
                    self?.textFieldPhoneNumber.errorMessage = ""
                    self?.textFieldPassword.errorMessage = ""
                    self?.textFieldConfirmPassword.errorMessage = ""
                    self?.btnSignUp.isEnabled = true
                    self?.btnSignUp.alpha = AppConstants.ALPHA_DEFAULT
                }
            }
        })
        viewModel?.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        viewModel?.navigate = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        viewModel?.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        viewModel.existingValue.bind { value in
            if !self.viewModel.isCanUse(){
                let data = PassDataViewModel(identifier: EnumPassdata.ALERT, alert: value)
                ShareSignUpSingleton.shared.set(value: data)
                Navigator.pushViewMainStoryboard(from: self, identifier: Controller.alert, isNavigation: false,isTransparent: true, present: true)
            }
        }
        
        ShareSignUpSingleton.shared.bind{ [weak self] in
            debugPrint("ShareSignUpSingleton.shared.bind")
            if let data = ShareSignUpSingleton.shared.get(value: PassDataViewModel.self){
                if data.identifier == EnumPassdata.SIGNUP_RESPONSE.rawValue {
                    if data.signUp.navigation == EnumResponseAction.EXISTING_USERNAME.rawValue {
                        DispatchQueue.main.async {
                           self!.dismiss()
                        }
                    }
                    else if data.signUp.navigation == EnumResponseAction.CREATED_SUCCESSFULLY.rawValue {
                          debugPrint("data.signUp.navigation == EnumResponseAction.CREATED_SUCCESSFULLY.rawValue")
                        DispatchQueue.main.async {
                            self?.showAlert()
                        }
                    }
                }
            }
        }
      
        viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.ACTIVE_SUCCESS.rawValue {
                self?.dismiss()
            }
            else if value == EnumResponseToView.OTP_INVALID.rawValue {
                self?.showAlert()
            }
        }
        
        self.viewModel.errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] = ""
        self.viewModel.errorMessages.value[SignInViewModelKey.FULLNAME] = ""
        self.viewModel.errorMessages.value[SignInViewModelKey.ID] = ""
        self.viewModel.errorMessages.value[SignInViewModelKey.PhoneNumber] = ""
        self.viewModel.errorMessages.value[SignInViewModelKey.PASSWORD] = ""
        self.viewModel.errorMessages.value[SignInViewModelKey.CONFIRM] = ""
    }
    
    func showAlert(){
        showInputDialog(title: LanguageHelper.getTranslationByKey(LanguageKey.AddOTP),
                              subtitle:LanguageHelper.getTranslationByKey(LanguageKey.PleaseEnterTheOTPCode) ,
                              actionTitle: LanguageHelper.getTranslationByKey(LanguageKey.Active),
                              cancelTitle: LanguageHelper.getTranslationByKey(LanguageKey.Cancel),
                              inputPlaceholder: LanguageHelper.getTranslationByKey(LanguageKey.OTPCode),
                              inputKeyboardType: .numberPad)
        { (input:String?) in
            self.viewModel.otpCode = input
            self.viewModel.doActiveAccount()
        }
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    
}

extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldUsername.delegate = self
        self.textFieldFullName.delegate = self
        self.textFieldId.delegate = self
        self.textFieldPhoneNumber.delegate = self
        self.textFieldPassword.delegate = self
        self.textFieldConfirmPassword.delegate = self
    }
}

extension SignUpVC : SingleButtonDialogPresenter {
    
}


