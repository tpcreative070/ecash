//
//  ExchangeViewModel.swift
//  ecash
//
//  Created by phong070 on 10/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExchangeeCashListViewModel : ExchangeeCashListDelegate {
    var matchValueBinding: Bindable<Bool> = Bindable(false)
    var exchangeCashBinding: Bindable<String> = Bindable("")
    var expectationCashBinding: Bindable<String> = Bindable("")
    var listAvailable: [ExchangeeCashViewModel] = [ExchangeeCashViewModel]()
    var responseToView: ((String) -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var fullNameBinding: Bindable<String> = Bindable("")
    var eCashIdBinding: Bindable<String> = Bindable("")
    var eCashBalanceBinding: Bindable<String> = Bindable("")
    var eDongIdBinding: Bindable<String> = Bindable("")
    var eDongBalanceBinding: Bindable<String> = Bindable("")
    var eDongAccountListBinding: Bindable<[String]> = Bindable([])
    var idNumberBinding: Bindable<String> = Bindable("")
    var eCashPhoneNumber: Bindable<String> = Bindable("")
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    private let productService : ProductService
    private let userService : UserService
    init(productService : ProductService = ProductService(), userService : UserService = UserService()) {
        self.productService = productService
        self.userService = userService
    }
    
    func doBindingDataToView(data : eDongInfoData? = nil){
        guard let mData = data else {
            doBindingUpdate()
            return
        }
        
        guard let mAccountList = mData.listAcc else{
            doBindingUpdate()
            return
        }
        userProfile.value = UserProfileViewModel(data: mAccountList)
        doBindingUpdate()
    }
    
    func doGetKeyOrganizeRelease(){
        if !CommonService.isSigined() {
            return
        }
        showLoading.value = true
        userService.getPublicKeyOrganizeRelease(data : PublicKeyOrganizeReleaseRequestModel()) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let organizeRelease = PublicKeyOrganizeReleaseViewModel(data: response.responseData)
                        self.doPreparingData(issuerKpValue: organizeRelease.issuerKpValue ?? "")
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
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                self.showLoading.value = false
                break
            }
        }
    }

    func doExchangeCash(savedLocalExchanged : TransferDataModel,data : ExchangeCashRequestModel , requestArray : [[String]]){
        showLoading.value = true
        productService.exchangeCash(data: data) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let transferData = TransferDataModel(data: ExchangeeCashViewModel(data: response.responseData))
                        CommonService.handleTransactionsLogs(transferData: transferData, completion: { (mResponseTransactions) in
                            if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                                CommonService.handCashLogs(transferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogs) in
                                    if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_COMPLETED.rawValue{
                                        CommonService.bindingData()
                                        self.getListAvailable()
                                        self.responseToView!(EnumResponseToView.EXCHANGE_CASH.rawValue)
                                        debugPrint("Saved in successfully")
                                    }
                                })
                            }
                        })
                        self.savedToDB(golbalTransactionId: transferData.id ?? "", requestArray: requestArray)
                    }else{
                        let okAlert = SingleButtonAlert(
                                title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                                message:  CommonService.getErrorMessageFromSystem(code: response.responseCode ?? "0"),
                                action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                        }))
                        self.onShowError?(okAlert)
                    }
                }
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                self.showLoading.value = false
                break
            }
        }
    }
    
    func doBindingUpdate(){
        let userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
        let profile = userProfile.value
        fullNameBinding.value = profile.fullNameView ?? ""
        eCashIdBinding.value = profile.eCashIdView ?? ""
        eCashBalanceBinding.value = profile.eCashBalanceView ?? ""
        eDongIdBinding.value = profile.eDongIdView ?? ""
        eDongBalanceBinding.value = profile.eDongBalanceView ?? ""
        eDongAccountListBinding.value = profile.listeDong
        responseToView!(EnumResponseToView.CLEAN_CONTROL.rawValue)
    }
    
    func getListAvailable(){
        guard let mList = SQLHelper.getListAvailable() else{
            self.responseToView!(EnumResponseToView.NO_LIST_AVAILABLE.rawValue)
            return
        }
        let result = mList.group(by: {$0.value})
        listAvailable.removeAll()
        result.enumerated().forEach { (index, element) in
            debugPrint(result.count)
            listAvailable.append(ExchangeeCashViewModel(money : element.key?.description ?? "" ,data: element.value))
        }
        listAvailable = listAvailable.sorted {$0.groupId > $1.groupId}
        self.responseToView!(EnumResponseToView.LIST_AVAILABLE.rawValue)
    }
    
    func sendRequest(isExchangeCash : Bool,isResponse : Bool){
        guard var mData = CommonService.getShareExchangeCash() else {
            CommonService.sendDataToExchangeCash(data: ExchangeeCashData(totalExchangeCash: nil, totalExpectationCash: nil, listExchangeCash: [ExchangeCashModel](), expectationCash: ExpectationCashData(), isExchangeCash : isExchangeCash), isResponse: isResponse)
            return
        }
        mData.isExchangeCash = isExchangeCash
        CommonService.sendDataToExchangeCash(data: mData, isResponse: isResponse)
    }
    
    func doFinalCalculatorExchangeCash() ->  [CashLogsEntityModel]{
        if let mData = CommonService.getShareExchangeCash() {
            return mData.listExchangeCash.map({ (data) -> CashLogsEntityModel in
                return CashLogsEntityModel(data: data)
            })
        }
        return [CashLogsEntityModel]()
    }
    
    func doFinalCalculatorExpectationCash() -> ExpectationCashData{
        if let mData = CommonService.getShareExchangeCash() {
            return mData.expectationCash
        }
        return ExpectationCashData()
    }
    
    func doPreparingData(issuerKpValue : String){
        let mListAvailable = doFinalCalculatorExchangeCash()
        var requestArray = [[String]]()
        for index in mListAvailable {
            let eCash = CashLogsEntityModel(mDataExisting: index)
            let array = [eCash.data ?? "", eCash.accountSignature ?? "", eCash.treasureSignature ?? ""]
            requestArray.append(array)
        }
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey:issuerKpValue, cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
            debugPrint(cashEncResult)
            guard let mWalletId = CommonService.getWalletId() else {
                return
            }
            let time = TimeHelper.getString(time: Date() ,dateFormat: TimeHelper.StandardFormatTime)
            let transfer = TransferDataModel(sender: CipherKey.ECPAY , receiver: mWalletId, time: time, type: EnumTransferType.EXCHANGE_MONEY.rawValue,content: CipherKey.ExchangeCash, cashEnc: cashEncResult)
            
            let mExchangeCash = ExchangeCashRequestModel(transferData: transfer, expectationCash: doFinalCalculatorExpectationCash())
            Utils.logMessage(object: transfer)
            Utils.logMessage(object: mExchangeCash)
            doExchangeCash(savedLocalExchanged : transfer,data: mExchangeCash,requestArray: requestArray)
            //self.showLoading.value = false
        }
    }
    
    //Saved data to local database
    func savedToDB(golbalTransactionId : String,requestArray : [[String]]){
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: CommonService.getPublicKey() ?? "", cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
            debugPrint(cashEncResult)
            guard let mWalletId = CommonService.getWalletId() else {
                return
            }
            let time = TimeHelper.getString(time: Date() ,dateFormat: TimeHelper.StandardFormatTime)
            let transfer = TransferDataModel(sender: mWalletId , receiver: mWalletId , time: time, type: EnumTransferType.EXCHANGE_MONEY.rawValue,content: CipherKey.ExchangeCash, cashEnc: cashEncResult)
            let mGlobalTransaction = TransferDataModel(id: golbalTransactionId, data: transfer)
        CommonService.handCashLogsOutput(mTransferData: mGlobalTransaction) { (mResponseCashLogs) in
            if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue {
                self.showLoading.value = false
                CommonService.bindingData()
                self.getListAvailable()
                debugPrint("Saved out successfully")
            }
        }
        }
    }
    
    func doBindingExchangeCash(){
        if let mData = CommonService.getShareExchangeCash() {
            let mTotalExchangeCash = Int(mData.totalExchangeCash ?? "0") ?? 0
            let mTotalExpectationCash = Int(mData.totalExpectationCash ?? "0") ?? 0
            self.exchangeCashBinding.value = mData.totalExchangeCash?.toMoney() ?? "0".toMoney()
            self.expectationCashBinding.value = mData.totalExpectationCash?.toMoney() ?? "0".toMoney()
            if mTotalExchangeCash > 0 {
                if mTotalExchangeCash == mTotalExpectationCash {
                    matchValueBinding.value = true
                    return
                }
            }
            matchValueBinding.value = false
        }else{
            self.exchangeCashBinding.value = "0".toMoney()
            self.expectationCashBinding.value = "0".toMoney()
            matchValueBinding.value = false
        }
    }
    
    func clearData(){
        CommonService.clearExchangeCashData()
        doBindingExchangeCash()
    }
    
    func isMatchValue() ->Bool {
        return matchValueBinding.value
    }
}
