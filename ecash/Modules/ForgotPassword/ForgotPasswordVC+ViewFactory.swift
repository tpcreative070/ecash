//
//  ForgotPasswordVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ForgotPasswordVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        lbTitle.textAlignment = .center
        lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ForgotPassword)?.uppercased()
        lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        lbTitle.textColor = AppColors.BLUE
        textFieldUsername.lineColor = AppColors.GRAY_COLOR
        textFieldUsername.selectedLineColor = AppColors.GRAY
        textFieldUsername.selectedTitleColor = AppColors.GRAY
        textFieldUsername.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.AccountNumber)
    
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify)?.uppercased(), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        addTarget(textFieldUsername)
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldUsername.errorMessage = errors[ForgotPasswordViewModelKey.USERNAME] ?? ""
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0{
                    self?.textFieldUsername.errorMessage = ""
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
            if value == EnumResponseToView.SENT_OTP_SUCCESSFULLY.rawValue{
                Navigator.pushViewMainStoryboard(from: self!, identifier: Controller.recoverPassword, isNavigation: false, isTransparent: false, present: true)
            }
        }
        
        viewModel.userNameBinding.bind({ (value) in
            self.textFieldUsername.isEnabled = false
            self.textFieldUsername.text = value
            self.viewModel.username = value
        })
        
        self.viewModel.errorMessages.value[ForgotPasswordViewModelKey.USERNAME] = ""
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func defineValue(){
        self.viewModel.username = textFieldUsername.text
    }
    
}

extension ForgotPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldUsername.delegate = self
    }
}

extension ForgotPasswordVC : SingleButtonDialogPresenter {
    
}

