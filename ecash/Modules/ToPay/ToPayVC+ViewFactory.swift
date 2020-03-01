//
//  ToPayVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 1/7/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
extension ToPayVC {
    func initUI(){
        
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: self.scrollviewMain)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()

        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.CreatePaymentBill)?.uppercased()
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
        
        self.textFieldAmount.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.InputPaymentAmount)
        setTextFieldStyle(textField: &self.textFieldAmount)
        
        self.textFieldContent.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.InputPaymentContent)
        setTextFieldStyle(textField: &self.textFieldContent)
        
        self.btConfirm.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify)?.uppercased(), for: .normal)
        self.btConfirm.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        
        self.btConfirm.setTitleColor(.white, for: .normal)
        self.btConfirm.cornerButton(corner: 5, color: AppColors.BLUE)
        
        addTarget(self.textFieldAmount)
        addTarget(self.textFieldContent)
        
    }
    
    func setTextFieldStyle(textField: inout ICTextFieldNoneIcon) {
        textField.lineColor = AppColors.GRAY
        textField.selectedLineColor = AppColors.GRAY
        textField.selectedTitleColor = AppColors.GRAY
        textField.placeholderColor = AppColors.GRAY
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
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
        
        self.viewModel.amountValueBinding.bind { (value) in
            self.textFieldAmount.text = value
        }
        
        self.viewModel.contentValueBinding.bind { (value) in
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
        
        viewModel.doBindingUpdate()
    }
}

extension ToPayVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModel.setFocusTextField(textField: textField)
    }
    
    func setupDelegate() {
        self.textFieldAmount.delegate = self
        self.textFieldContent.delegate = self
    }
}
