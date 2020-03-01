//
//  ExchangeeCashOverviewOptionsViewModelList.swift
//  ecash
//
//  Created by phong070 on 11/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExchangeeCashOverviewOptionsViewModelList  : ExchangeeCashOverviewOptionsViewModelListDeletegate{
    var exchangeCashBinding: Bindable<String> = Bindable("")
    var expectationCashBinding: Bindable<String> = Bindable("")
    var responseToView: ((String) -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var exchangeList: [ListAvailableViewModel] = [ListAvailableViewModel]()
    var expectationList: [ExpectationCashViewModel] = [ExpectationCashViewModel]()
    
    func getIntentData(){
        if let mData = CommonService.getShareExchangeCash(){
            self.exchangeList = mData.exchangeCashOverviewOptions
            self.expectationList = mData.expectationCashOverviewOptions
          
            self.exchangeList = self.exchangeList.sorted {$0.groupId > $1.groupId}
            self.expectationList = self.expectationList.sorted {$0.groupId > $1.groupId}
            
            self.exchangeCashBinding.value = mData.totalExchangeCash?.toMoney() ?? "0".toMoney()
            self.expectationCashBinding.value = mData.totalExpectationCash?.toMoney() ?? "0".toMoney()
            responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
        }
    }
}
