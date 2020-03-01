//
//  FilterOptionsViewModel.swift
//  ecash
//
//  Created by phong070 on 11/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransactionFilterViewModel : TransactionFilterViewModelDelegate {
    
    var isTimeOpening: Bool = false
    
    var time: String?
    
    var type: String?
    
    var status: String?

    var listType: Bindable<[String]> = Bindable([String]())
    
    var listStaus: Bindable<[String]> = Bindable([String]())
    
    var hashType: [Int : String] = [Int:String]()
    
    var hashStatus: [Int : String] = [Int:String]()
    
    var responseToView: ((String) -> ())?
    
    var timeBinding: Bindable<String> = Bindable(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardFilterMonthYear))
    
    var typeBinding: Bindable<String> = Bindable(LanguageHelper.getTranslationByKey(LanguageKey.Transfer) ?? "")
    
    var statusBinding: Bindable<String> = Bindable("Success")
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    
    func doInitData(){
        timeBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.ChooseTime) ?? ""
        typeBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.ChooseType) ?? ""
        statusBinding.value = LanguageHelper.getTranslationByKey(LanguageKey.ChooseStatus) ?? ""
        let mTransfer = LanguageHelper.getTranslationByKey(LanguageKey.Transfer) ?? ""
        let mAddeCash = LanguageHelper.getTranslationByKey(LanguageKey.AddeCash) ?? ""
        let mWithdraweCash =  LanguageHelper.getTranslationByKey(LanguageKey.WithdraweCash) ?? ""
        let mExchangeeCash =  LanguageHelper.getTranslationByKey(LanguageKey.ExchangeeCash) ?? ""
        let mLixi =  LanguageHelper.getTranslationByKey(LanguageKey.LuckyMoney) ?? ""
        hashType[0] = EnumTransferType.ECASH_TO_ECASH.rawValue
        hashType[1] = EnumTransferType.EDONG_TO_ECASH.rawValue
        hashType[2] = EnumTransferType.ECASH_TO_EDONG.rawValue
        hashType[3] = EnumTransferType.EXCHANGE_MONEY.rawValue
        hashType[4] = EnumTransferType.LIXI.rawValue
        
        
        let mSuccess = LanguageHelper.getTranslationByKey(LanguageKey.Success) ?? ""
        let mFail = LanguageHelper.getTranslationByKey(LanguageKey.Fail) ?? ""
        hashStatus[0] = "1"
        hashStatus[1] = "0"
        
        var mListType = [String]()
        var mListStatus = [String]()
        mListType.append(mTransfer)
        mListType.append(mAddeCash)
        mListType.append(mWithdraweCash)
        mListType.append(mExchangeeCash)
        mListType.append(mLixi)
        mListStatus.append(mSuccess)
        mListStatus.append(mFail)
        
        listType.value = mListType
        listStaus.value = mListStatus
        self.time = nil
        self.type = nil
        self.status = nil
    }
    
    func doSendData(){
        let filter = FilterData(time: self.time, type: self.type, status: self.status)
        CommonService.sendDataToTransactionLogsHistory(data: filter, isResponse: true)
    }
    
    func getTimeValue(time : Date){
        self.time =  TimeHelper.getString(time: time, dateFormat: TimeHelper.StandardYearMonthQuery)
    }
    
    func doBindingTime(){
        if !isTimeOpening {
            let mTime = Date()
            self.time =  TimeHelper.getString(time: mTime, dateFormat: TimeHelper.StandardYearMonthQuery)
            self.timeBinding.value = TimeHelper.getString(time: mTime, dateFormat: TimeHelper.StandardFilterMonthYear)
            isTimeOpening = true
        }
    }
    
}
