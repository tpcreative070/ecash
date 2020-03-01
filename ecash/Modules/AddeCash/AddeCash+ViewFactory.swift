//
//  AddeCash+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension AddeCashVC {
    func initUI(){
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.AddeCash)?.uppercased()
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
        self.lbMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.Money)
        self.lbMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbMoney.textColor = AppColors.BLUE
       
        self.btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        self.btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        self.btnVerify.setTitleColor(.white, for: .normal)
        self.btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        self.lbTotalMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalMoney)
        self.lbTotalMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbTotalMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalMoneyValue.text = "0".toMoney()
        self.lbTotalMoneyValue.textColor = AppColors.BLUE
        self.lbTotalMoneyValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTotalMoneyValue.textAlignment = .right
        
        //eDongId select
        self.imgDropdowneDongSelect.image = UIImage(named: AppImages.IC_DROPDOWN)
        self.viewDropDownSelect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionDropDownSelect(sender:))))
        dropdowneDongSelect.anchorView = viewDropDownSelect
        dropdowneDongSelect.bottomOffset = CGPoint(x: 0, y: viewDropDownSelect.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        dropdowneDongSelect.dataSource = [
            "001",
            "002"
        ]
        // Action triggered on selection
        dropdowneDongSelect.selectionAction = { [weak self] (index, item) in
            self?.lbeDongIdSelect.text = item
            self?.viewModel.eDongIdSelected = item
        }
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
            self.lbeDongIdSelect.text = data
        }
        
        viewModel.eDongBalanceBinding.bind { data in
            self.lbeDongTotalValue.text = data
        }
        
        self.viewModel.eDongAccountListBinding.bind { data in
            self.dropdowneDong.dataSource = data
            self.dropdowneDongSelect.dataSource = data
        }
        
        self.viewModel.totalMoneyBinding.bind { data in
            self.lbTotalMoneyValue.text = data
        }
        
        self.viewModel.responseToView  = { [weak self] data in
            if data == EnumResponseToView.EDONG_TO_ECASH.rawValue {
                self?.alertAddeCashSuccessful()
            }
            else if data == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.constraintHeight.constant = CGFloat((self?.viewModel.listDenomination.count ?? 1) * 55 )
                self?.updateDataSource()
            }
        }
        self.viewModel.doBindingDataToView()
        self.viewModel.doGeteDongInfo()
        self.viewModel.getDenominationList()
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listDenomination
        self.tableView.reloadData()
    }
       
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.Denomination.rawValue, items: self.viewModel.listDenomination,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
       
    func setupTableView(){
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.Denomination.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.rowHeight = 50
        tableView.alwaysBounceVertical = false
    }
    
    func alertAddeCashSuccessful(){
        let eDongToeCash   = eDongToeCashPassData(total: viewModel.totalMoney ?? "0")
        let data = PassDataViewModel(identifier: EnumPassdata.EDONG_TO_ECASH, eDongToeCash: eDongToeCash)
        ShareSignUpSingleton.shared.set(value: data)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.alert, isNavigation: false,isTransparent: true, present: true)
    }
}

extension AddeCashVC : SingleButtonDialogPresenter{
    
}

extension AddeCashVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let result = self.viewModel.listDenomination[indexPath.row]
        result.countSelected = countSelected
        self.viewModel.doCalculator()
    }
    
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellCodable(codable: Codable) {
        
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}
