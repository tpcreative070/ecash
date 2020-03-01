//
//  ScannerResultVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ScannerResultVC {
    func initUI(){
        self.keyboardHelper = KeyboardHelper(viewController: self, scrollView: scrollView)
        self.keyboardHelper?.setDismissKeyboardWhenTouchOutside()
        view.fixInputAssistant()
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ReceiveeCash)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.textColor = AppColors.BLUE
        
        self.viewCash.backgroundColor = AppColors.GRAY_LIGHT_90
        self.viewTransactionTitle.backgroundColor = AppColors.GRAY_LIGHT
        self.viewQualityTitle.backgroundColor = AppColors.GRAY_LIGHT
        
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        
        self.lbReceiveeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.ReceiveeCash)?.uppercased()
        self.lbReceiveeCash.textAlignment = .center
        self.lbReceiveeCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbReceiveeCash.text = LanguageHelper.getTranslationByKey(LanguageKey.ReceiveeCash)?.uppercased()
        self.lbReceiveeCash.textAlignment = .center
        self.lbReceiveeCash.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        
        self.lbStatus.text = LanguageHelper.getTranslationByKey(LanguageKey.Success)
        self.lbStatus.textColor = AppColors.BLUE
        self.lbStatus.textAlignment = .center
        self.lbTransactionsInfo.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 2)
        self.lbTransactionsInfo.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionsInfo)
        self.lbeCashAmount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 2)
        self.lbeCashAmount.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashTotal)
        self.lbSender.text = LanguageHelper.getTranslationByKey(LanguageKey.Sender)
        self.lbPhoneNumber.text = LanguageHelper.getTranslationByKey(LanguageKey.PhoneNumber)
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.Content)
        self.lbMoney.textAlignment = .center
        
        self.lbMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        
        self.lbSender.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbPhoneNumber.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbContent.textColor = AppColors.GRAY_LIGHT_TEXT
        
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
        
        self.viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.tableConstraints.constant = CGFloat((self?.viewModel.listCash.count ?? 1) * 64)
                self?.updateDataSource()
            }
        }
        
        self.viewModel.senderNameBinding.bind { value in
            self.lbSenderValue.text = value
        }
        
        self.viewModel.phoneNumberBinding.bind { value in
            self.lbPhoneNumberValue.text = value
        }
        
        self.viewModel.contentBinding.bind { value in
            self.lbContentValue.text = value
        }
        
        self.viewModel.totalMoneyBinding.bind { value in
            self.lbMoney.text = value
            self.log(message: "moneny.....\(value)")
        }
        self.viewModel.doGetIntent()
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listCash
        self.tableView.reloadData()
        log(message: "List available...")
        log(object: self.viewModel.listCash)
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.ScannerResult.rawValue, items: self.viewModel.listCash,isSelectionStype: false){ cell, vm in
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.ScannerResult.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
    }
}

extension ScannerResultVC : SingleButtonDialogPresenter {
    
}

extension ScannerResultVC : TableViewCellDelegate {
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
