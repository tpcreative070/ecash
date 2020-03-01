//
//  NotificationHistoryVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension NotificationHistoryVC {
    func initUI(){
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        self.lbTitle.textColor = AppColors.BLUE
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.NotificationHistory)
        self.lbTitle.textAlignment = .center
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
        self.viewModel.getNotificationList()
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listNotificationHistory
        self.dataSource.configureSwipeCell = { cell,vm in
            self.log(object: vm)
            self.viewModel.currentCell = vm
        }
        self.dataSource.swipeActionRight = swipeActionRight()
        self.tableView.reloadData()
        log(message: "List available...")
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.NotificationHistory.rawValue, items: self.viewModel.listNotificationHistory,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.dataSource.configureSwipeCell = { cell,vm in
            self.log(object: vm)
            self.viewModel.currentCell = vm
        }
        self.dataSource.swipeActionRight = swipeActionRight()
        self.dataSource.loadMore = {
            self.log(message: "Loading more")
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    func setupTableView(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.NotificationHistory.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
    }
    
    func swipeActionRight() ->UISwipeActionsConfiguration{
           let deleteAction = UIContextualAction(style: .normal, title:  LanguageHelper.getTranslationByKey(LanguageKey.Delete), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
               print("Update action ...")
               success(true)
               if let mData  = self.viewModel.currentCell{
                if let mIndex = mData.groupId {
                    SQLHelper.deleteNotificationHistory(index: mIndex)
                    self.viewModel.getNotificationList()
                }
               }
           })
           deleteAction.backgroundColor = AppColors.RED_COLOR
           let mConfig = UISwipeActionsConfiguration(actions: [deleteAction])
           mConfig.performsFirstActionWithFullSwipe = false
           return mConfig
       }
       
}

extension NotificationHistoryVC : SingleButtonDialogPresenter {
    
}
extension NotificationHistoryVC : TableViewCellDelegate {
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
