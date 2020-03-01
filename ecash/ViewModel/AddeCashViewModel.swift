//
//  AddeCashViewModel.swift
//  ecash
//
//  Created by phong070 on 9/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct AddeCashViewModelKey {
    public static let M500000 = 500000
    public static let M200000 = 200000
    public static let M100000 = 100000
    public static let M50000  = 50000
    public static let M20000  = 20000
    public static let M10000  = 10000
}

class AddeCashViewModelList : AddeCashListDelegate {
    var listDenomination: [AddCashViewModel] = [AddCashViewModel]()
    var idNumberBinding: Bindable<String> = Bindable("")
    var eCashPhoneNumber: Bindable<String> = Bindable("")
    var eDongAvailableAmount: Int? = 0
    var eDongMinBalance: Int? = 0
    var responseToView: ((String) -> ())?
    var totalMoney: String?
    var isTransaction: Bool? = false
    var eDongIdSelected: String? = ""
    var fullNameBinding: Bindable<String> = Bindable("TRAN VAN A")
    var eCashIdBinding: Bindable<String> = Bindable("2332451223")
    var eCashBalanceBinding: Bindable<String> = Bindable("1.000.000VND")
    var eDongIdBinding: Bindable<String> = Bindable("21233222")
    var eDongBalanceBinding: Bindable<String> = Bindable("2.000.000")
    var eDongAccountListBinding: Bindable<[String]> = Bindable([])
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    var moneyValue: Bindable<Dictionary<Int, Int>> = Bindable(Dictionary<Int,Int>())
    
   
    var totalMoneyBinding: Bindable<String> = Bindable("0")
    var alertMessage: Bindable<String> = Bindable("")
    var navigate: (() -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    private let productService: ProductService
    var paymentServicesList = [PaymentServicesViewModel]()
    
    init(productService: ProductService = ProductService()) {
        self.productService = productService
    }
    
    func doCalculator(){
        let total = 0
        doUpdateTotalMoney(value: total.description)
        var totalMoney = 0
        for index in listDenomination {
            let mCountSelected = index.countSelected
            totalMoney += (mCountSelected * (index.value ?? 0))
            moneyValue.value[index.value ?? 0] = mCountSelected
        }
        doUpdateTotalMoney(value: totalMoney.description)
    }
    
    func getDenominationList(){
        guard let mData = SQLHelper.getDenomination() else {
            listDenomination.append(AddCashViewModel(quantities: 0, value:AddeCashViewModelKey.M500000))
            listDenomination.append(AddCashViewModel(quantities: 0, value:AddeCashViewModelKey.M200000))
            listDenomination.append(AddCashViewModel(quantities: 0, value:AddeCashViewModelKey.M100000))
            listDenomination.append(AddCashViewModel(quantities: 0, value:AddeCashViewModelKey.M50000))
            listDenomination.append(AddCashViewModel(quantities: 0, value:AddeCashViewModelKey.M20000))
            listDenomination.append(AddCashViewModel(quantities: 0, value:AddeCashViewModelKey.M10000))
            self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
            return
        }
        self.listDenomination = mData.map({ (data) -> AddCashViewModel in
            return AddCashViewModel(quantities: 0, value: Int(data.value ?? 0))
        })
        self.listDenomination = listDenomination.sorted {$0.groupId > $1.groupId}
        self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doeDongToeCash(){
        debugPrint("doeDongToeCash......................")
        var total : Int = 0
        var value = [Int]()
        var quantities = [Int]()
        moneyValue.value.enumerated().forEach { (index, element) in
          if element.value > 0 {
            total += (element.key * element.value)
            value.append(element.key)
            quantities.append(element.value)
          }
        }
     
        if total == 0{
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                message: LanguageHelper.getTranslationByKey(LanguageKey.SelectMoney),
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
            )
            self.onShowError?(okAlert)
            return
        }
        debugPrint("Total...\(total)")
        guard let mDebitAccount = CommonService.geteDongStoreData()  else {
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                message: LanguageHelper.getTranslationByKey(LanguageKey.Error),
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!")
                    self.doGeteDongInfo()
                    CommonService.bindingData()
                })
            )
            self.onShowError?(okAlert)
            return
        }
        

        if mDebitAccount.eDongId?.description != eDongIdBinding.value {
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.NotFoundeDongId) ?? "Error",
                message: "",
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!")
                 
                })
            )
            self.onShowError?(okAlert)
            return
        }
        
    
        if !(((eDongAvailableAmount ?? 0) - total) >= (eDongMinBalance ?? 0)){
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.YoureDongBalanceIsNotEnough) ?? "Error",
                message: "",
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!")
                    
                })
            )
            self.onShowError?(okAlert)
            return
        }
        
        showLoading.value = true
        let data = eDongToeCashRequestModel(amount: total, quantities: quantities, values: value,mDebitAccount:mDebitAccount.eDongId?.description ?? "")
        productService.eDongToeCash(data: data) { result  in
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let transferData = TransferDataModel(data: eDongToeCashOwnerViewModel(data: response.responseData))
                        CommonService.handleTransactionsLogs(transferData: transferData, completion: { (mResponseTransactions) in
                            if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                                CommonService.handCashLogs(transferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogs) in
                                    if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_COMPLETED.rawValue{
                                        self.doGeteDongInfo()
                                        CommonService.bindingData()
                                        self.responseToView!(EnumResponseToView.EDONG_TO_ECASH.rawValue)
                                        self.getDenominationList()
                                        Utils.logMessage(message: "INSERT_CASH_LOGS_COMPLETED")
                                     }
                                })
                            }
                        })
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"),
                            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!")
                            })
                        )
                        self.onShowError?(okAlert)
                    }
                }
                self.showLoading.value = false
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
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: result.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
            }
        })
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
        eDongIdSelected = profile.eDongId ?? ""
        eDongBalanceBinding.value = profile.eDongBalanceView ?? ""
        eDongAccountListBinding.value = profile.listeDong
        self.eDongAvailableAmount = profile.eDongAvailable ?? 0
        self.eDongMinBalance = profile.eDongMinBalance ?? 0
        doUpdateTotalMoney(value: "0")
    }
    
    func doUpdateTotalMoney(value : String){
        self.totalMoney = value
        self.totalMoneyBinding.value = self.totalMoney?.toMoney() ?? "0".toMoney()
    }
}
