//
//  ExchangeeCashOptions+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ExchangeeCashOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewOptions.setCorner(corner: 3, color: .white)
        self.lbTitle.textColor = AppColors.BLUE
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        
        self.lbExchangeMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbExchangeMoneyValue.textColor = AppColors.BLUE
        self.lbExchangeMoneyValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 2)
        self.lbExchangeMoneyValue.textAlignment = .right
        self.lbExchangeMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalMoney)
        
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 5, color: AppColors.BLUE)
        self.lbNoAvailableMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.NoListAvailable)
        self.lbNoAvailableMoney.textAlignment = .center
        self.lbNoAvailableMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
      
        
        if let mData = CommonService.getShareExchangeCash(){
            self.viewModel.isExchangeCash = mData.isExchangeCash
            log(message: "Data intent")
            log(object: mData)
        }
        setupTableView()
        bindTableView()
    }
    
    func bindingViewModel() {
        viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        
        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        
        viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.NO_LIST_AVAILABLE.rawValue {
                self?.lbNoAvailableMoney.isHidden = false
                self?.tableView.isHidden = true
            }else if value == EnumResponseToView.LIST_AVAILABLE.rawValue {
                self?.lbNoAvailableMoney.isHidden = true
                self?.tableView.isHidden = false
                self?.updateDataSource()
                self?.log(message: "Update tableview...")
            }
        }
        
        self.viewModel.totalMoneyBinding.bind { data in
            self.lbExchangeMoneyValue.text = data
        }
        
        self.viewModel.titleBinding.bind { data in
            self.lbTitle.text = data
        }
        if (self.viewModel.isExchangeCash ?? false){
            self.viewModel.titleBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.CashExchage) ?? ""
        }else{
            self.viewModel.titleBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.CashReceive) ?? ""
        }
        viewModel.getListAvailable()
        viewModel.getListExpectation()
    }
    
    func updateDataSource() {
        if (self.viewModel.isExchangeCash ?? false){
            self.dataSource.items = self.viewModel.listAvailable
        }else{
           self.expectationCashDataSource.items = self.viewModel.listExpectation
        }
        self.tableView.reloadData()
    }
    
    //set dataSource fo tableView
    func bindTableView() {
        //Exchange cash
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ExchangeeCashAvailable.rawValue, items: self.viewModel.listAvailable,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
            debugPrint("celll")
        }
        self.dataSource.loadMore = {
            self.log(message: "Loading more")
        }
        
        //Expectation cash
        self.expectationCashDataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ExpectationCash.rawValue, items: self.viewModel.listExpectation,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.expectationCashDataSource.loadMore = {
            self.log(message: "Loading more")
        }
        
        if (self.viewModel.isExchangeCash ?? false){
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self.dataSource
        }else{
            self.tableView.dataSource = self.expectationCashDataSource
            self.tableView.delegate = self.expectationCashDataSource
        }
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        if (viewModel.isExchangeCash ?? false) {
             tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ExchangeeCashAvailable.rawValue)
        }else{
             tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ExpectationCash.rawValue)
        }
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.rowHeight = 50
        tableView.alwaysBounceVertical = false
    }
    
}

extension ExchangeeCashOptionsVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if (viewModel.isExchangeCash ?? false) {
            let result = self.viewModel.listAvailable[indexPath.row]
            result.countSelected = countSelected
            self.viewModel.doCalculator()
        }else{
            let result = self.viewModel.listExpectation[indexPath.row]
            result.countSelected = countSelected
            self.viewModel.doCalculatorExpectationCash()
            log(message: "Index \(indexPath.row)")
            log(message: countSelected.description)
        }
    }
    
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellCodable(codable: Codable) {
        
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}

extension ExchangeeCashOptionsVC  : SingleButtonDialogPresenter{
    
}
