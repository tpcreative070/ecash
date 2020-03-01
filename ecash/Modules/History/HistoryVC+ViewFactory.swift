//
//  HomeVC+ViewFactory.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import SQLite
extension HistoryVC {
    
    func initUI(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = .white
        let buttonSignOut = ICButton(type: .system)
        buttonSignOut.setTitleColor(AppColors.BLUE_LIGHT_COLOR, for: .normal)
        buttonSignOut.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.SignOut), for: .normal)
        buttonSignOut.addTarget(self, action: #selector(onSignOut), for: .touchUpInside)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: buttonSignOut)]
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let buttonSync = ICButton(type: .system)
        buttonSync.setTitleColor(AppColors.BLUE_LIGHT_COLOR, for: .normal)
        buttonSync.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Sync), for: .normal)
        buttonSync.addTarget(self, action: #selector(onSync), for: .touchUpInside)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: buttonSync)]
        navigationItem.leftBarButtonItem?.isEnabled = true
    }
    
    func bindingViewModel() {
        viewModel.bindToSourceViewModels = {
            self.updateDataSource()
        }
        viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        setupTableView()
        bindTableView()
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.list
        self.tableView.reloadData()
    }
    
    //set dataSource fo tableView
    func bindTableView() {
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.Home.rawValue, items: self.viewModel.list) { cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.dataSource.loadMore = {
        }
        self.tableView.dataSource = self.dataSource
    }
    
    func setupTableView(){
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.Home.rawValue)
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.separatorStyle = .none
    }
    
    func onTakePicture(){
        let fdTakeController = GalleryHelper.showGallery()
        fdTakeController.didGetPhoto = {
            (_ photo: UIImage, _ info: [AnyHashable : Any]) in
            let mUrl = info[UIImagePickerController.InfoKey.imageURL.rawValue] as! URL
            self.log(message: "Response \(mUrl)")
        }
        fdTakeController.didGetVideo = {
            (_ video : URL, _ info: [AnyHashable : Any]) in
            self.log(message: "Response \(video.absoluteString)")
        }
        fdTakeController.presentingView = self.view
        fdTakeController.allowsVideo = true
        fdTakeController.allowsPhoto = true
        fdTakeController.present()
    }
    
    //TestCipher
}

extension HistoryVC : SingleButtonDialogPresenter{
}

extension HistoryVC : TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        if let data =   cell.get(value: HomeViewModel.self) {
            log(object: data)
        }
    }
    
    func cellCodable(codable: Codable) {
     
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
          
    }
}

extension HistoryVC : DownloadDelegate {
    func complete() {
        log(message: "Downloaded successfully")
    }
}
