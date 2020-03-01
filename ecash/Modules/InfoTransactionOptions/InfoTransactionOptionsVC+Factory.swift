//
//  InfoTransactionOptionsVC+Factory.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

extension InfoTransactionOptionsVC {
    
    func initUI() {
        self.rootView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.popupView.setRadius(corner: 3,color: AppColors.WHITE_COLOR)
        
        self.lbTitleInfo.text = LanguageHelper.getTranslationByKey(LanguageKey.PaymentInfo)
        self.lbTitleInfo.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbTitleInfo.textColor = AppColors.BLUE
//        self.lbYouArePayment
        
        self.lbTotal.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.ITEM_LABEL_SMALL_FONT_SIZE - 2)
        self.lbTotal.text = LanguageHelper.getTranslationByKey(LanguageKey.TotalEcashPayment)
        self.lbTotal.textColor = AppColors.GRAY_50
        
        self.lbTotalAmount.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.LABEL_FONT_SIZE)
        self.lbTotalAmount.textAlignment = NSTextAlignment.right
        self.lbTotalAmount.textColor = AppColors.BLUE
        self.lbTotalAmount.text = "150.000 VND"
        
        self.lbTitleContent.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.LABEL_FONT_SIZE)
        self.lbTitleContent.text = LanguageHelper.getTranslationByKey(LanguageKey.Content)
        self.lbTitleContent.textColor = AppColors.BLUE
        
        self.lbContent.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.ITEM_LABEL_SMALL_FONT_SIZE - 2)
        self.lbContent.textColor = AppColors.GRAY_50
        
        self.btConfirm.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Confirm)?.uppercased(), for: .normal)
        self.btConfirm.setTitleColor(.white, for: .normal)
        self.btConfirm.cornerButton(corner: 5, color: AppColors.BLUE)
        self.btConfirm.addTarget(self, action: #selector(actionConfirm), for: UIControl.Event.touchUpInside)
        setupTableView()
        bindTableView()
    }
    
    func bindingViewModel() {
        viewModel.grantTotalBinding.bind { (value) in
//            self.lbYouArePayment.text = value
            let start = LanguageHelper.getTranslationByKey(LanguageKey.AmountYouArePayment)
            let mid = LanguageHelper.getTranslationByKey(LanguageKey.ForWallet)
            let atribute = self.buildStringAttributed(start: start ?? "", amount: value, mid: mid ?? "", account: self.viewModel.accountBinding.value)
            self.lbYouArePayment.attributedText = atribute
        }
        viewModel.totalAmountBinding.bind { (value) in
            self.lbTotalAmount.text = value
        }
        viewModel.contentBinding.bind { (value) in
//            self.lbContent.text = value
            if (value != "nil") {
                self.lbContent.text = value
            } else {
                self.lbContent.text = ""
            }
        }
        
        self.viewModel.onShowError = { [weak self] alert in
             self?.presentSingleButtonDialog(alert: alert)
        }
        
        viewModel.responseToView = {[weak self] value in
            if value == EnumResponseToView.UPDATE_DATA_SOURCE.rawValue {
                self?.updateDataSource()
            }
            // Internet error no connection
            else if value == EnumResponseToView.NO_INTERNET_CONNECTION.rawValue {
                self?.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
                self?.btConfirm.hideLoading()
                self?.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.NoInternetConnection) ?? "")
            }
            
            // Socket error no connection
            else if value == EnumResponseToView.NO_SOCKET_CONNECTION.rawValue {
                self?.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
                self?.btConfirm.hideLoading()
                self?.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.SocketConnectError) ?? "")
            }
            else if value == EnumResponseToView.PayToAndToPaySuccessfully.rawValue {
                SwiftEventBusHelper.post(ConfigKey.RequestUpdateeDong)
            }
            
        }
        
        self.viewModel.btStatusBinding.bind { (value) in
            switch value {
            case ButtonStatus.ENABLE:
                self.btConfirm.enableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DEFAULT)
                break
            case ButtonStatus.DISABLE:
                self.btConfirm.disableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DISBALE)
                break
            default :
                break
            }
        }
    }
    
    func setupTableView(){
        self.tbListCash.allowsSelection = false
        self.tbListCash.register(TableViewCell.self, forCellReuseIdentifier: EnumIdentifier.PayInfo.rawValue)
        self.tbListCash.rowHeight = CGFloat(50)
        self.tbListCash.estimatedRowHeight = AppConstants.HEIGHT_BUTTON_DEFAULT
        self.tbListCash.separatorStyle = .none
        self.tbListCash.backgroundColor = .none
    }
    
    //set dataSource fo tableView
      func bindTableView(){
         self.dataSource = TableViewDataSource(cellIdentifier: EnumIdentifier.PayInfo.rawValue, items: self.viewModel.listItems, isSelectionStype: false){ cell, vm in
                     cell.configView(view: vm)
                     cell.configData(viewModel: vm)
                     cell.delegate = self
        }
        self.tbListCash.dataSource = self.dataSource
        self.tbListCash.delegate = self.dataSource
    }
    
    func buildStringAttributed(start: String, amount: String, mid: String, account: String) -> NSMutableAttributedString {
        let st = "\(start) \(amount) \(mid) \(account)"
        let fontSize = AppFonts.ITEM_LABEL_SMALL_FONT_SIZE - 2
        let font = UIFont(name: AppFonts.SFranciscoRegular, size: fontSize)
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font!.pointSize), NSAttributedString.Key.foregroundColor: AppColors.GRAY_80]
        let normalFontAttribute = [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: AppColors.GRAY_50]
        let rangeAmount = (st as NSString).range(of: amount)
        let rangeAccount = (st as NSString).range(of: account)
        let rangeStart = (st as NSString).range(of: start)
        let rangeMid = (st as NSString).range(of: mid)
        let attributedString = NSMutableAttributedString(string: st, attributes: [NSAttributedString.Key.font: font!])
        attributedString.addAttributes(boldFontAttribute, range: rangeAmount)
        attributedString.addAttributes(boldFontAttribute, range: rangeAccount)
        attributedString.addAttributes(normalFontAttribute, range: rangeStart)
        attributedString.addAttributes(normalFontAttribute, range: rangeMid)
        
        return attributedString
    }
    
    func updateDataSource() {
        self.dataSource.items = self.viewModel.listItems
        self.tbListCash.reloadData()
    }
    
}
extension InfoTransactionOptionsVC: TableViewCellDelegate{
    func cellViewSelected(cell: TableViewCell) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, action: EnumResponseToView) {
        
    }
    
    func cellViewSelected(cell: TableViewCell, countSelected: Int) {
        
    }
    
    func cellViewSelected(cell: Codable) {
        
    }
    
    func cellCodable(codable: Codable) {
        
    }
}

extension InfoTransactionOptionsVC : SingleButtonDialogPresenter{
    
}
