//
//  ForgotPasswordOTPOptionsVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ForgotPasswordOTPOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewRoot.setCorner(corner: 3, color: .white)
        self.viewOTP.setRadius(corner: 3, color: AppColors.GRAY_LIGHT_TEXT)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.VerifyOTP)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.textAlignment = .center
        
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.TheCodeWasSentTo)
        self.lbContent.textAlignment = .center
        self.lbContent.numberOfLines = 0
        self.lbContent.lineBreakMode = .byWordWrapping
        
        self.textFieldOTP.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterOTPCode)
        self.textFieldOTP.keyboardType = .numberPad
        self.textFieldOTP.textAlignment = .center
      
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 5, color: AppColors.BLUE)
        
        btnResend.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Resend), for: .normal)
        btnResend.addTarget(self, action: #selector(actionResend), for: .touchUpInside)
        btnResend.setTitleColor(AppColors.BLACK_COLOR, for: .normal)
        btnResend.backgroundColor = .clear
        addTarget(textFieldOTP)
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0{
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
            }
        }
        self.viewModel.errorMessages.value[ForgotPasswordViewModelKey.OTPCODE] = ""
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingChanged), for: .editingChanged)
    }
    
    func defineValue(){
        self.viewModel.otpCode = textFieldOTP.text
    }
    
}

extension ForgotPasswordOTPOptionsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldOTP.delegate = self
    }
}

extension ForgotPasswordOTPOptionsVC : SingleButtonDialogPresenter {
    
}

