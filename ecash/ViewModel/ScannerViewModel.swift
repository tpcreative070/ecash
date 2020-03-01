//
//  ScannerViewModel.swift
//  ecash
//
//  Created by phong070 on 10/7/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ScannerViewModel  : ScannerViewModelDelegate{
    var cameraBinding: Bindable<Bool> = Bindable(false)
    var transactionIdBinding: Bindable<String> = Bindable("")
    var responseToView: ((String) -> ())?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    var dictionaryList: [Int : QRCodeModel] = [Int : QRCodeModel]()
    var resultScan: Bindable<String> = Bindable("")
    
    private let userService : UserService
    private let productService : ProductService
    init(productService: ProductService = ProductService(),userService : UserService = UserService()) {
        self.productService = productService
        self.userService = userService
    }
    
    func scannerResult(mValue : String){
        if let qrCodeModel = mValue.toObject(value: QRCodeModel.self) {
            let contentString = qrCodeModel.content!
            print("=-=-=-=-=-=-= contentString =-=-=-=-=-=-=-=")
            dump(contentString)
            let isWaittingForPayToQR = ShareApplicationSingleton.shared.get(key: StorageKey.IsWaittingForPayToQR) as? Bool
            let mWalletId = CommonService.getWalletId() ?? ""
            if (qrCodeModel.type != nil && qrCodeModel.type == EnumTransferType.MYQRCODE.rawValue && isWaittingForPayToQR ?? false) {
                print("____________________( Pay To )____________________")
                if let mQRCode = contentString.toObject(value: MyQRcodeModel.self){
                    let value = "\(mQRCode.walletId ?? 0)"
                    let data = QRResultData(target: EnumViewControllerNameIdentifier.PayToVC.rawValue, valueObject: value, valueObjectType: DataKeyType.StringOriginal)
                    let obj = EventBusObjectData(data: data, type: DataKeyType.QRResultData, identify: EnumViewControllerNameIdentifier.ScannerVC)

                    // This part is handle not allow self scanning
                    if mWalletId == "\(mQRCode.walletId ?? 0)" {
                        print("____________________<< Not Save Self Contact >>____________________")
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.getTranslationByKey(LanguageKey.CouldNotTransferToItself),
                            action: AlertAction(buttonTitle: "Ok", handler: {})
                        )
                        self.onShowError?(okAlert)
                    } else {
                        print("____________________( Saved To Conntact )____________________")
                        GlobalRequestApiHelper.shared.doAddContact(walletData: [value])
                        CommonService.saveItemToContact(contact: ContactsEntityModel(data : mQRCode))
                        CommonService.eventPushActionToObjectView(obj: obj)
                    }
                } else {
                    print("=-=-=-=-=-=-= Error =-=-=-=-=-=-=-=")
                }
            } else if (qrCodeModel.type != nil && qrCodeModel.type == EnumTransferType.QRCODE_TO_PAY.rawValue) {
                print("____________________< OK To Pay >____________________")
                if let mTransfer = contentString.toObject(value: TransferDataModel.self){
                    // This part is handle not allow self scanning
                    if mWalletId == mTransfer.sender ?? "" {
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.getTranslationByKey(LanguageKey.CouldNotTransferToItself),
                            action: AlertAction(buttonTitle: "Ok", handler: {})
                        )
                        self.onShowError?(okAlert)
                    } else {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eventToPayInfoPayment"), object: self, userInfo: ["obj": mTransfer])
                        let data = QRResultData(target: EnumViewControllerNameIdentifier.InfoTransactionOptionsVC.rawValue, valueObject: mTransfer, valueObjectType: DataKeyType.TransferDataModel)
                        let obj = EventBusObjectData(data: data, type: DataKeyType.QRResultData, identify: EnumViewControllerNameIdentifier.ScannerVC)
                        CommonService.eventPushActionToObjectView(obj: obj)
                    }
                }
            } else {
//                print("____________________( Old Old )____________________")
//                let isProfile = mValue.toObject(value: MyQRcodeModel.self)
//                let mData = mValue.toObject(value: QRCodeModel.self)
                if( qrCodeModel.type != EnumTransferType.MYQRCODE.rawValue) {
//                    let mData = qrCodeModel
                    if qrCodeModel.cycle != nil {//chuyển tiền hoặc lì xì
                        Utils.logMessage(object: qrCodeModel as Any)
                        dictionaryList[qrCodeModel.cycle ?? 0] = qrCodeModel
                        let mResult = "\(qrCodeModel.total ?? 0)/\(dictionaryList.count)"
                        let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.QRStatus) ?? "", arguments: [mResult])
                        resultScan.value = message
                        debugPrint("Request update...")
                        Utils.logMessage(object: dictionaryList)
                        if qrCodeModel.total ?? 0 == dictionaryList.count {
                            mergeData()
                        }
                    }
                } else {
                    debugPrint("should Contact..")
                    let isProfile = contentString.toObject(value: MyQRcodeModel.self)!
                    if (isProfile.publicKey != nil){//Contact
                        debugPrint("add Contact..")
                        let walletId = isProfile.walletId!
                        let value = SQLHelper.getContacts(key: walletId)
                        //let value = SQLHelper.searchContacts(key: String(isProfile?.walletId?.datatypeValue))
                        let fullName = value?.fullName ?? ""
                        if(value != nil && !(value?.fullName!.isEmpty)!){
                            let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.AddContactExisted) ?? "", arguments: [String(walletId), fullName])
                            resultScan.value = message
                        } else {
                            if ("\(isProfile.walletId ?? 0)" != mWalletId) {
                                CommonService.saveItemToContact(contact: ContactsEntityModel(data : isProfile))
                                let message   = String(format: LanguageHelper.getTranslationByKey(LanguageKey.AddContactSuccess) ?? "", arguments: [String(walletId), fullName])
                                resultScan.value = message
                                GlobalRequestApiHelper.shared.doAddContact(walletData: [(isProfile.walletId?.description ?? "0")])
                            } else {
                                let okAlert = SingleButtonAlert(
                                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                    message: LanguageHelper.getTranslationByKey(LanguageKey.PleaseScanAnotherWallet),
                                    action: AlertAction(buttonTitle: "Ok", handler: {
//                                        self.defaultValue()
                                    })
                                )
                                self.onShowError?(okAlert)
                            }
                        }
                    } else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.getTranslationByKey(LanguageKey.InvalidQRCode),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                                self.defaultValue()
                            })
                        )
                        self.onShowError?(okAlert)
                    }
                }
            }
            ShareApplicationSingleton.shared.set(key: StorageKey.IsWaittingForPayToQR, value: false)
        }
    }
    
    func mergeData(){
        let sortedDic = dictionaryList.sorted { (aDic, bDic) -> Bool in
            return aDic.key < bDic.key
        }
        var mData = ""
        for (key, value) in sortedDic {
            debugPrint("\(key)")
            mData += value.content ?? ""
        }
        if let mTransfer = mData.toObject(value: TransferDataModel.self){
//                if let mTransfer = qrContent.toObject(value: TransferDataModel.self){
            // Old Logic
            Utils.logMessage(object: mTransfer)
            if mTransfer.receiver ?? "" == CommonService.getWalletId() ?? "" {
                guard let _ = SQLHelper.geteTransactionsLogs(key: mTransfer.id ?? "") else {
                    if mTransfer.type == EnumTransferType.LIXI.rawValue {

                        if let _ = SQLHelper.getCashTempObject(key: mTransfer.id ?? ""){
                            let okAlert = SingleButtonAlert(
                                             title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                             message: LanguageHelper.getTranslationByKey(LanguageKey.QRCodeHasBeenReceivedBefore),
                                             action: AlertAction(buttonTitle: "Ok", handler: {
                                                 print("Ok pressed!")
                                                 self.defaultValue()
                                             })
                                         )
                                         self.onShowError?(okAlert)
                            return
                        }
                        
                        CommonService.doVerifyData(result: mTransfer) { (mResponse) in
                            if let mResult = mResponse{
                                let okAlert = SingleButtonAlert(
                                                  title: LanguageHelper.getTranslationByKey(LanguageKey.Success) ?? "Success",
                                                  message: LanguageHelper.getTranslationByKey(LanguageKey.ReceivedLixiSuccessfully),
                                                  action: AlertAction(buttonTitle: "Ok", handler: {
                                                      print("Ok pressed!")
                                                      self.defaultValue()
                                                      let mCashTemp = CashTempEntityModel(data: mResult)
                                                      SQLHelper.insertedCashTemp(data: mCashTemp)
                                                      CommonService.eventPushActionToView(data: EnumResponseToView.UPDATE_HOME_TO_LIXI)
                                                  })
                                              )
                                  self.onShowError?(okAlert)
                                              
                            }else{
                             let okAlert = SingleButtonAlert(
                                               title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                               message: LanguageHelper.getTranslationByKey(LanguageKey.InvalidQRCode),
                                               action: AlertAction(buttonTitle: "Ok", handler: {
                                                   print("Ok pressed!")
                                                   self.defaultValue()
                                               })
                                           )
                                           self.onShowError?(okAlert)
                            }
                          
                        }
                    }else{
                        CommonService.handleTransactionsLogs(transferData: mTransfer, completion: { (mResponseTransactions) in
                            if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                                CommonService.handCashLogs(transferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogs) in
                                    if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_COMPLETED.rawValue{
                                        Utils.logMessage(message: "Insert cash completed....")
                                        self.transactionIdBinding.value = mTransfer.id ?? ""
                                    }
                                })
                            }
                        })
                    }
                    
                    return
                }
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: LanguageHelper.getTranslationByKey(LanguageKey.QRCodeHasBeenReceivedBefore),
                    action: AlertAction(buttonTitle: "Ok", handler: {
                        print("Ok pressed!")
                        self.defaultValue()
                    })
                )
                self.onShowError?(okAlert)
            }else{
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: LanguageHelper.getTranslationByKey(LanguageKey.TransactionAreSentToAnother),
                    action: AlertAction(buttonTitle: "Ok", handler: {
                        print("Ok pressed!")
                        self.defaultValue()
                    })
                )
                self.onShowError?(okAlert)
            }
        }
    }
    
    func defaultValue(){
        self.resultScan.value = "0/0"
        self.dictionaryList.removeAll()
    }
    
    func askCameraPermission() {
        DispatchQueue.main.async {
            let check = GrantPermission.checkCameraPermission()
            if check == .authorized {
                self.cameraBinding.value = true
            } else if check == .notDetermined {
                GrantPermission.requestCameraPermission { granted in
                    self.cameraBinding.value = granted
                }
            } else {
                self.cameraBinding.value = false
            }
        }
    }
    
    func openAppSetting() {
        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    func doAsync(list : [UIImage]){
           showLoading.value = true
           let myGroup = DispatchGroup()
           for index in list {
               myGroup.enter()
               //Do something and leave
               if let mData = index.toCGImage(){
                   CommonService.onReaderQRcode(tempImage: mData) { (value) in
                       if let mValue = value {
                        self.scannerResult(mValue: mValue)
                       }else {
                         let okAlert = SingleButtonAlert(
                                        title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                        message: LanguageHelper.getTranslationByKey(LanguageKey.InvalidQRCode),
                                        action: AlertAction(buttonTitle: "Ok", handler: {
                                            print("Ok pressed!")
                                            self.defaultValue()
                                        })
                          )
                          self.onShowError?(okAlert)
                       }
                       myGroup.leave()
                   }
               }
           }
        myGroup.notify(queue: .main) {
               print("Finished all requests.")
            self.showLoading.value = false
           }
       }
}
