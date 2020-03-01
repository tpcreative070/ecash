//
//  TransfereCashMultipleVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 9/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TransfereCashMultipleVC {
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
        self.imgContact.image = UIImage(named: AppImages.IC_CONTACT_ACTIVE)
     
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
        // You can also use localizationKeysDataSource instead. Check the docs.
        dropdowneDong.dataSource = [
            "001",
            "002"
        ]
      
        self.lbTransferTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashToeCash)
        self.lbTransferTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTransferTitle.textColor = AppColors.BLUE
        
        
        self.lbTotalMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalMoney)
        self.lbTotalMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbTotalMoney.textColor = AppColors.GRAY_LIGHT_TEXT
       
        self.lbTotalMoneyValue.text = "0".toMoney()
        self.lbTotalMoneyValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTotalMoneyValue.textColor = AppColors.BLUE
        self.lbTotalMoneyValue.textAlignment = .right
        
        self.btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        self.btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        self.btnVerify.setTitleColor(.white, for: .normal)
        self.btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        
        self.textFieldeCashId.lineColor = AppColors.GRAY_COLOR
        self.textFieldeCashId.selectedLineColor = AppColors.GRAY
        self.textFieldeCashId.selectedTitleColor = AppColors.GRAY
        self.textFieldeCashId.keyboardType = .numberPad
        //self.textFieldeCashId.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EntereCashId)
        self.textFieldeCashId.isEnabled = false
        
        self.textFieldContent.lineColor = AppColors.GRAY_COLOR
        self.textFieldContent.selectedLineColor = AppColors.GRAY
        self.textFieldContent.selectedTitleColor = AppColors.GRAY
        self.textFieldContent.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.EnterContent)
        
        self.lbNoAvailableMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.NoListAvailable)
        self.lbNoAvailableMoney.textAlignment = .center
        self.lbNoAvailableMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.lbNoAvailableMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.switchDefaultConfig(switchView: switchButton)
        self.switchButton.addTarget(self, action: #selector(switchDidChange(_:)), for: .touchUpInside)
        self.lbUseQRCode.text = LanguageHelper.getTranslationByKey(LanguageKey.UseQRCode)
        addTarget(textFieldeCashId)
        addTarget(textFieldContent)
        setupTableView()
        bindTableView()
        self.switchButton.setOn(on: viewModel.isQRCode ?? false, animated: false)
        self.imgContact.isUserInteractionEnabled = true
        self.imgContact.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionContact(sender:))))
        
   
        self.viewContact.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionViewContact(sender:))))
    }
    
    func bindingViewModel() {
        btnVerify.isEnabled = false
        btnVerify.alpha = AppConstants.ALPHA_DISBALE
        viewModel.errorMessages.bind({ [weak self] errors in
            if errors.count > 0 {
                self?.textFieldeCashId.errorMessage = errors[TransfereCashViewModelKey.ECASHID] ?? ""
                self?.textFieldContent.errorMessage = errors[TransfereCashViewModelKey.CONTENT] ?? ""
                self?.btnVerify.isEnabled = false
                self?.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
            else {
                if errors.count == 0 {
                    self?.textFieldeCashId.errorMessage = ""
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
            if value == EnumResponseToView.NO_LIST_AVAILABLE.rawValue {
                self?.lbNoAvailableMoney.isHidden = false
                self?.tableView.isHidden = true
                self?.viewHeight.constant = 50
            }else if value == EnumResponseToView.LIST_AVAILABLE.rawValue {
                self?.lbNoAvailableMoney.isHidden = true
                self?.tableView.isHidden = false
                self?.viewHeight.constant = CGFloat((self?.viewModel.listAvailable.count ?? 1) * 50)
                self?.updateDataSource()
                self?.log(message: "Update tableview...")
            }
            else if value == EnumResponseToView.ECASH_TO_ECASH.rawValue {
                self?.alertAddeCashSuccessful()
            }
            else if value == EnumResponseToView.NO_INTERNET_CONNECTION.rawValue {
                self?.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.NoInternetConnection) ?? "")
            }
            else if value == EnumResponseToView.NO_SOCKET_CONNECTION.rawValue {
                self?.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.SocketConnectError) ?? "")
            }
            else if value == EnumResponseToView.READY_TO_SUBMIT.rawValue{
                self?.viewModel.doGetPublicKey()
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
        
        self.viewModel.eDongAccountListBinding.bind { data in
            self.dropdowneDong.dataSource = data
        }
    
        self.viewModel.totalMoneyBinding.bind { data in
            self.lbTotalMoneyValue.text = data
        }
        
        self.viewModel.errorMessages.value[TransfereCashViewModelKey.ECASHID] = ""
        self.viewModel.errorMessages.value[TransfereCashViewModelKey.CONTENT] = ""
        self.viewModel.doBindingDataToView()
        self.viewModel.doGeteDongInfo()
        self.viewModel.getListAvailable()
        
        if let mData = CommonService.getShareeCashToeCash() {
            if let eCashId = mData.eCash{
                self.textFieldeCashId.text = eCashId
                self.viewModel.doCheckRefresheCashAvailable(eCashArray: [eCashId])
            }
            if let eCashArray = mData.ecashArray {
                self.textFieldeCashId.text = eCashArray.joined(separator: ",")
                self.viewModel.doCheckRefresheCashAvailable(eCashArray: eCashArray)
            }
        }
    }
    
    func registerTransactionResponse(){
        ShareTransactionSingleton.shared.bind{ [weak self] in
            if let mData = CommonService.getShareeCashToeCash() {
                if let eCashId = mData.eCash{
                    self?.textFieldeCashId.text = eCashId
                    self?.viewModel.doCheckRefresheCashAvailable(eCashArray: [eCashId])
                }
                if let eCashArray = mData.ecashArray {
                    self?.textFieldeCashId.text = eCashArray.joined(separator: ",")
                    self?.viewModel.doCheckRefresheCashAvailable(eCashArray: eCashArray)
                }
            }
        }
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listAvailable
        self.tableView.reloadData()
        log(message: "List available......")
        log(object: self.viewModel.listAvailable)
    }
    
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.TransfereCashToeCash.rawValue, items: self.viewModel.listAvailable,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.dataSource.loadMore = {
            self.log(message: "Loading more")
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.TransfereCashToeCash.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
    }
    
    func alertAddeCashSuccessful(){
        let eCashToeCash   = eCashToeCashPassData(total: viewModel.totalMoneyDispay, eCash: viewModel.eCashId ?? "")
        let data = PassDataViewModel(identifier: EnumPassdata.ECASH_TO_ECASH, eCashToeCash: eCashToeCash)
        ShareSignUpSingleton.shared.set(value: data)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.alert, isNavigation: false,isTransparent: true, present: true)
    }
    
    /**
     Initial style for Switch
     */
    fileprivate func switchDefaultConfig(switchView: ICSwitchButton) {
        switchButton.onTintColor = AppColors.BLUE
        switchButton.offTintColor = AppConstants.SWITCH_OFF_TINT_COLOR
        switchButton.cornerRadius = AppConstants.SWITCH_CORNER_RADIUS
        switchButton.thumbCornerRadius = AppConstants.SWITCH_THUMB_CORNER_RADIUS
        switchButton.thumbSize = CGSize(width: AppConstants.SWITCH_THUMB_SIZE_WIDTH, height: AppConstants.SWITCH_THUMB_SIZE_HEIGHT)
        switchButton.thumbTintOnColor = .white
        switchButton.thumbTintOffColor = AppConstants.SWITCH_THUMB_OFF_TINT_COLOR
        switchButton.animationDuration = AppConstants.SWITCH_ANIMATION_DURATION
    }
}

extension TransfereCashMultipleVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldeCashId.delegate = self
        self.textFieldContent.delegate = self
    }
}

extension TransfereCashMultipleVC : TableViewCellDelegate {
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellViewSelected(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        log(message: "selected \(indexPath.row)")
    }
    func cellCodable(codable: Codable) {
    
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let result = self.viewModel.listAvailable[indexPath.row]
        result.countSelected = countSelected
        self.viewModel.doCalculator()
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}

extension TransfereCashMultipleVC: SingleButtonDialogPresenter { }
