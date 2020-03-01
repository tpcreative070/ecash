//
//  AddContactVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension AddContactVC {
    func initUI(){
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        
        if let rightData =  UIImage(named: AppImages.IC_SCAN) {
            addButton = addButtonSpecialCustom(image: rightData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: false)
        
            doneButton = addButtonSpecialCustom(text: LanguageHelper.getTranslationByKey(LanguageKey.Done) ?? "", isLeft: false)
            if let mDoneButton = doneButton {
                mDoneButton.isHidden = true
            }
        }

        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.AddContact)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.viewSearchRoot.backgroundColor = AppColors.GRAY_LIGHT
        self.viewSearch.setCorner(corner: 5, color: .white)
        self.imgSearch.image = UIImage(named: AppImages.IC_SEARCH)
        self.imgClear.image = UIImage(named: AppImages.IC_DELETE)
        self.imgClear.isUserInteractionEnabled = true
        self.imgClear.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionClear(sender:))))
        self.textFieldSearch.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.TypePhoneNumberWalletId)
        addTarget(textFieldSearch)
        setupTableView()
        bindTableView()
    }
    
    func addTarget(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(inputFieldEditingDidEnd), for: .editingDidEnd)
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
       
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listContacts
        self.dataSource.swipeActionRight = swipeActionRight()
        self.tableView.reloadData()
        log(message: "List available...")
        log(object: self.viewModel.listContacts)
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.AddContact.rawValue, items: self.viewModel.listContacts,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        
        self.dataSource.loadMore = {
            self.log(message: "Loading more")
        }
        self.dataSource.configureSwipeCell = { cell,vm in
            self.log(object: vm)
            self.viewModel.currentCell = vm
        }
        self.dataSource.swipeActionRight = swipeActionRight()
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    func setupTableView(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.AddContact.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
    }
    
    func swipeActionRight() ->UISwipeActionsConfiguration{
        let addNewAction = UIContextualAction(style: .normal, title:  LanguageHelper.getTranslationByKey(LanguageKey.Add), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
            if let mData  = self.viewModel.currentCell{
                if self.viewModel.isAllowInsert(data: mData){
                    CommonService.saveItemToContact(contact: ContactsEntityModel(data: mData))
                    GlobalRequestApiHelper.shared.doAddContact(walletData: [mData.walletId ?? ""])
                    self.dismiss()
                }else{
                    self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.CouldNotAddToItself) ?? "")
                }
            }
        })
        
        let transferAction = UIContextualAction(style: .normal, title:  LanguageHelper.getTranslationByKey(LanguageKey.Transfer), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
            if let mData  = self.viewModel.currentCell{
                if self.viewModel.isAllowInsert(data: mData){
                    CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, eCash: mData.walletId), isResponse: false)
                    Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transfereCashMultiple, isNavigation: false, present: true)
                }else{
                    self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.CouldNotTransferToItself) ?? "")
                }
            }
        })
        transferAction.backgroundColor = AppColors.BLUE
        addNewAction.backgroundColor = AppColors.GRAY
        let mConfig = UISwipeActionsConfiguration(actions: [transferAction,addNewAction])
        mConfig.performsFirstActionWithFullSwipe = false
        return mConfig
    }
}

extension AddContactVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldSearch.delegate = self
    }
}

extension AddContactVC : SingleButtonDialogPresenter {
    
}

extension AddContactVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        log(message: "Action here...")
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        debugPrint("Cell")
    }
    
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellCodable(codable: Codable) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}
