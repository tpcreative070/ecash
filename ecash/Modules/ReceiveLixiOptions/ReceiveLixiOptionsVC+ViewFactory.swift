//
//  ReceiveLixiOptionsVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ReceiveLixiOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewOptions.setCorner(corner: 3, color: .white)
        self.lbTitle.textColor = AppColors.BLUE
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.LuckyMoney)
        self.lbTotalLixi.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTotalLixiValue.textColor = AppColors.BLUE
        self.lbTotalLixiValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 2)
        self.lbTotalLixiValue.textAlignment = .right
        self.lbTotalLixi.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalMoney)
        
        btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        btnVerify.setTitleColor(.white, for: .normal)
        btnVerify.cornerButton(corner: 5, color: AppColors.BLUE)
        self.lbNoAvailableMoney.text = LanguageHelper.getTranslationByKey(LanguageKey.NoListAvailable)
        self.lbNoAvailableMoney.textAlignment = .center
        self.lbNoAvailableMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        
        self.lbLuckyMessage.textColor = AppColors.BLUE
        self.lbLuckyMessage.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbLuckyMessage.text = LanguageHelper.getTranslationByKey(LanguageKey.Greetings)
        self.lbLuckyMessageValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbLuckyMessageValue.text = LanguageHelper.getTranslationByKey(LanguageKey.GreetingsMessage)
        self.lbLuckyMessageValue.numberOfLines = 0
        self.lbLuckyMessageValue.lineBreakMode = .byWordWrapping
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
            
        self.viewModel.lixiBinding.bind { data in
            self.lbTotalLixiValue.text = data
        }
        self.viewModel.contentBinding.bind { (value) in
            self.lbLuckyMessageValue.text = value
        }
        self.viewModel.imgTemplateBinding.bind { (value) in
            self.imgTemplateCode.image = value
        }
        self.viewModel.getIntent()
    }
        
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listeCash
        self.tableView.reloadData()
    }
        
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ReceiveLixiOptions.rawValue, items: self.viewModel.listeCash,isSelectionStype: false){ cell, vm in
                cell.configView(view: vm)
                cell.configData(viewModel: vm)
                cell.delegate = self
        }
           
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
            
    }
        
    func setupTableView(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ReceiveLixiOptions.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.isScrollEnabled = true
    }
           
}

    extension ReceiveLixiOptionsVC : TableViewCellDelegate {
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

    extension ReceiveLixiOptionsVC  : SingleButtonDialogPresenter{
        
    }
