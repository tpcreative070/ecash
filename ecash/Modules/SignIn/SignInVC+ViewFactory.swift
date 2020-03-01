//
//  SignInVC+ViewFactory.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension SignInVC {
    func initUI(){
        imgLogo.image = UIImage(named: AppImages.IC_LOGO)
        textFieldEmail.lineColor = AppColors.GRAY_COLOR
        textFieldEmail.selectedLineColor = AppColors.GRAY
        textFieldEmail.selectedTitleColor = AppColors.GRAY
        textFieldEmail.iconType = .image
        textFieldEmail.iconMarginLeft = 10
        textFieldEmail.iconImage = UIImage(named: AppImages.IC_USER)
        textFieldEmail.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.AccountNumber)
        textFieldPassword.lineColor = AppColors.GRAY_COLOR
        textFieldPassword.selectedLineColor = AppColors.GRAY
        textFieldPassword.selectedTitleColor = AppColors.GRAY
        textFieldPassword.iconType = .image
        textFieldPassword.iconMarginLeft = 10
        textFieldPassword.iconImage = UIImage(named: AppImages.IC_PASSWORD)
        textFieldPassword.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.PasswordPlaceHolder)
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        onSignInAction.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.SignInButton), for: .normal)
        onSignInAction.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        onSignInAction.setTitleColor(.white, for: .normal)
        onSignInAction.cornerButton(corner: 3, color: AppColors.BLUE)
        viewSignUp.setRadius(corner: 3, color: AppColors.GRAY)
        lbCouldNotSignIn.textAlignment = .right
        lbCouldNotSignIn.text = "\(LanguageHelper.getTranslationByKey(LanguageKey.ForgotPassword) ?? "")?"
        lbCouldNotSignIn.textColor = AppColors.GRAY
        lbCouldNotSignIn.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.FLOAT_LABEL_FONT_SIZE - 4)
        lbNoAccount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.FLOAT_LABEL_FONT_SIZE - 4)
        lbSignUpNow.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.FLOAT_LABEL_FONT_SIZE - 2)
        lbNoAccount.text = LanguageHelper.getTranslationByKey(LanguageKey.DoNotHaveAnAccount)
        lbSignUpNow.text = LanguageHelper.getTranslationByKey(LanguageKey.SignUpNow)
        
        lbFullname.textAlignment = .center
        lbFullname.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.FLOAT_LABEL_FONT_SIZE)
        
        lbPhoneNumber.textAlignment = .center
        lbPhoneNumber.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.FLOAT_LABEL_FONT_SIZE)
        
        self.imgAvatar.image = UIImage(named: AppImages.IC_AVATAR)
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.borderColor = .clear

        addTarget(textFieldEmail)
        addTarget(textFieldPassword)
        viewSignUp.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionSignUp(sender:))))
        lbCouldNotSignIn.isUserInteractionEnabled = true
        lbCouldNotSignIn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionCouldNotSignIn(sender:))))
    }
    
    func bindingViewModel() {
        onSignInAction.isEnabled = false
        onSignInAction.alpha = AppConstants.ALPHA_DISBALE
        viewModel?.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldEmail.errorMessage = errors[SignInViewModelKey.ACCOUNTNUMBER] ?? ""
                self?.textFieldPassword.errorMessage = errors[SignInViewModelKey.PASSWORD] ?? ""
                self?.onSignInAction.isEnabled = false
                self?.onSignInAction.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0 {
                    self?.textFieldEmail.errorMessage = ""
                    self?.textFieldPassword.errorMessage = ""
                    self?.onSignInAction.isEnabled = true
                    self?.onSignInAction.alpha = AppConstants.ALPHA_DEFAULT
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
        
        viewModel?.responseToView = {[weak self] value in
            if value == EnumResponseToView.SIGN_IN_SUCCESS.rawValue {
                debugPrint("Dismiss sigin...")
                if CommonService.checkCountCash(){
                    if CommonService.checkCashLogs() && CommonService.checkTransactionsLogs() {
                        CommonService.bindingHomeData()
                        self?.dismiss()
                        GlobalRequestApiHelper.shared.getDenomination()
                    }else{
                        self?.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.ErrorOccurredLocalDB) ?? "")
                    }
                }else{
                    CommonService.bindingHomeData()
                    self?.dismiss()
                    GlobalRequestApiHelper.shared.getDenomination()
                }
            }
            else if value == EnumResponseToView.RESEND_OTP_CODE.rawValue {
                self?.showAlert()
            }
            else if value == EnumResponseToView.ACTIVE_SUCCESS.rawValue {
               self?.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.ActiveSuccessful) ?? "")
            }
            else if value  == EnumResponseToView.OTP_INVALID.rawValue {
                self?.showAlert()
            }
            else if value == EnumResponseToView.USER_NOT_ACTIVE.rawValue {
                self?.doAlertMessage(message: LanguageHelper.getTranslationByKey(LanguageKey.USER_NOT_ACTIVE) ?? "Your account has not been actived. Please active")
            }
        }
        
        viewModel?.readOnlyUsernameBinding.bind { data in
            if data {
               self.viewModel?.errorMessages.value.removeValue(forKey : SignInViewModelKey.ACCOUNTNUMBER)
               self.constraintView.constant = 150
               self.viewAlreadyExisted.isHidden = false
               self.viewSignUp.isHidden = true
               self.textFieldEmail.isHidden = true
               self.constraintUsername.constant = 0
            }else{
               self.viewModel?.errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] = ""
               self.constraintView.constant = 20
               self.viewAlreadyExisted.isHidden = true
               self.viewSignUp.isHidden = false
               self.textFieldEmail.isHidden = false
               self.constraintUsername.constant = 50
            }
        }
        
        viewModel?.userNameBinding.bind({ (value) in
            self.textFieldEmail.isEnabled = false
            self.textFieldEmail.text = value
            self.viewModel?.username = value
        })
        
        viewModel?.fullNameBinding.bind({ (value) in
            self.lbFullname.text = value
        })
        
        viewModel?.phoneNumberBinding.bind({ (value) in
            self.lbPhoneNumber.text = value
        })
        viewModel?.avatarBinding.bind({ (value) in
            self.imgAvatar.image = value
        })
        
        self.viewModel?.errorMessages.value[SignInViewModelKey.ACCOUNTNUMBER] = ""
        self.viewModel?.errorMessages.value[SignInViewModelKey.PASSWORD] = ""
        self.viewModel?.isSignIn = true
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func showAlert(){
        showInputDialog(title: LanguageHelper.getTranslationByKey(LanguageKey.AddOTP),
                        subtitle:LanguageHelper.getTranslationByKey(LanguageKey.PleaseEnterTheOTPCode) ,
                        actionTitle: LanguageHelper.getTranslationByKey(LanguageKey.Active),
                        cancelTitle: LanguageHelper.getTranslationByKey(LanguageKey.Cancel),
                        inputPlaceholder: LanguageHelper.getTranslationByKey(LanguageKey.OTPCode),
                        inputKeyboardType: .numberPad)
        { (input:String?) in
            self.viewModel?.otpCode = input
            self.viewModel?.doActiveAccount()
        }
    }
    
    func defineValue(){
        self.viewModel?.username = textFieldEmail.text
        self.viewModel?.password = textFieldPassword.text
    }
}

extension SignInVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldEmail.delegate = self
        self.textFieldPassword.delegate = self
    }
}

extension SignInVC: SingleButtonDialogPresenter { }
