//
//  ChangePasswordVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ChangePasswordVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        lbTitle.textAlignment = .center
        lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ChangePassword)?.uppercased()
        lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        lbTitle.textColor = AppColors.BLUE
        textFieldOldPassword.lineColor = AppColors.GRAY_COLOR
        textFieldOldPassword.selectedLineColor = AppColors.GRAY
        textFieldOldPassword.selectedTitleColor = AppColors.GRAY
        textFieldOldPassword.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterOldPassword)
        
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
        addTarget(textFieldOldPassword)
        addTarget(textFieldNewPassword)
        addTarget(textFieldConfirmPassword)
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldOldPassword.errorMessage = errors[ChangePasswordViewModelKey.OLDPASSWORD] ?? ""
                self?.textFieldNewPassword.errorMessage = errors[ChangePasswordViewModelKey.NEWPASSWORD] ?? ""
                self?.textFieldConfirmPassword.errorMessage = errors[ChangePasswordViewModelKey.CONFIRMPASSWORD] ?? ""
              
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0{
                    self?.textFieldOldPassword.errorMessage = ""
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
            if value == EnumResponseToView.CHANGED_PASSWORD_SUCCESSFULLY.rawValue{
                self?.dismiss()
                CommonService.eventPushActionToView(data: EnumResponseToView.CHANGED_PASSWORD_SUCCESSFULLY)
            }
        }
        
        self.viewModel.errorMessages.value[ChangePasswordViewModelKey.OLDPASSWORD] = ""
        self.viewModel.errorMessages.value[ChangePasswordViewModelKey.NEWPASSWORD] = ""
        self.viewModel.errorMessages.value[ChangePasswordViewModelKey.CONFIRMPASSWORD] = ""
    }
 
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func defineValue(){
        self.viewModel.oldPassword = textFieldOldPassword.text
        self.viewModel.newPassword = textFieldNewPassword.text
        self.viewModel.confirmPassword = textFieldConfirmPassword.text
    }
    
}

extension ChangePasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldOldPassword.delegate = self
        self.textFieldNewPassword.delegate = self
        self.textFieldConfirmPassword.delegate = self
    }
}

extension ChangePasswordVC : SingleButtonDialogPresenter {
    
}


