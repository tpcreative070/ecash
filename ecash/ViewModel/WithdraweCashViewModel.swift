//
//  WithdraweCashViewModel.swift
//  ecash
//
//  Created by phong070 on 9/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct WithdraweCashViewModelKey {
    public static let MONEY = "money"
}

class WithdraweCashViewModel : WithdraweCashDelegate {
    var idNumberBinding: Bindable<String> = Bindable("")
    var totalMoneyDispay: String? = "0"
    var eCashPhoneNumber: Bindable<String> = Bindable("")
    var eDongAvailableAmount: Int? = 0
    var eDongMinBalance: Int? = 0
    var eDongIdTransferSelected : String? = "0"
    var listAvailable : [ListAvailableViewModel]  = [ListAvailableViewModel]()
    var selectedItem : Bindable<Dictionary<Int, Int>> = Bindable(Dictionary<Int,Int>())
    var totalMoneyBinding: Bindable<String>  = Bindable("0")
    var isTypeMoney: Bool? = false
    var totalMoney : String? = "0"
    var eDongIdSelected : String? = "0"
    var fullNameBinding: Bindable<String> = Bindable("TRAN VAN A")
    var eCashIdBinding: Bindable<String> = Bindable("2332451223")
    var eCashBalanceBinding: Bindable<String> = Bindable("1.000.000VND")
    var eDongIdBinding: Bindable<String> = Bindable("21233222")
    var eDongBalanceBinding: Bindable<String> = Bindable("2.000.000")
    var eDongAccountListBinding: Bindable<[String]> = Bindable([])
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())
    
    var responseToView: ((String) -> ())?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    var moneyInput: String? {
        didSet {
            validateMoney()
        }
    }
    
    private let productService: ProductService
    private let userService: UserService
    
    init(productService: ProductService = ProductService(),userService: UserService = UserService() ) {
        self.productService = productService
        self.userService = userService
    }
    
    /**
     Validation for email field
     */
    func validateMoney() {
        if moneyInput == nil || !ValidatorHelper.minLength(moneyInput) {
            errorMessages.value[WithdraweCashViewModelKey.MONEY] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorEmailRequired) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: WithdraweCashViewModelKey.MONEY)
        }
    }
    
    func doGeteDongInfo(){
        if !CommonService.isSigined() {
            return
        }
        showLoading.value = true
        GlobalRequestApiHelper.shared.doGeteDongInfo(completion: { (result) -> () in
            self.showLoading.value = false
            if result.success ?? false{
                guard let mResponse = result.eDongInfoData else{
                    debugPrint("Debug")
                    self.doBindingDataToView()
                    return
                }
                self.doBindingDataToView(data:mResponse)
            }else{
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: result.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
            }
        })
    }
    
    func doGetKeyOrganizeRelease(){
        
        if !CommonService.isSigined() {
            return
        }
        
        if (isTypeMoney ?? false) {
            validateMoney()
        }
        
        if !(isTypeMoney ?? false) {
            let mListAvailable = doFinalCalculator()
            if mListAvailable.count == 0 {
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: LanguageHelper.getTranslationByKey(LanguageKey.SelectMoney),
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                return
            }
        }
        
        guard let mCount = SQLHelper.getTotaleCash() else {
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                message: LanguageHelper.getTranslationByKey(LanguageKey.YoureCashBalanceIsNotEnough),
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
            )
            self.onShowError?(okAlert)
            return
        }
        
        if mCount <= 0{
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                message: LanguageHelper.getTranslationByKey(LanguageKey.YoureCashBalanceIsNotEnough),
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
            )
            self.onShowError?(okAlert)
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
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                        )
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
    
    func doeCashToeDong(requestArray : [[String]],mData : TransferDataModel){
        productService.eCashToeDong(data: eCashToeDongRequestModel(data: mData, amount: Int(totalMoney ?? "0") ?? 0,creditAccount: eDongIdSelected ?? "")) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        self.savedToDB(requestArray: requestArray,time: mData.time ?? "")
                    }else{
                        self.showLoading.value = false
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                        )
                        self.onShowError?(okAlert)
                    }
                }
                break
            case .failure( let error ):
                self.showLoading.value = false
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                break
            }
        }
    }
    
    func doPreparingData(issuerKpValue : String){
        showLoading.value = true
        let mListAvailable = doFinalCalculator()
        var requestArray = [[String]]()
        for index in mListAvailable {
            let eCash = CashLogsEntityModel(mDataExisting: index)
            let array = [eCash.data ?? "", eCash.accountSignature ?? "", eCash.treasureSignature ?? ""]
            requestArray.append(array)
        }
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: issuerKpValue, cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
            debugPrint(cashEncResult)
            guard let mWalletId = CommonService.getWalletId() else {
                return
            }
            let time = TimeHelper.getString(time: Date() ,dateFormat: TimeHelper.FormatSendEnc)
            let transfer = TransferDataModel(sender: mWalletId , receiver: mWalletId, time: time, type: EnumTransferType.ECASH_TO_EDONG.rawValue , cashEnc: cashEncResult)
            //handle
            doeCashToeDong(requestArray :requestArray,mData: transfer)
            Utils.logMessage(object: transfer)
        }
    }
    
    func savedToDB(requestArray : [[String]], time : String){
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: CommonService.getPublicKey() ?? "", cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
            debugPrint(cashEncResult)
            guard let mWalletId = CommonService.getWalletId() else {
                return
            }
            let transfer = TransferDataModel(sender: mWalletId , receiver: mWalletId, time: time, type: EnumTransferType.ECASH_TO_EDONG.rawValue, cashEnc: cashEncResult)
            CommonService.handleTransactionsLogsOutput(transferData: transfer) { (mResponseTransactions) in
                if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                    CommonService.handCashLogsOutput(mTransferData: mResponseTransactions.transferData!) { (mResponseCashLogs) in
                        if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue {
                            self.showLoading.value = false
                            self.doGeteDongInfo()
                            CommonService.bindingData()
                            self.getListAvailable()
                            self.responseToView!(EnumResponseToView.ECASH_TO_EDONG.rawValue)
                        }
                    }
                }
            }
            Utils.logMessage(object: transfer)
        }
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
    
    func doBindingUpdate(){
        //let userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
        let profile = userProfile.value
        fullNameBinding.value = Bindable(UserProfileViewModel()).value.fullNameView ?? ""
        eCashIdBinding.value = profile.eCashIdView ?? ""
        eCashBalanceBinding.value = profile.eCashBalanceView ?? ""
        eDongIdBinding.value = profile.eDongIdView ?? ""
        eDongIdSelected = profile.eDongId
        eDongBalanceBinding.value = profile.eDongBalanceView ?? ""
        eDongAccountListBinding.value = profile.listeDong
        self.eDongAvailableAmount = profile.eDongAvailable ?? 0
        self.eDongMinBalance = profile.eDongMinBalance ?? 0
        doUpdateTotalMoney(value: "0")
    }
    
    func getListAvailable(){
        doUpdateTotalMoney(value: "0")
        guard let mList = SQLHelper.getListAvailable() else{
            self.responseToView!(EnumResponseToView.NO_LIST_AVAILABLE.rawValue)
            return
        }
        Utils.logMessage(object: mList)
        let result = mList.group(by: {$0.value})
        listAvailable.removeAll()
        result.enumerated().forEach { (index, element) in
            debugPrint(result.count)
            listAvailable.append(ListAvailableViewModel(money : element.key?.description ?? "" ,data: element.value))
        }
        listAvailable = listAvailable.sorted {$0.groupId > $1.groupId}
        self.responseToView!(EnumResponseToView.LIST_AVAILABLE.rawValue)
    }
    
    func doCalculator(){
        var totalMoney = Int64(0)
        for index in listAvailable {
            let mCountSelected = index.countSelected
            if mCountSelected > 0{
                for (n, prime) in index.list.enumerated(){
                    if n < mCountSelected {
                        totalMoney += prime.value ?? 0
                    }
                }
            }
        }
        doUpdateTotalMoney(value: totalMoney.description)
    }
    
    func doFinalCalculator() -> [CashLogsEntityModel]{
        var list = [CashLogsEntityModel]()
        var totalMoney = Int64(0)
        for index in listAvailable {
            let mCountSelected = index.countSelected
            if mCountSelected > 0{
                for (n, prime) in index.list.enumerated(){
                    if n < mCountSelected {
                        list.append(prime)
                        totalMoney += prime.value ?? 0
                    }
                }
            }
        }
        self.totalMoneyDispay = totalMoney.description
        doUpdateTotalMoney(value: totalMoney.description)
        return list
    }
    
    func doUpdateTotalMoney(value : String){
        self.totalMoney = value
        self.totalMoneyBinding.value = self.totalMoney?.toMoney() ?? "0".toMoney()
    }
    
}
