//
//  ContactVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension ContactVC {
    func initUI(){
        self.navigationController?.isNavigationBarHidden = true
        if ((self.navigationController?.hasViewController(ofKind: ContactVC.self)) == nil){
            if let leftData =  UIImage(named: AppImages.IC_BACK) {
                addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
            }
        }
        
        if let rightData =  UIImage(named: AppImages.IC_PLUS) {
            addButton = addButtonSpecialCustom(image: rightData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: false)
        
            doneButton = addButtonSpecialCustom(text: LanguageHelper.getTranslationByKey(LanguageKey.Done) ?? "", isLeft: false)
            if let mDoneButton = doneButton {
                mDoneButton.isHidden = true
            }
        }
        
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.Contact)?.uppercased()
        self.lbTitle.textAlignment = .center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbTitle.textColor = AppColors.BLUE
        self.viewSearchRoot.backgroundColor = AppColors.GRAY_LIGHT
        self.viewSearch.setCorner(corner: 5, color: .white)
        self.imgSearch.image = UIImage(named: AppImages.IC_SEARCH)
        self.imgClear.image = UIImage(named: AppImages.IC_DELETE)
        self.imgClear.isUserInteractionEnabled = true
        self.imgClear.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionClear(sender:))))
        addTarget(textFieldSearch)
        textFieldSearch.placeholder = LanguageHelper.getTranslationByKey(LanguageKey.TypeName)
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
     
        self.viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.updateDataSource()
            }
            else if value == EnumResponseToView.MULTIPLE_SELECTED_DONE.rawValue {
                self?.doMultipleSelected()
            }
        }
        self.viewModel.isContactBinding.bind { value in
            if !value{
                //self.doAlertMessage(permission: LanguageHelper.getTranslationByKey(LanguageKey.Contact) ?? "")
            }
        }
        self.viewModel.isSelected.bind { (value) in
            self.addButton?.isHidden = value
            self.doneButton?.isHidden = !value
        }
        
        ShareSyncContactSingleton.shared.bind{ [weak self] in
            debugPrint("ShareSingleton.shared.bind....")
            self?.viewModel.doGetListContacts()
        }
        self.viewModel.doGetListContacts()
    }
    
    func updateDataSource() {
        self.sections = TableSection.group(rowItems: self.viewModel.listContacts, by: { (headline) in
            return headline.firstCharacterView
        })
        //self.dataSource.swipeActionRight = swipeActionRight()
        self.dataSource.swipeActionLeft = swipeActionLeft()
        self.dataSource.sections = self.sections
        self.dataSource.items = self.viewModel.listContacts
        self.tableView.reloadData()
        log(message: "List available...")
        log(object: self.viewModel.listContacts)
    }
    
    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.Contact.rawValue, items: self.viewModel.listContacts,sections: self.sections, height: 30,isSelectionStype: false){ cell, vm in
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
        self.dataSource.configureSwipeCell = { cell,vm in
            self.log(object: vm)
            self.viewModel.currentCell = vm
        }
        //self.dataSource.swipeActionRight = swipeActionRight()
        self.dataSource.swipeActionLeft = swipeActionLeft()
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.Contact.rawValue)
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: EnumIdentifier.Contact.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.sectionFooterHeight = 0
    }
    
//    func swipeActionRight() ->UISwipeActionsConfiguration{
//        let transferAction = UIContextualAction(style: .normal, title:  LanguageHelper.getTranslationByKey(LanguageKey.Transfer), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Update action ...")
//            success(true)
//            if let mData  = self.viewModel.currentCell{
//                if ((self.navigationController?.hasViewController(ofKind: ContactVC.self)) == nil){
//                    CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, eCash: mData.walletId), isResponse: true)
//                    self.dismiss()
//                }else{
//                    CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, eCash: mData.walletId), isResponse: false)
//                    Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transfereCashMultiple, isNavigation: false)
//                }
//            }
//        })
//        transferAction.backgroundColor = AppColors.BLUE
//        let mConfig = UISwipeActionsConfiguration(actions: [transferAction])
//        mConfig.performsFirstActionWithFullSwipe = false
//        return mConfig
//    }
    
    
    func doMultipleSelected(){
        if ((self.navigationController?.hasViewController(ofKind: ContactVC.self)) == nil){
            CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, ecashArray : self.viewModel.listReceiver), isResponse: true)
            self.dismiss()
        }else{
            CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, ecashArray:  self.viewModel.listReceiver), isResponse: false)
            Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transfereCashMultiple, isNavigation: false)
        }
    }
    
    func swipeActionLeft() ->UISwipeActionsConfiguration{
        let edit = UIContextualAction(style: .normal, title:  LanguageHelper.getTranslationByKey(LanguageKey.Edit), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
            
            if let mValue = self.viewModel.currentCell {
                CommonService.sendDataToContactEntities(data: ContactsEntityModel(data : mValue), isResponse: false)
                Navigator.pushViewMainStoryboard(from: self, identifier: Controller.editContact, isNavigation: false, isTransparent: true, present: true)
            }
        })
        
        let delete = UIContextualAction(style: .normal, title:  LanguageHelper.getTranslationByKey(LanguageKey.Delete), handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            self.viewModel.doDeleteContact()
            if let mValue = self.viewModel.currentCell {
                GlobalRequestApiHelper.shared.doDeleteContact(walletId: mValue.walletId ?? "")
            }
            success(true)
        })
        edit.backgroundColor = AppColors.BLUE
        delete.backgroundColor = AppColors.RED_COLOR
        let mConfig = UISwipeActionsConfiguration(actions: [edit,delete])
        mConfig.performsFirstActionWithFullSwipe = false
        return mConfig
    }
}

extension ContactVC : TableViewCellDelegate{
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        self.viewModel.doSelectItem(coable: cell)
        //log(object: cell)
    }
    
    func cellCodable(codable: Codable) {
        
    }
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}

extension ContactVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupDelegate() {
        self.textFieldSearch.delegate = self
    }
}

extension ContactVC : SingleButtonDialogPresenter{
    
}

extension ContactVC : HeaderSectionDelegate {
    func cellSectionSelected(codable: Codable) {
       
    }
}

