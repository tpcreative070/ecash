//
//  TransactionsLogsDetailListViewModel.swift
//  ecash
//
//  Created by phong070 on 11/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TransactionsLogsDetailListViewModel : TransactionsLogsDetailListViewDelegate {

    var listTransactionQRCode: [TransactionQREntityModel] = [TransactionQREntityModel]()
    var qrCode: Bindable<UIImage> = Bindable(UIImage())
 
    var saveFileToPhotos: Bindable<UIImage> = Bindable(UIImage())
    var listImage: Bindable<[UIImage]> = Bindable([UIImage]())
    var isQRCode: Bindable<Bool> = Bindable(false)
    var list: [CashListTransactionsLogsDetailViewModel] = [CashListTransactionsLogsDetailViewModel]()
    var listQRCode: [String] = [String]()
    
    var isSenderBinding: Bindable<Bool> = Bindable(false)
    
    var senderBinding: Bindable<String> = Bindable("")
    var typeBinding: Bindable<String> = Bindable("")
    var moneyBinding: Bindable<String> = Bindable("")
    
    var statusBinding: Bindable<String> = Bindable("")
    
    var receiverBinding: Bindable<String> = Bindable("")
    
    var fullNameBinding: Bindable<String> = Bindable("")
    
    var phoneNumberBinding: Bindable<String> = Bindable("")
    
    var issuerBinding: Bindable<String> = Bindable("")
    
    var contentBinding: Bindable<String> = Bindable("")
    
    var createdDateBinding: Bindable<String> = Bindable("")
    
    var responseToView: ((String) -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    private let userService : UserService
    init(userService : UserService = UserService()) {
        self.userService = userService
    }
    
    func doGetIntent(){
        if let mData = CommonService.getShareTransactionLogsDetail(){
            Utils.logMessage(object: mData)
            
            let mType = mData.transactionType ?? ""
            let mSenderId = mData.senderId ?? ""
            if mType == EnumTransferType.ECASH_TO_ECASH.rawValue{
                if mSenderId != CommonService.getWalletId() {
                    senderBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.SenderCode) ?? ""
                }
            }
            
            if mType == EnumTransferType.LIXI.rawValue{
                if mSenderId != CommonService.getWalletId() {
                    senderBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.SenderCode) ?? ""
                }else{
                    senderBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.ReceiverCode) ?? ""
                }
            }
                       
            if mType == EnumTransferType.ECASH_TO_ECASH.rawValue {
                if mSenderId != CommonService.getWalletId() {
                    doBindingUpdate(transactionData: mData,isSender : true,transactionType : mType)
                }else{
                    doBindingUpdate(transactionData: mData,isSender : false, transactionType : mType)
                }
            }
            else if mType == EnumTransferType.LIXI.rawValue {
                if mSenderId != CommonService.getWalletId() {
                    doBindingUpdate(transactionData: mData,isSender : true,transactionType : mType)
                }else{
                    doBindingUpdate(transactionData: mData,isSender : false, transactionType : mType)
                }
            }
            else if mType == EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue {
                if mSenderId != CommonService.getWalletId() {
                    doBindingUpdate(transactionData: mData,isSender : true,transactionType : mType)
                }else{
                    doBindingUpdate(transactionData: mData,isSender : false, transactionType : mType)
                }
            }
            else{
                doBindingUpdate(transactionData: mData,isSender : true, transactionType : mType)
            }
        }
    }
    
    func getSenderInfo(transactionData : TransactionLogsData , isSender : Bool){
        self.showLoading.value = true
        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: transactionData.senderId ?? "")) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("Get public key api=====>")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                       
                    }else{
                      
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                        )
                        self.onShowError?(okAlert)
                        
                    }
                }
                self.showLoading.value = false
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                self.showLoading.value = false
                break
            }
        }
    }
    
    func doBindingUpdate(transactionData : TransactionLogsData , isSender : Bool,transactionType : String){
        let mData = TransactionsLogsDetailViewModel(transactionData: transactionData,isSender: isSender,transactionType : transactionType)
        Utils.logMessage(object: mData)
        self.isSenderBinding.value = isSender
        self.listTransactionQRCode = mData.qrCode
        self.typeBinding.value = mData.typeView
        self.moneyBinding.value = mData.moneyView
        self.statusBinding.value = mData.statusView
//        self.issuerBinding.value = mData.issuerView
        self.fullNameBinding.value = ""
        self.phoneNumberBinding.value = ""
        
        var walletIdInfo: String = transactionData.receiverId ?? ""
        if (isSender) {
            walletIdInfo = transactionData.senderId ?? ""
        }
        self.receiverBinding.value = walletIdInfo
        GlobalRequestApiHelper.shared.getWalletInfo(mWalletId: walletIdInfo) { (info) in
            if(info != nil){
                let first = info?.personFirstName ?? ""
                let mid = info?.personMiddleName ?? ""
                let last = info?.personLastName ?? ""
                var fullName = first
                if(mid != ""){
                    fullName += " \(mid)"
                }
                if(last != ""){
                    fullName += " \(last)"
                }
                self.fullNameBinding.value = fullName
                self.phoneNumberBinding.value = info?.personMobilePhone ?? ""
            }
        }
        self.issuerBinding.value = mData.money?.toMoney() ?? "0 VNĐ"
        self.contentBinding.value = mData.contentView
        self.createdDateBinding.value = mData.createdDateView
        self.list = mData.cashList
        self.listQRCode = mData.qrCodeList
        if self.listQRCode.count == 0{
            self.isQRCode.value = false
        }else{
            if let image = QRCodeHelper.shared.generateDataQRCode(from: self.listQRCode[0]){
                self.qrCode.value = image
            }
        }
        self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doShareFiles(){
        if self.listQRCode.count > 0{
            var list = [UIImage]()
            for index in listQRCode {
                if let mImage = QRCodeHelper.shared.generateDataQRCode(from: index){
                    list.append(mImage)
                }
            }
            self.listImage.value = list
            debugPrint(self.listQRCode)
        }
    }
    
    func doSaveToDevice(){
        for index in  listTransactionQRCode{
            if let mImage = QRCodeHelper.shared.generateDataQRCode(from: index.value ?? ""){
                saveFileToPhotos.value = mImage
            }
            if let mQRCode = index.value?.toObject(value: QRCodeModel.self){
                if !(mQRCode.isDisplay ?? false) {
                    let mData = QRCodeModel(data: mQRCode , isDisplay: true)
                    SQLHelper.updateTransactionQR(data: TransactionQREntityModel(data: mData, transactionSignature: index.transactionSignature ?? ""))
                }
            }
        }
        self.responseToView!(EnumResponseToView.SAVED_TO_DEVICE.rawValue)
    }
}
