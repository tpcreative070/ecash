//
//  PayToVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 1/7/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
extension PayToVC {
    func initUI(){
        
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: self.scrollviewMain)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()

        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.PaymentRequest)?.uppercased()
        self.lbTitle.textAlignment = NSTextAlignment.center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLUE
        
        if let leftIcon =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftIcon, isLeft: true)
        }
        
        self.viewHeader.setRadius(corner: 3,color: AppColors.GRAY_LIGHT)
        self.viewHeader.setShadow(color: AppColors.GRAY,corner : 3)
        self.viewHeader.backgroundColor = AppColors.gray_background
        
        self.lbAccountName.textColor = AppColors.GRAY_50
        self.lbAccountName.text = LanguageHelper.getTranslationByKey(LanguageKey.AccountName)
        self.lbAccountName.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbAcountNameValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        
        self.lbECashId.textColor = AppColors.GRAY_50
        self.lbECashId.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashID)
        self.lbECashId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbECashIdValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        
        self.lbECashBalance.textColor = AppColors.GRAY_50
        self.lbECashBalance.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashBalance)
        self.lbECashBalance.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        
        self.lbTitleContent.text = LanguageHelper.getTranslationByKey(LanguageKey.PaymentContent)
        self.lbTitleContent.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitleContent.textColor = AppColors.BLUE
        
        self.textFieldECashAccountNumber.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.InputAccountEcashNumber)
        self.textFieldECashAccountNumber.isUserInteractionEnabled = false
        self.textFieldECashAccountNumber.textColor = AppColors.GRAY
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.textFieldECashAccountNumber.rightView = paddingView
        self.textFieldECashAccountNumber.rightViewMode = .always
        
        
        setTextFieldStyle(textField: &self.textFieldECashAccountNumber)
        
        self.lbTitleGetQRCode.text = LanguageHelper.getTranslationByKey(LanguageKey.GetAccountByQrCode)
        self.lbTitleGetQRCode.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoLight, size: AppFonts.NOTICE_LABEL_SUB_FONT_SIZE)
        self.lbTitleGetQRCode.textColor = AppColors.BLUE
        
        self.textFieldAmount.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.InputPaymentAmount)
        setTextFieldStyle(textField: &self.textFieldAmount)
        self.textFieldAmount.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        self.textFieldContent.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.InputPaymentContent)
        self.textFieldContent.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        
        setTextFieldStyle(textField: &self.textFieldContent)
        
        self.btSelectContact.addTarget(self, action: #selector(actionSelectContact), for: .touchUpInside)
        
        self.imgContacts.image = UIImage(named: AppImages.IC_CONTACT_ACTIVE)
//        self.imgContacts.isUserInteractionEnabled = true
//        self.imgContacts.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapImageContact)))
        
        self.imgContactQR.image = UIImage(named: AppImages.IC_QRCODE)
        self.imgContactQR.isUserInteractionEnabled = true
        self.imgContactQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapImageQR)))
        
        self.btConfirm.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify)?.uppercased(), for: .normal)
        self.btConfirm.setTitleColor(.white, for: .normal)
        self.btConfirm.cornerButton(corner: 5, color: AppColors.GRAY_LIGHT)
        self.btConfirm.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        
        addTarget(self.textFieldECashAccountNumber)
        addTarget(self.textFieldAmount)
        addTarget(self.textFieldContent)
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func setTextFieldStyle(textField: inout ICTextFieldNoneIcon) {
        textField.lineColor = AppColors.GRAY
        textField.selectedLineColor = AppColors.GRAY
        textField.selectedTitleColor = AppColors.GRAY
        textField.placeholderColor = AppColors.GRAY
    }
    
    func bindingViewModel() {
        self.viewModel.acountNameValueBinding.bind { (value) in
            self.lbAcountNameValue.text = value
        }
        self.viewModel.eCashIdValueBinding.bind { (value) in
            self.lbECashIdValue.text = value
        }
        self.viewModel.eCashBalanceValueBinding.bind { (value) in
            self.lbECashBalanceValue.text = value
        }
        self.viewModel.eCashAccountNumberBinding.bind { (value) in
            self.textFieldECashAccountNumber.text = value
        }
        
        self.viewModel.amountBinding.bind { (value) in
            self.textFieldAmount.text = value
        }
        
        self.viewModel.onShowError = { [weak self] alert in
             self?.presentSingleButtonDialog(alert: alert)
        }
        
        self.viewModel.contentBinding.bind { (value) in
            if (value != "nil") {
                self.textFieldContent.text = value
            }
        }
        
        self.viewModel.btStatusBinding.bind { (value) in
            switch value {
            case ButtonStatus.ENABLE:
                self.btConfirm.enableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DEFAULT)
                break
            case ButtonStatus.DISABLE:
                self.btConfirm.disableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DISBALE)
                break
            default :
                break
            }
        }
        var responseToViewVoid: (String) -> Void = {(value) in
            if value == EnumResponseToView.PayToToPayUnloadingButton.rawValue {
                let delayTime = DispatchTime.now() + 0.2
                DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
                   self.viewModel.btStatusBinding.value = ButtonStatus.DISABLE
                   self.btConfirm.hideLoading()
                   self.viewModel.amountInt = 0
                   self.viewModel.listCashIds = []
                   self.viewModel.amountBinding.value = ""
                   self.viewModel.contentString = ""
                   self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.SentRequestSuccessFul) ?? "")
                   self.viewModel.saveTmpState()
                })
            }
            
            // Internet error no connection
            if value == EnumResponseToView.NO_INTERNET_CONNECTION.rawValue {
                self.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.NoInternetConnection) ?? "")
                self.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
                self.btConfirm.hideLoading()
            }
            
            // Socket error no connection
            if value == EnumResponseToView.NO_SOCKET_CONNECTION.rawValue {
                self.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.SocketConnectError) ?? "")
                self.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
                self.btConfirm.hideLoading()
            }
        }
            
        viewModel.setResponseToView(responseToView: &responseToViewVoid)
    }
}

extension PayToVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModel.setFocusTextField(textField: textField)
    }
    
    func setupDelegate() {
        self.textFieldECashAccountNumber.delegate = self
        self.textFieldAmount.delegate = self
        self.textFieldContent.delegate = self
    }
}

extension PayToVC : SingleButtonDialogPresenter{
    
}
