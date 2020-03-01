//
//  RecoverPasswordVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension RecoverPasswordVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        lbTitle.textAlignment = .center
        lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.RecoverPassword)?.uppercased()
        lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        lbTitle.textColor = AppColors.BLUE
        
        textFieldOTP.keyboardType = .numberPad
        textFieldOTP.lineColor = AppColors.GRAY_COLOR
        textFieldOTP.selectedLineColor = AppColors.GRAY
        textFieldOTP.selectedTitleColor = AppColors.GRAY
        textFieldOTP.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterOTPCode)
        
        textFieldNewPassword.lineColor = AppColors.GRAY_COLOR
        textFieldNewPassword.selectedLineColor = AppColors.GRAY
        textFieldNewPassword.selectedTitleColor = AppColors.GRAY
        textFieldNewPassword.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterNewPassword)
        
        textFieldConfirmPassword.lineColor = AppColors.GRAY_COLOR
        textFieldConfirmPassword.selectedLineColor = AppColors.GRAY
        textFieldConfirmPassword.selectedTitleColor = AppColors.GRAY
        textFieldConfirmPassword.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.ConfirmPassWord)
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify)?.uppercased(), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        
        btnResend.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Resend)?.uppercased(), for: .normal)
        btnResend.addTarget(self, action: #selector(actionResend), for: .touchUpInside)
        btnResend.setTitleColor(AppColors.BLUE, for: .normal)
        btnResend.setRadius(corner: 3, color: AppColors.BLUE)
    
        addTarget(textFieldOTP)
        addTarget(textFieldNewPassword)
        addTarget(textFieldConfirmPassword)
    
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldOTP.errorMessage = errors[ForgotPasswordViewModelKey.OTPCODE] ?? ""
                self?.textFieldNewPassword.errorMessage = errors[ForgotPasswordViewModelKey.NEWPASSWORD] ?? ""
                self?.textFieldConfirmPassword.errorMessage = errors[ForgotPasswordViewModelKey.CONFIRMPASSWORD] ?? ""
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0{
                    self?.textFieldOTP.errorMessage = ""
                    self?.textFieldNewPassword.errorMessage = ""
                    self?.textFieldConfirmPassword.errorMessage = ""
                    self?.btnVerify.isEnabled = true
                    self?.btnVerify.alpha = AppConstants.ALPHA_DEFAULT
                }
            }
        })
        viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        
        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        
        viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATED_FORGOT_PASSWORD_SUCCESSFULLY.rawValue{
                CommonService.sendDataToUpdatedForgotPasswordCompleted(data: ForgotPasswordShareData(title: LanguageHelper.getTranslationByKey(LanguageKey.RecoverPasswordSuccessfully)), isResponse: false)
                Navigator.pushViewMainStoryboard(from: self!, identifier: Controller.destroyWalletSuccessfulOptions, isNavigation: false, isTransparent: true, present: true)
            }
        }
        
        
        ShareForgotPasswordSingleton.shared.bind {
            if let mData = CommonService.getShareUpdatedForgotPasswordCompleted(){
                CommonService.sendDataToUpdatedForgotPasswordCompleted(data: mData, isResponse: false)
                DispatchQueue.main.async {
                    self.dismiss()
                }
            }
        }
        
        self.viewModel.errorMessages.value[ForgotPasswordViewModelKey.NEWPASSWORD] = ""
        self.viewModel.errorMessages.value[ForgotPasswordViewModelKey.CONFIRMPASSWORD] = ""
        self.viewModel.errorMessages.value[ForgotPasswordViewModelKey.OTPCODE] = ""
        self.viewModel.doGetIntent()
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func defineValue(){
        self.viewModel.newPassword = textFieldNewPassword.text
        self.viewModel.confirmPassword = textFieldConfirmPassword.text
        self.viewModel.otpCode = textFieldOTP.text
    }
    
}

extension RecoverPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldNewPassword.delegate = self
        self.textFieldConfirmPassword.delegate = self
        self.textFieldOTP.delegate = self
    }
}

extension RecoverPasswordVC : SingleButtonDialogPresenter {
    
}

