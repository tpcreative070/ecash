//
//  EditProfileVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension EditProfileVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        self.lbTitle.textAlignment = .center
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ProfileInfo)?.uppercased()
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLUE
        
        textFieldFullName.lineColor = AppColors.GRAY_COLOR
        textFieldFullName.selectedLineColor = AppColors.GRAY
        textFieldFullName.selectedTitleColor = AppColors.GRAY
        textFieldFullName.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.Full_Name)
        
        textFieldAddress.lineColor = AppColors.GRAY_COLOR
        textFieldAddress.selectedLineColor = AppColors.GRAY
        textFieldAddress.selectedTitleColor = AppColors.GRAY
        textFieldAddress.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.Address)
        
        textFieldIdNumber.lineColor = AppColors.GRAY_COLOR
        textFieldIdNumber.selectedLineColor = AppColors.GRAY
        textFieldIdNumber.selectedTitleColor = AppColors.GRAY
        textFieldIdNumber.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.IdNumber)
        
        textFieldEmail.lineColor = AppColors.GRAY_COLOR
        textFieldEmail.selectedLineColor = AppColors.GRAY
        textFieldEmail.selectedTitleColor = AppColors.GRAY
        textFieldEmail.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EmailPlaceHolder)
        
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify)?.uppercased(), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        addTarget(textFieldFullName)
        addTarget(textFieldAddress)
        addTarget(textFieldIdNumber)
        addTarget(textFieldEmail)
        
        self.imgAvatar.isUserInteractionEnabled = true
        self.imgAvatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionEditAvatar(sender:))))
        self.imgAvatar.image = UIImage(named: AppImages.IC_AVATAR)
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.borderColor = .clear
        
        if let mData = CommonService.getShareGalleryOptions(){
            if let _ = mData.isAvatar{
                DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                    Navigator.pushViewMainStoryboard(from: self, identifier: Controller.galleryOptions, isTransparent: true, present: true)
                }
            }
        }
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                
                self?.textFieldFullName.errorMessage = errors[EditProfileViewModelKey.FULLNAME] ?? ""
                self?.textFieldAddress.errorMessage = errors[EditProfileViewModelKey.ADDRESS] ?? ""
                self?.textFieldIdNumber.errorMessage = errors[EditProfileViewModelKey.IDNUMBER] ?? ""
                self?.textFieldEmail.errorMessage = errors[EditProfileViewModelKey.EMAIL] ?? ""
             
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0{
                    self?.textFieldFullName.errorMessage = ""
                    self?.textFieldAddress.errorMessage = ""
                    self?.textFieldIdNumber.errorMessage = ""
                    self?.textFieldEmail.errorMessage = ""
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
            if value == EnumResponseToView.UPDATED_SUCCESSFULLY.rawValue{
                self?.dismiss()
            }
        }
        viewModel.fullNameBinding.bind { (value) in
            self.textFieldFullName.text = value
            self.viewModel.errorMessages.value.removeValue(forKey: EditProfileViewModelKey.FULLNAME)
        }
        viewModel.addressBinding.bind { (value) in
            self.textFieldAddress.text = value
            self.viewModel.errorMessages.value.removeValue(forKey: EditProfileViewModelKey.ADDRESS)
        }
        viewModel.idNumberBinding.bind { (value) in
            self.textFieldIdNumber.text = value
            self.viewModel.errorMessages.value.removeValue(forKey: EditProfileViewModelKey.IDNUMBER)
        }
        viewModel.emailBinding.bind { (value) in
            self.textFieldEmail.text = value
            self.viewModel.errorMessages.value.removeValue(forKey: EditProfileViewModelKey.EMAIL)
        }
        
        viewModel.avatarBinding.bind { (value) in
            self.imgAvatar.image = value
        }
        
        self.viewModel.errorMessages.value[EditProfileViewModelKey.FULLNAME] = ""
        self.viewModel.errorMessages.value[EditProfileViewModelKey.ADDRESS] = ""
        self.viewModel.errorMessages.value[EditProfileViewModelKey.IDNUMBER] = ""
        self.viewModel.errorMessages.value[EditProfileViewModelKey.EMAIL] = ""
        self.viewModel.doBindingUpdate()
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func defineValue(){
        self.viewModel.fullName = textFieldFullName.text
        self.viewModel.address = textFieldAddress.text
        self.viewModel.idNumber = textFieldIdNumber.text
        self.viewModel.email = textFieldEmail.text
    }
    
    func onRegisterSingleton(){
        ShareSingleton.shared.bind{ [weak self] in
            if let mData = CommonService.getShareGalleryOptions(){
                if let mLarge = mData.bIconLarge{
                    self?.imgAvatar.image = mLarge.doConvertBase64StringToImage()
                    self?.viewModel.doUploadProfile(data: mData)
                }
            }
        }
    }
    
}

extension EditProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldFullName.delegate = self
        self.textFieldAddress.delegate = self
        self.textFieldIdNumber.delegate = self
        self.textFieldEmail.delegate = self
    }
}

extension EditProfileVC : SingleButtonDialogPresenter {
    
}

