//
//  QRCodeHistoryVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/15/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension QRCodeHistoryVC {
    func initUI(){
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.GeneratedQR)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        
        if let rightData =  UIImage(named: AppImages.IC_CHECK_LIST) {
            addButtonCustom(image: rightData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: false)
        }
        
        btnSend.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Send), for: .normal)
        btnSend.addTarget(self, action: #selector(actionSend), for: .touchUpInside)
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.cornerButton(corner: 3, color: AppColors.BLUE)
        
        btnDelete.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Delete), for: .normal)
        btnDelete.addTarget(self, action: #selector(actionDelete), for: .touchUpInside)
        btnDelete.setTitleColor(.white, for: .normal)
        btnDelete.cornerButton(corner: 3, color: AppColors.BLUE)
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
               self?.updateDataSource()
            }
        }
        self.viewModel.shareIntent.bind { value in
            if value.count > 0 {
                self.shareFile(images: value)
            }
        }
        self.viewModel.isVisible.bind { (value) in
            if value{
                self.btnSend.isEnabled = value
                self.btnSend.alpha = AppConstants.ALPHA_DEFAULT
                self.btnDelete.isEnabled = value
                self.btnDelete.alpha = AppConstants.ALPHA_DEFAULT
            }else{
                self.btnSend.isEnabled = value
                self.btnSend.alpha = AppConstants.ALPHA_DISBALE
                self.btnDelete.isEnabled = value
                self.btnDelete.alpha = AppConstants.ALPHA_DISBALE
            }
        }
        self.viewModel.isSelected.bind { (value) in
            self.viewModel.doSelectedAll(isValue: value)
        }
        self.viewModel.doGetListQRCode()
    }
    
    func updateDataSource() {
        self.sections = TableSection.group(rowItems: self.viewModel.listQRCode, by: { (headline) in
            return headline.transactionIdView ?? ""
        })
        self.dataSource.sections = self.sections
        self.dataSource.items = self.viewModel.listQRCode
        self.tableView.reloadData()
        log(message: "List available...")
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.QRCodeHistory.rawValue, items: self.viewModel.listQRCode,sections: self.sections, height: 30,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        
        self.dataSource.headerSection = { section, vm in
            section.delegate = self
            section.configView(view: vm)
        }
        self.dataSource.loadMore = {
            self.log(message: "Loading more")
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.QRCodeHistory.rawValue)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: EnumIdentifier.QRCodeHistory.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.sectionFooterHeight = 0
    }
}

extension QRCodeHistoryVC : SingleButtonDialogPresenter {
    
}

extension QRCodeHistoryVC : HeaderSectionDelegate {
    func cellSectionSelected(codable: Codable) {
        
    }
}

extension QRCodeHistoryVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        log(object: cell)
        self.viewModel.getObject(codable: cell)
    }
    
    func cellCodable(codable: Codable) {
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}
