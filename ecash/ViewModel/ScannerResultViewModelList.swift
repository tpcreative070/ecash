//
//  ScannerResultViewModelList.swift
//  ecash
//
//  Created by phong070 on 10/7/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ScannerResultViewModelList : ScannerResultViewModelListDelegate {
    var walletIdBinding: Bindable<String> = Bindable("")
    var totalMoneyBinding: Bindable<String> = Bindable("")
    
    var senderNameBinding: Bindable<String> = Bindable("")
    
    var phoneNumberBinding: Bindable<String> = Bindable("")
    
    var contentBinding: Bindable<String> = Bindable("")
    
    var listCash: [CashListViewModel] = [CashListViewModel]()
    
    var responseToView: ((String) -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    
    private let userService : UserService
    init(userService : UserService = UserService()) {
        self.userService = userService
    }
    
    func doGetIntent(){
        if let mData = CommonService.getShareScannerResult(){
            if let mTransactions = SQLHelper.geteTransactionsLogs(key: mData.transactionsId ?? ""){
                doBindingUpdate(transactionsId: mData.transactionsId ?? "", walletId: mTransactions.senderAccountId?.description ?? "")
                debugPrint("doBindingUpdate")
            }
        }
    }
  
    func getSenderInfo(senderId : String, transactionsId : String){
        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: senderId)) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("Get public key api=====>")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                       
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message:  LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                                action: AlertAction(buttonTitle: "Ok", handler: {
                                                       print("Ok pressed!")
                                }))
                        self.onShowError?(okAlert)
                        self.showLoading.value = false
                    }
                }
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
    
    func doBindingUpdate(transactionsId : String,walletId : String){
        let mData = ScannerResultViewModel(transactionsId: transactionsId , walletId: walletId)
        Utils.logMessage(message : "Scanner result object.....")
        Utils.logMessage(object: mData)
        self.walletIdBinding.value = walletId
        self.totalMoneyBinding.value = mData.totalMoneyView
        self.senderNameBinding.value = mData.senderNameView
        self.phoneNumberBinding.value = mData.phoneNumnerView
        self.contentBinding.value = mData.contentView
        self.listCash = mData.cashList
        self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
}
