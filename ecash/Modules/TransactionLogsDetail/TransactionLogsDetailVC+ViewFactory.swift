//
//  TransactionLogsDetailVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TransactionLogsDetailVC {
    func initUI(){
        if let leftData =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftData.maskWithColor(color: AppColors.BLUE) ?? UIImage(), isLeft: true)
        }
        self.lbTitle.textColor = AppColors.BLUE
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionDetail)
        self.lbTitle.textAlignment = .center
        
        self.lbTransactionInfoTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionsInfo)
        self.lbAmountCashTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.eCashEmount)
        self.lbQRCodeInfo.text = LanguageHelper.getTranslationByKey(LanguageKey.QRCode)
        
        self.imgShare.image = UIImage(named: AppImages.IC_SHARE)
        self.lbShare.text = LanguageHelper.getTranslationByKey(LanguageKey.Share)
        
        self.imgSaveToDevice.image = UIImage(named: AppImages.IC_DOWNLOAD)
        self.lbSaveToDevice.text = LanguageHelper.getTranslationByKey(LanguageKey.SaveToDevice)
        
        self.viewShare.isUserInteractionEnabled = true
        self.viewShare.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionShare(sender:))))
        
        self.viewSave.isUserInteractionEnabled = true
        self.viewSave.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionSave(sender:))))
        self.viewRoot.backgroundColor = AppColors.GRAY_LIGHT
        self.viewStatus.backgroundColor = AppColors.GRAY_LIGHT_90
        
        self.lbReceiverNumber.text = LanguageHelper.getTranslationByKey(LanguageKey.ReceiverCode)
        self.lbReceiverNumber.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbReceiverNumber.textColor = AppColors.GRAY_LIGHT_TEXT
        
        self.lbFullName.text = LanguageHelper.getTranslationByKey(LanguageKey.FullNameTitle)
        self.lbFullName.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbFullName.textColor = AppColors.GRAY_LIGHT_TEXT
        
        self.lbPhoneNumber.text = LanguageHelper.getTranslationByKey(LanguageKey.PhoneNumber)
        self.lbPhoneNumber.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbPhoneNumber.textColor = AppColors.GRAY_LIGHT_TEXT
        
//        self.lbIssuer.text = LanguageHelper.getTranslationByKey(LanguageKey.Issuer)
        self.lbIssuer.text = LanguageHelper.getTranslationByKey(LanguageKey.SummaryValues)
        self.lbIssuer.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbIssuer.textColor = AppColors.GRAY_LIGHT_TEXT
        
        self.lbContent.text = LanguageHelper.getTranslationByKey(LanguageKey.Content)
        self.lbContent.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbContent.textColor = AppColors.GRAY_LIGHT_TEXT
        
        self.lbCreatedDate.text = LanguageHelper.getTranslationByKey(LanguageKey.CreatedDate)
        self.lbCreatedDate.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbCreatedDate.textColor = AppColors.GRAY_LIGHT_TEXT
        
    
        self.lbType.textAlignment = .center
        self.lbMoney.textAlignment = .center
        self.lbMoney.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 4)
        self.lbStatus.textAlignment = .center
        self.lbStatus.textColor = AppColors.BLUE
        
        
        self.lbReceiverNumberValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbReceiverNumberValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbReceiverNumberValue.textAlignment = .right
        
        self.lbFullNameValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbFullNameValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbFullNameValue.textAlignment = .right
        
        self.lbPhoneNumberValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbPhoneNumberValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbPhoneNumberValue.textAlignment = .right
        
        self.lbIssuerValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbIssuerValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbIssuerValue.textAlignment = .right
        
        self.lbContentValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbContentValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbContentValue.textAlignment = .right
        self.lbContentValue.numberOfLines = 2
        
        self.lbCreatedDateValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        self.lbCreatedDateValue.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbCreatedDateValue.textAlignment = .right
        
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
                self?.tableConstraints.constant = CGFloat((self?.viewModel.list.count ?? 1) * 64)
                self?.updateDataSource()
            }
            else if value == EnumResponseToView.SAVED_TO_DEVICE.rawValue {
                self?.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.SavedToDevice) ?? "")
            }
        }
        
        self.viewModel.isQRCode.bind { (value) in
            if !value{
                self.viewQRCodeTitle.isHidden = true
                self.viewQRCode.isHidden = true
                self.viewShareIntent.isHidden = true
            }
        }
        
        self.viewModel.listImage.bind { (value) in
            self.shareFile(images: value)
        }
        
        self.viewModel.qrCode.bind { (value) in
            self.imgQRCode.image = value
        }
        
        self.viewModel.saveFileToPhotos.bind { (value) in
            UIImageWriteToSavedPhotosAlbum(value, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        self.viewModel.typeBinding.bind { (value) in
            self.lbType.text = value
        }
        self.viewModel.moneyBinding.bind { (value) in
            self.lbMoney.text = value
        }
        self.viewModel.statusBinding.bind { (value) in
            self.lbStatus.text = value
        }
        self.viewModel.receiverBinding.bind { (value) in
            self.lbReceiverNumberValue.text = value
        }
        self.viewModel.fullNameBinding.bind { (value) in
            self.lbFullNameValue.text = value
        }
        self.viewModel.phoneNumberBinding.bind { (value) in
            self.lbPhoneNumberValue.text = value
        }
        self.viewModel.issuerBinding.bind { (value) in
            self.lbIssuerValue.text = value
        }
        self.viewModel.contentBinding.bind { (value) in
            self.lbContentValue.text = value
        }
        self.viewModel.createdDateBinding.bind { (value) in
            self.lbCreatedDateValue.text = value
        }
        self.viewModel.senderBinding.bind { (value) in
            self.lbReceiverNumber.text = value
        }
        
        self.viewModel.isSenderBinding.bind { (value) in
            if (value) {
                self.lbReceiverNumber.text = LanguageHelper.getTranslationByKey(LanguageKey.SenderCode)
            } else {
                self.lbReceiverNumber.text = LanguageHelper.getTranslationByKey(LanguageKey.ReceiverCode)
            }
        }
        
        self.viewModel.doGetIntent()
    }

    func updateDataSource() {
        self.dataSource.items = self.viewModel.list
        self.tableView.reloadData()
        log(message: "List available...")
    }

    //set dataSource fo tableView
    func bindTableView(){
        self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.TransactionsLogsDetail.rawValue, items: self.viewModel.list,isSelectionStype: false){ cell, vm in
            cell.configView(view: vm)
            cell.configData(viewModel: vm)
            cell.delegate = self
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self.dataSource
    }

    func setupTableView(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.TransactionsLogsDetail.rawValue)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = AppConstants.TABLE_ROW_HEIGHT
        tableView.isScrollEnabled = false
    }
    
}

extension TransactionLogsDetailVC : TableViewCellDelegate {
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

extension TransactionLogsDetailVC : SingleButtonDialogPresenter {
    
}
