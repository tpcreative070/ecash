//
//  TransfereCashVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TransfereCashVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.Transfer)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbFullname.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLUE
        self.viewProfileInfo.setRadius(corner: 3,color: AppColors.GRAY_LIGHT)
        self.viewProfileInfo.setShadow(color: AppColors.GRAY, corner: 3)
        self.viewProfileInfo.backgroundColor = AppColors.GRAY_LIGHT
        self.imgDropdown.image = UIImage(named: AppImages.IC_DROPDOWN)
        
        self.lbFullname.text = LanguageHelper.getTranslationByKey(LanguageKey.AccountName)
        self.lbFullname.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbFullname.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbFullnameValue.text = "Nguyen Van A"
        self.lbFullnameValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbFullnameValue.textAlignment  = .right
        
        self.lbeCashId.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashId)
        self.lbeCashId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeCashId.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeCashIdValue.text = "124323322442"
        self.lbeCashIdValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeCashIdValue.textAlignment  = .right
        
        self.lbeCashTotal.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashBalance)
        self.lbeCashTotal.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeCashTotal.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeCashTotalValue.text = "0".toMoney()
        self.lbeCashTotalValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbeCashTotalValue.textAlignment  = .right
        
        self.lbeDongId.text = LanguageHelper.getTranslationByKey(LanguageKey.eDongId)
        self.lbeDongId.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongId.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeDongIdValue.text = "0979123123"
        self.lbeDongIdValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongIdValue.textAlignment  = .right
        
        self.lbeDongTotal.text = LanguageHelper.getTranslationByKey(LanguageKey.eDongBalance)
        self.lbeDongTotal.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongTotal.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbeDongTotalValue.text = "0".toMoney()
        self.lbeDongTotalValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbeDongTotalValue.textAlignment  = .right
        self.viewDropDown.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionDropDown(sender:))))
        dropdowneDong.anchorView = viewDropDown
        dropdowneDong.bottomOffset = CGPoint(x: 0, y: viewDropDown.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        dropdowneDong.dataSource = [
            "001",
            "002"
        ]
        // Action triggered on selection
        dropdowneDong.selectionAction = { [weak self] (index, item) in
            self?.lbeDongIdValue.text = item
        }
      
        self.lbWithdrawMoneyToeDong.text = LanguageHelper.getTranslationByKey(LanguageKey.TransferToeCash)
        self.lbWithdrawMoneyToeDong.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbWithdrawMoneyToeDong.textColor = AppColors.BLUE
       
        self.btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        self.btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        self.btnVerify.setTitleColor(.white, for: .normal)
        self.btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        
        self.textFieldeCashId.lineColor = AppColors.GRAY_COLOR
        self.textFieldeCashId.selectedLineColor = AppColors.GRAY
        self.textFieldeCashId.selectedTitleColor = AppColors.GRAY
        self.textFieldeCashId.keyboardType = .numberPad
        self.textFieldeCashId.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EntereCashId)
        
        self.textFieldMoney.lineColor = AppColors.GRAY_COLOR
        self.textFieldMoney.selectedLineColor = AppColors.GRAY
        self.textFieldMoney.selectedTitleColor = AppColors.GRAY
        self.textFieldMoney.keyboardType = .numberPad
        self.textFieldMoney.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterMoney)
        
        self.textFieldContent.lineColor = AppColors.GRAY_COLOR
        self.textFieldContent.selectedLineColor = AppColors.GRAY
        self.textFieldContent.selectedTitleColor = AppColors.GRAY
        self.textFieldContent.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterContent)
        addTarget(textFieldeCashId)
        addTarget(textFieldMoney)
        addTarget(textFieldContent)
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldeCashId.errorMessage = errors[TransfereCashViewModelKey.ECASHID] ?? ""
                self?.textFieldMoney.errorMessage = errors[TransfereCashViewModelKey.MONEY] ?? ""
                self?.textFieldContent.errorMessage = errors[TransfereCashViewModelKey.CONTENT] ?? ""
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0 {
                    self?.textFieldeCashId.errorMessage = ""
                    self?.textFieldMoney.errorMessage = ""
                    self?.textFieldContent.errorMessage =  ""
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
            if value == EnumResponseToView.SIGN_IN_SUCCESS.rawValue {
                self?.dismiss()
            }
        }
        
        viewModel.fullNameBinding.bind { data in
            self.lbFullnameValue.text = data
        }
        
        viewModel.eCashIdBinding.bind { data in
            self.lbeCashIdValue.text = data
        }
        
        viewModel.eCashBalanceBinding.bind { data in
            self.lbeCashTotalValue.text = data
        }
        
        viewModel.eDongBalanceBinding.bind { data in
            self.lbeDongTotalValue.text = data
        }
        
        self.viewModel.eDongAccountListBinding.bind { data in
            self.dropdowneDong.dataSource = data
        }
       
        self.viewModel.errorMessages.value[TransfereCashViewModelKey.ECASHID] = ""
        self.viewModel.errorMessages.value[TransfereCashViewModelKey.MONEY] = ""
        self.viewModel.errorMessages.value[TransfereCashViewModelKey.CONTENT] = ""
        self.viewModel.doBindingDataToView()
        self.viewModel.doGeteDongInfo()
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
}

extension TransfereCashVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldeCashId.delegate = self
        self.textFieldMoney.delegate = self
        self.textFieldContent.delegate = self
    }
}

extension TransfereCashVC: SingleButtonDialogPresenter { }

