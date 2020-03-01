//
//  WithdraweCashMultipleVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 9/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension WithdraweCashMultipleVC  {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.WithdraweCash)?.uppercased()
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
        self.imgWithdrawDropDown.image = UIImage(named: AppImages.IC_DROPDOWN)
        self.lbTransferTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.WithdrawToeDong)
        self.lbTransferTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTransferTitle.textColor = AppColors.BLUE
        self.lbWithdrawDropDown.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbWithdrawDropDown.text = "124323322442"
        self.lbWithdrawDropDown.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        self.btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        self.btnVerify.setTitleColor(.white, for: .normal)
        self.btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
       
        self.viewWithdrawDropDown.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionWithdrawDropDown(sender:))))
        dropdowneToeDong.anchorView = viewWithdrawDropDown
        dropdowneToeDong.bottomOffset = CGPoint(x: 0, y: viewDropDown.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        dropdowneToeDong.dataSource = [
            "001",
            "002"
        ]
        // Action triggered on selection
        dropdowneToeDong.selectionAction = { [weak self] (index, item) in
            self?.lbWithdrawDropDown.text = item
            self?.viewModel.eDongIdSelected = item
        }
        
        self.lbNoAvailableMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.NoListAvailable)
        self.lbNoAvailableMoney.textAlignment = .center
        self.lbNoAvailableMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.lbNoAvailableMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalMoney)
        self.lbTotalMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbTotalMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        
        self.lbTotalMoneyValue.text = "0".toMoney()
        self.lbTotalMoneyValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTotalMoneyValue.textColor = AppColors.BLUE
        self.lbTotalMoneyValue.textAlignment = .right
        
        setupTableView()
        bindTableView()
    }
    
    func bindViewModel() {
    
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
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
        viewModel.eDongIdBinding.bind  { data in
            self.lbeDongIdValue.text = data
            self.lbWithdrawDropDown.text = data
        }
        
        viewModel.eDongBalanceBinding.bind { data in
            self.lbeDongTotalValue.text = data
        }
        
        self.viewModel.eDongAccountListBinding.bind { data in
            self.dropdowneDong.dataSource = data
            self.dropdowneToeDong.dataSource = data
        }
        
        self.viewModel.responseToView = {[weak self] value in
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
            else if value == EnumResponseToView.ECASH_TO_EDONG.rawValue {
                self?.alertAddeCashSuccessful()
            }
        }
        
        self.viewModel.totalMoneyBinding.bind { data in
            self.lbTotalMoneyValue.text = data
        }
        
        self.viewModel.errorMessages.value[WithdraweCashViewModelKey.MONEY] = ""
        self.viewModel.doBindingDataToView()
        self.viewModel.doGeteDongInfo()
        self.viewModel.getListAvailable()
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listAvailable
        self.tableView.reloadData()
    }
    
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.WithdrawMultipleeCash.rawValue, items: self.viewModel.listAvailable,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
            self.log(message: "Update cell...")
        }
        self.dataSource.loadMore = {
            self.log(message: "Loading more")
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.WithdrawMultipleeCash.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
    }
    
    
    func alertAddeCashSuccessful(){
        let eCashToeDong   = eCashToeDongPassData(total: viewModel.totalMoneyDispay ?? "", eDong: viewModel.eDongIdSelected)
        let data = PassDataViewModel(identifier: EnumPassdata.ECASH_TO_EDONG, eCashToeDong: eCashToeDong)
        ShareSignUpSingleton.shared.set(value: data)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.alert, isNavigation: false,isTransparent: true, present: true)
    }
}

extension WithdraweCashMultipleVC : TableViewCellDelegate {
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

extension WithdraweCashMultipleVC : SingleButtonDialogPresenter{
    
}

