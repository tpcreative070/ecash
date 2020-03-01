//
//  EditContactVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension EditContactVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewRoot.setCorner(corner: 3, color: .white)
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 5, color: AppColors.BLUE)
        textFieldWalletId.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.WalletNumber)
        textFieldWalletId.selectedTitleColor = AppColors.GRAY
        
        textFieldPhoneNumber.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.PhoneNumber)
        textFieldWalletId.selectedTitleColor = AppColors.GRAY
        
        textFieldPhoneInfo.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.DeviceInfo)
        textFieldPhoneInfo.selectedTitleColor = AppColors.GRAY
        
        addTarget(textFieldFullName)
    }
    
    func bindViewModel() {
//        btnVerify.isEnabled = false
//        btnVerify.alpha = AppConstants.ALPHA_DISBALE
//        viewModel.errorMessages.bind({ [weak self] errors in
//            if errors.count > 0 {
//                self?.textFieldFullName.errorMessage = errors[SignInViewModelKey.ACCOUNTNUMBER] ?? ""
//                self?.textFieldFullName.errorMessage = errors[SignInViewModelKey.PASSWORD] ?? ""
//                self?.btnVerify.isEnabled = false
//                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
//            }
//            else {
//                if errors.count == 0 {
//                    self?.textFieldFullName.errorMessage = ""
//                    self?.textFieldFullName.errorMessage = ""
//                    self?.btnVerify.isEnabled = true
//                    self?.btnVerify.alpha = AppConstants.ALPHA_DEFAULT
//                }
//            }
//        })
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        
        self.viewModel.responseToView = {[weak self] value in
            if EnumResponseToView.UPDATED_CONTACT_SUCCESSFULLY.rawValue == value {
                CommonService.sendDataToContactEntities(data: ContactsEntityModel(), isResponse: true)
                self?.dismiss()
            }
        }
        
        self.viewModel.walletIdBinding.bind { (value) in
            self.textFieldWalletId.text = value
            self.textFieldWalletId.isEnabled = false
        }
        
        self.viewModel.fullNameBinding.bind { (value) in
            self.textFieldFullName.text = value
        }
        self.viewModel.phoneNumberBinding.bind { (value) in
            self.textFieldPhoneNumber.text = value
            self.textFieldPhoneNumber.isEnabled = false
        }
        self.viewModel.mobileInfoBinding.bind { (value) in
            self.textFieldPhoneInfo.text = value
            self.textFieldPhoneInfo.isEnabled = false
        }
        viewModel.doContactInfo()
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
}

extension EditContactVC : SingleButtonDialogPresenter {
    
}

extension EditContactVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldFullName.delegate = self
    }
}
