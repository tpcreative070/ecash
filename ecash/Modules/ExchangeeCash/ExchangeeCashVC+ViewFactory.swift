//
//  ExchangeeCashVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ExchangeeCashVC {
    func initUI(){
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ExchangeeCash)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLUE
        self.viewProfileInfo.setRadius(corner: 3,color: AppColors.GRAY_LIGHT)
        self.viewProfileInfo.setShadow(color: AppColors.GRAY, corner: 3)
        self.viewProfileInfo.backgroundColor = AppColors.GRAY_LIGHT
     
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
        self.lbCashListAvailable.text = LanguageHelper.getTranslationByKey(LanguageKey.CashListAvailable)
        self.lbCashListAvailable.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbCashListAvailable.textColor = AppColors.BLUE
     
        
        btnCashExchange.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.CashExchage), for: .normal)
        btnCashExchange.addTarget(self, action: #selector(actionCashExchange), for: .touchUpInside)
        btnCashExchange.setTitleColor(AppColors.BLUE, for: .normal)
       
        
        btnCashReceive.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.CashReceive), for: .normal)
        btnCashReceive.addTarget(self, action: #selector(actionCashReceive), for: .touchUpInside)
        btnCashReceive.setTitleColor(AppColors.BLUE, for: .normal)
       
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 3, color: AppColors.BLUE)
        self.lbNoAvailableMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.NoListAvailable)
        self.lbNoAvailableMoney.textAlignment = .center
        self.lbNoAvailableMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        
        self.lbTotalExchangeCash.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalExchangeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalExchangeCash)
        self.lbTotalExchangeCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        
        self.lbTotalExpectationCash.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalExpectationCash.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalExpectationCash)
        self.lbTotalExpectationCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        
        self.lbTotalExchangeCashValue.textColor = AppColors.BLUE
        self.lbTotalExchangeCashValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTotalExchangeCashValue.text = "0".toMoney()
        self.lbTotalExchangeCashValue.textAlignment = .right
        
        self.lbTotalExpectationCashValue.textColor = AppColors.BLUE
        self.lbTotalExpectationCashValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTotalExpectationCashValue.text = "0".toMoney()
        self.lbTotalExpectationCashValue.textAlignment = .right
        
        setupTableView()
        bindTableView()
        
        
        setTextColor(view: btnCashExchange, color: AppColors.BLUE)
        setTextColor(view: btnCashReceive, color: AppColors.BLUE)
        setCorner(view: viewCashExchange, corner: 3, color: AppColors.BLUE)
        setCorner(view: viewCashReceive, corner: 3, color: AppColors.BLUE)
    }
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
       
        viewModel.eCashIdBinding.bind { data in
            self.lbeCashIdValue.text = data
        }
        
        viewModel.eCashBalanceBinding.bind { data in
            self.lbeCashTotalValue.text = data
        }
        
        ShareExchangeCashSingleton.shared.bind {[weak self] in
            if let mData = CommonService.getShareExchangeCash() {
                self?.log(message: "ShareExchangeCashSingleton")
                self?.viewModel.doBindingExchangeCash()
                self?.hideView(isHide: false)
                self?.log(object: mData)
                self?.log(object: mData.listExchangeCash)
            }
        }
        
        self.viewModel.responseToView  = { [weak self] data in
            if data == EnumResponseToView.NO_LIST_AVAILABLE.rawValue {
                self?.lbNoAvailableMoney.isHidden = false
                self?.tableView.isHidden = true
                self?.viewHeight.constant = 50
            }else if data == EnumResponseToView.LIST_AVAILABLE.rawValue {
                self?.lbNoAvailableMoney.isHidden = true
                self?.tableView.isHidden = false
                self?.viewHeight.constant = CGFloat((self?.viewModel.listAvailable.count ?? 1) * 50)
                self?.updateDataSource()
                self?.log(message: "Update tableview...")
            }
            else if data == EnumResponseToView.EXCHANGE_CASH.rawValue {
                self?.viewModel.clearData()
                self?.alertAddeCashSuccessful()
            }
        }
        
        self.viewModel.exchangeCashBinding.bind { data in
            self.lbTotalExchangeCashValue.text = data
        }
        
        self.viewModel.expectationCashBinding.bind { data in
            self.lbTotalExpectationCashValue.text = data
        }
        
        self.viewModel.matchValueBinding.bind { data in
            if data {
                self.setTextColor(view: self.btnCashExchange, color: AppColors.RED_COLOR)
                self.setTextColor(view: self.btnCashReceive, color: AppColors.RED_COLOR)
                self.setCorner(view: self.viewCashExchange, corner: 3, color: AppColors.RED_COLOR)
                self.setCorner(view: self.viewCashReceive, corner: 3, color: AppColors.RED_COLOR)
                self.btnVerify.isEnabled = true
                self.btnVerify.alpha = AppConstants.ALPHA_DEFAULT
                
                Navigator.pushViewMainStoryboard(from: self, identifier: Controller.exchangeeCashOverviewOptions, isNavigation: false, isTransparent: true,present : true)
            }else{
                self.setTextColor(view: self.btnCashExchange, color: AppColors.BLUE)
                self.setTextColor(view: self.btnCashReceive, color: AppColors.BLUE)
                self.setCorner(view: self.viewCashExchange, corner: 3, color: AppColors.BLUE)
                self.setCorner(view: self.viewCashReceive, corner: 3, color: AppColors.BLUE)
                self.btnVerify.isEnabled = false
                self.btnVerify.alpha = AppConstants.ALPHA_DISBALE
            }
        }
        self.viewModel.doBindingDataToView()
        self.viewModel.getListAvailable()
        self.viewModel.doBindingExchangeCash()
        hideView(isHide: true)
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listAvailable
        self.tableView.reloadData()
        log(message: "List available......")
        log(object: self.viewModel.listAvailable)
    }
    
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ExchangeeCash.rawValue, items: self.viewModel.listAvailable,isSelectionStype: false){ cell, vm in
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ExchangeeCash.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
    }
    
    func setCorner(view : UIView,corner : CGFloat, color : UIColor){
        view.setRadius(corner: 3, color: color)
    }
    
    func setTextColor(view : UIButton, color : UIColor){
        view.setTitleColor(color, for: .normal)
    }
    
    func alertAddeCashSuccessful(){
        let data = PassDataViewModel(identifier: EnumPassdata.EXCHANGE_CASH, exchangeeCash: ExchangeeCashData())
        ShareSignUpSingleton.shared.set(value: data)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.alert, isNavigation: false,isTransparent: true, present: true)
    }
    
    func hideView(isHide : Bool){
        lbTotalExchangeCash.isHidden = isHide
        lbTotalExchangeCashValue.isHidden = isHide
        lbTotalExpectationCash.isHidden = isHide
        lbTotalExpectationCashValue.isHidden = isHide
        if isHide {
            heightContraint.constant = 20
        }else{
            heightContraint.constant = 100
        }
    }
    
}

extension ExchangeeCashVC : SingleButtonDialogPresenter {
    
}

extension ExchangeeCashVC : TableViewCellDelegate {
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
