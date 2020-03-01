//
//  LixiVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension LixiVC {
    func initUI(){
        if let rightData =  UIImage(named: AppImages.IC_SEND) {
                 addButtonCustom(image: rightData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: false)
        }
        
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        self.lbTitle.textColor = AppColors.BLUE
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.YourLixi)
        self.lbTitle.textAlignment = .center
        setupTableView()
        bindTableView()
    }
    
    func bindingViewModel() {
        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.updateDataSource()
            }
        }
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        viewModel.receiveLixiOptionsData.bind { (value) in
            CommonService.sendDataToReceivedLixiOptions(data: value, isResponse: false)
            Navigator.pushViewMainStoryboard(from: self, identifier: Controller.receiveLixiOptions, isNavigation: false, isTransparent: true, present: true)
            self.viewModel.getLixi()
        }
        self.viewModel.getLixi()
    }
      
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listLixi
        self.tableView.reloadData()
    }
      
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.Lixi.rawValue, items: self.viewModel.listLixi,isSelectionStype: false){ cell, vm in
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.Lixi.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.isScrollEnabled = false
    }
}

extension LixiVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellCodable(codable: Codable) {
        
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        log(message: "selected \(indexPath.row)")
        self.viewModel.doOpenLixi(index: indexPath.row)
        debugPrint("Lixi")
    }
}

extension LixiVC : SingleButtonDialogPresenter {
    
}
