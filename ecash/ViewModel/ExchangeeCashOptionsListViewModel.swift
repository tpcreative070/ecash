//
//  ExchangeeCashOptionsViewModel.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation

struct ExchangeeCashOptionsListViewModelKey {
    public static let M500000 = 500000
    public static let M200000 = 200000
    public static let M100000 = 100000
    public static let M50000  = 50000
    public static let M20000  = 20000
    public static let M10000  = 10000
}

class ExchangeeCashOptionsListViewModel : ExchangeeCashListOptionsDelegate {
    var listExchangeOverview: [ListAvailableViewModel] = [ListAvailableViewModel]()
    var listExpectationOverview: [ExpectationCashViewModel] = [ExpectationCashViewModel]()
    var titleBinding: Bindable<String> = Bindable("")
    var listExpectation: [ExpectationCashViewModel] = [ExpectationCashViewModel]()
    var moneyValue: Bindable<Dictionary<Int, Int>> = Bindable(Dictionary<Int,Int>())
    var isExchangeCash: Bool? = false
    var totalMoneyDispay: String? = ""
    var totalMoneyBinding: Bindable<String> = Bindable("")
    var totalMoney: String? = ""
    var listAvailable: [ListAvailableViewModel] = [ListAvailableViewModel]()
    var onShowError: ((SingleButtonAlert) -> Void)?
    var showLoading: Bindable<Bool> = Bindable(false)
    var responseToView: ((String) -> ())?
    
    func getListAvailable(){
        doUpdateTotalMoney(value: "0")
        guard let mList = SQLHelper.getListAvailable() else{
            self.responseToView!(EnumResponseToView.NO_LIST_AVAILABLE.rawValue)
            return
        }
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
        
        /*Parse data to exchange cash overview*/
        listExchangeOverview.removeAll()
        let result = list.group(by: {$0.value})
        result.enumerated().forEach { (index, element) in
            listExchangeOverview.append(ListAvailableViewModel(money : element.key?.description ?? "" ,data: element.value))
        }

        self.totalMoneyDispay = totalMoney.description
        doUpdateTotalMoney(value: totalMoney.description)
        return list
    }
    
    func doFinalCalulatorExpectationCash() -> ExpectationCashData{
        var mValue  : [Int] = [Int]()
        var mQuantities : [Int] = [Int]()
        listExpectationOverview.removeAll()
        for (value, quantities) in moneyValue.value {
            Utils.logMessage(message: "\(value)")
            if quantities > 0 {
                mValue.append(value)
                mQuantities.append(quantities)
                listExpectationOverview.append(ExpectationCashViewModel(quantities: quantities, value: value))
            }
        }
        return ExpectationCashData(quantities: mQuantities, value: mValue)
    }
    
    func doUpdateTotalMoney(value : String){
        self.totalMoney = value
        self.totalMoneyBinding.value = self.totalMoney?.toMoney() ?? "0".toMoney()
    }
    
    func doCalculatorExpectationCash(){
        var totalMoney = 0
        for index in listExpectation {
            let mCountSelected = index.countSelected
            totalMoney += (mCountSelected * (index.value ?? 0))
            moneyValue.value[index.value ?? 0] = mCountSelected
        }
        self.totalMoneyDispay = totalMoney.description
        doUpdateTotalMoney(value: totalMoney.description)
    }
    
    func getListExpectation(){
        guard let mData = SQLHelper.getDenomination() else {
            listExpectation.append(ExpectationCashViewModel(quantities: 0, value:ExchangeeCashOptionsListViewModelKey.M500000))
            listExpectation.append(ExpectationCashViewModel(quantities: 0, value:ExchangeeCashOptionsListViewModelKey.M200000))
            listExpectation.append(ExpectationCashViewModel(quantities: 0, value:ExchangeeCashOptionsListViewModelKey.M100000))
            listExpectation.append(ExpectationCashViewModel(quantities: 0, value:ExchangeeCashOptionsListViewModelKey.M50000))
            listExpectation.append(ExpectationCashViewModel(quantities: 0, value:ExchangeeCashOptionsListViewModelKey.M20000))
            listExpectation.append(ExpectationCashViewModel(quantities: 0, value:ExchangeeCashOptionsListViewModelKey.M10000))
            self.responseToView!(EnumResponseToView.LIST_AVAILABLE.rawValue)
            return
        }
        listExpectation = mData.map({ (data) -> ExpectationCashViewModel in
            return ExpectationCashViewModel(quantities: 0, value: Int(data.value ?? 0))
        })
        listExpectation = listExpectation.sorted {$0.groupId > $1.groupId}
        self.responseToView!(EnumResponseToView.LIST_AVAILABLE.rawValue)
    }
    
    func sendRequest(isResponse : Bool){
        guard var mData = CommonService.getShareExchangeCash() else {
            CommonService.sendDataToExchangeCash(data: ExchangeeCashData(totalExchangeCash: nil, totalExpectationCash: nil, listExchangeCash: [ExchangeCashModel](), expectationCash: ExpectationCashData(), isExchangeCash : isExchangeCash ?? false), isResponse: isResponse)
            return
        }
        if (isExchangeCash ?? false){
            mData.listExchangeCash = doFinalCalculator().map({ (data) -> ExchangeCashModel in
                return ExchangeCashModel(data: data)
            })
            mData.exchangeCashOverviewOptions = listExchangeOverview
            mData.totalExchangeCash = totalMoney ?? "0"
        }else{
            mData.expectationCash = doFinalCalulatorExpectationCash()
            mData.expectationCashOverviewOptions = listExpectationOverview
            mData.totalExpectationCash = totalMoney ?? "0"
        }
        CommonService.sendDataToExchangeCash(data: mData, isResponse: isResponse)
    }
}
