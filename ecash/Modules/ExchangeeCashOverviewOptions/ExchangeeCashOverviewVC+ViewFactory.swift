//
//  ExchangeeCashOverviewVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ExchangeeCashOverviewOptionVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewRoot.setCorner(corner: 3, color: .white)
        
        self.lbExchangeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalExchangeCash)
        self.lbExpectationCash.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalExpectationCash)
       
        self.lbExchangeCash.textColor = AppColors.BLUE
        self.lbExchangeCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        
        self.lbExpectationCash.textColor = AppColors.BLUE
        self.lbExpectationCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        
        self.lbTotalExchangeCash.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalExchangeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalExchangeCash)
     
        self.lbTotalExpectationCash.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalExpectationCash.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalExpectationCash)
      
        self.lbTotalExchangeCashValue.textColor = AppColors.BLUE
        self.lbTotalExchangeCashValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTotalExchangeCashValue.text = "0".toMoney()
        self.lbTotalExchangeCashValue.textAlignment = .right
              
        self.lbTotalExpectationCashValue.textColor = AppColors.BLUE
        self.lbTotalExpectationCashValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTotalExpectationCashValue.text = "0".toMoney()
        self.lbTotalExpectationCashValue.textAlignment = .right
        
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify)?.uppercased(), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 5, color: AppColors.BLUE)
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
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.updateDataSource()
            }
        }
     
        self.viewModel.exchangeCashBinding.bind { data in
            self.lbTotalExchangeCashValue.text = data
        }
               
        self.viewModel.expectationCashBinding.bind { data in
            self.lbTotalExpectationCashValue.text = data
        }
        self.viewModel.getIntentData()
    }
    
    func updateDataSource() {
        self.exchangeCashDataSource.items = self.viewModel.exchangeList
        self.exchangeTableView.reloadData()
        
        self.expectationCashDataSource.items = self.viewModel.expectationList
        self.expectationTableView.reloadData()
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.exchangeCashDataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ExchangeOverviewOptions.rawValue, items: self.viewModel.exchangeList,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.exchangeTableView.dataSource = self.exchangeCashDataSource
        self.exchangeTableView.delegate = self.exchangeCashDataSource
        
        
        self.expectationCashDataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ExpectationOverviewOptions.rawValue, items: self.viewModel.expectationList,isSelectionStype: false){ cell, vm in
                   cell.configView(view: vm)
                   cell.configData(viewModel: vm)
                   cell.delegate = self
        }
        self.expectationTableView.dataSource = self.expectationCashDataSource
        self.expectationTableView.delegate = self.expectationCashDataSource
    }
    
    func setupTableView(){
        exchangeTableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ExchangeOverviewOptions.rawValue)
        exchangeTableView.backgroundColor = .white
        exchangeTableView.separatorStyle = .none
        exchangeTableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        
        expectationTableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ExpectationOverviewOptions.rawValue)
        expectationTableView.backgroundColor = .white
        expectationTableView.separatorStyle = .none
        expectationTableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
    }
}

extension ExchangeeCashOverviewOptionVC : SingleButtonDialogPresenter {
    
}

extension ExchangeeCashOverviewOptionVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellCodable(codable: Codable) {
        
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}
