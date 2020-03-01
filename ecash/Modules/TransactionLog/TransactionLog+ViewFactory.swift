//
//  TransactionLog+ViewFactory.swift
//  ecash
//
//  Created by Tuan Le Anh on 10/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TransactionLogVC {
    func initUI(){
        self.navigationController?.isNavigationBarHidden = true
        if ((self.navigationController?.hasViewController(ofKind: TransactionLogVC.self)) == nil){
            if let leftData =  UIImage(named: AppImages.IC_BACK) {
                addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
            }
        }
        self.imgFilter.image = UIImage(named: AppImages.IC_FILTER)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.Transaction)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.viewSearchRoot.backgroundColor = AppColors.GRAY_LIGHT
        self.viewSearch.setCorner(corner: 5, color: .white)
        self.imgSearch.image = UIImage(named: AppImages.IC_SEARCH)
        self.imgClear.image = UIImage(named: AppImages.IC_DELETE)
        self.imgClear.isUserInteractionEnabled = true
        self.imgClear.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionClear(sender:))))
        self.imgFilter.isUserInteractionEnabled = true
        self.imgFilter.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionFilter(sender:))))
        addTarget(textFieldSearch)
        setupTableView()
        bindTableView()
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidChange), for: .editingChanged)
    }
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        
        ShareTransactionLogsHistorySingleton.shared.bind {
            if let mData = CommonService.getShareTransactionLogsHistory(){
                self.log(object: mData)
                self.viewModel.doFilter(filter: mData)
            }else{
                self.viewModel.doGetListTransactionsLogs()
                self.log(message: "Filter is nil")
            }
        }
     
        self.viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.updateDataSource()
            }
        }
        self.viewModel.doGetListTransactionsLogs()
    }
    
    func updateDataSource() {
        self.sections = TableSection.group(rowItems: self.viewModel.listTransactionsLogs, by: { (headline) in
            var index = headline.transactionDate!.index(headline.transactionDate!.startIndex, offsetBy: 4)
            let year = String(headline.transactionDate![..<index])
            let monthdate = String(headline.transactionDate![index...])
            index = monthdate.index(monthdate.startIndex, offsetBy: 2)
            let month = String(monthdate[..<index])
            let headline = String("\(LanguageHelper.getTranslationByKey(LanguageKey.Months) ?? "") " + month + "/" + year)
            return headline
        })
        self.dataSource.sections = self.sections
        self.dataSource.items = self.viewModel.listTransactionsLogs
        self.tableView.reloadData()
        log(message: "listTransactionsLogs available...")
        log(object: self.viewModel.listTransactionsLogs)
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.Transactions.rawValue, items: self.viewModel.listTransactionsLogs,sections: self.sections, height: 30,isSelectionStype: false){ cell, vm in
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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.Transactions.rawValue)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: EnumIdentifier.Transactions.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.sectionFooterHeight = 0
    }
}

extension TransactionLogVC : TableViewCellDelegate{
    func cellViewSelected(cell: TableViewCell) {
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        if let mData = cell.get(value: TransactionsLogsViewModel.self){
            CommonService.sendDataToTransactionLogsDetail(data: TransactionLogsData(data : mData), isResponse: false)
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transactionLogsDetail, isNavigation: false, isTransparent: false, present: true)
    }
    
    func cellCodable(codable: Codable) {
       
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}

extension TransactionLogVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldSearch.delegate = self
    }
}

extension TransactionLogVC : SingleButtonDialogPresenter{
    
}

extension TransactionLogVC : HeaderSectionDelegate {
    func cellSectionSelected(codable: Codable) {
       
    }
}
