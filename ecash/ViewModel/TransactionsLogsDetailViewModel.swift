//
//  TransactionsLogsDetailViewModel.swift
//  ecash
//
//  Created by phong070 on 11/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import Foundation
class TransactionsLogsDetailViewModel : Codable ,TransactionLogsDetailViewModelDelegate {
    
    
    var transactionIconView: String{
        return transactionIcon ?? "+"
    }
    
    var typeView: String {
        let mTransfer = LanguageHelper.getTranslationByKey(LanguageKey.Transfer) ?? ""
        let mAddeCash = LanguageHelper.getTranslationByKey(LanguageKey.AddeCash) ?? ""
        let mWithdraweCash =  LanguageHelper.getTranslationByKey(LanguageKey.WithdraweCash) ?? ""
        let mExchangeeCash =  LanguageHelper.getTranslationByKey(LanguageKey.ExchangeeCash) ?? ""
        let mLixi =  LanguageHelper.getTranslationByKey(LanguageKey.LuckyMoney) ?? ""
        let mPayment =  LanguageHelper.getTranslationByKey(LanguageKey.Payment) ?? ""
        
        if type == EnumTransferType.ECASH_TO_ECASH.rawValue {
            return mTransfer
        }else if type == EnumTransferType.EDONG_TO_ECASH.rawValue {
            return mAddeCash
        }else if type == EnumTransferType.ECASH_TO_EDONG.rawValue {
            return mWithdraweCash
        }
        else if type == EnumTransferType.LIXI.rawValue {
            return mLixi
        }
        else if type == EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue {
            return mPayment
        }
        else{
            return mExchangeeCash
        }
    }
    
    var moneyView: String {
        return "\(transactionIconView) \(money?.toMoney() ?? "0")"
    }
    
    var statusView: String {
        if status == "1" {
            return LanguageHelper.getTranslationByKey(LanguageKey.Success) ?? ""
        }else{
            return LanguageHelper.getTranslationByKey(LanguageKey.Fail) ?? ""
        }
    }
    
    var receiverView: String {
        return receiver ?? ""
    }
    
    var fullNameView: String {
        return "\(firstName ?? "") \(middleName ?? "") \(lastName ?? "")"
    }
    
    var phoneNumberView: String {
        return phoneNumber ?? ""
    }
    
    var issuerView: String {
        return issuer ?? "ECPAY"
    }
    
    var contentView: String {
        return content ?? ""
    }
    
    var createdDateView: String {
        return TimeHelper.getString(time : TimeHelper.getTime(timeString: createdDate ?? "0", dateFormat: TimeHelper.StandardFormatTime) ?? Date() , dateFormat: TimeHelper.StandardTransaction)
    }
    
    var cashList: [CashListTransactionsLogsDetailViewModel] = [CashListTransactionsLogsDetailViewModel]()
    
    var firstName : String?
    var middleName : String?
    var lastName : String?
    var type : String?
    var money : String?
    var status : String?
    var receiver : String?
    var phoneNumber : String?
    var issuer : String?
    var content : String?
    var createdDate : String?
    var transactionIcon : String?
    var qrCodeList : [String] = [String]()
    var qrCode   = [TransactionQREntityModel()]
    
    init(transactionData : TransactionLogsData , isSender : Bool, transactionType : String) {
        if isSender {
            self.phoneNumber = transactionData.senderPhone
            let mData = transactionData.senderName?.toSeparatedName()
            self.firstName = mData?.firstName
            self.middleName = mData?.middleName
            self.lastName = mData?.lastName
            self.receiver = transactionData.senderId
        }else{
            self.phoneNumber = transactionData.receiverPhone
            let mData = transactionData.receiverName?.toSeparatedName()
            self.firstName = mData?.firstName
            self.middleName = mData?.middleName
            self.lastName = mData?.lastName
            self.receiver = transactionData.receiverId
        }
        
        self.type = transactionData.transactionType
        self.status = transactionData.transactionStatus
        self.createdDate = transactionData.transactionDateTime
        self.transactionIcon = transactionData.transactionIcon
        
        let transactionsId = transactionData.transactionId ?? ""
        
        var isExchanged :  Bool?
        if transactionType == EnumTransferType.EXCHANGE_MONEY.rawValue {
            isExchanged = true
        }
        if let mList = SQLHelper.getListCashLogs(transactionsId: transactionsId,isExchanged: isExchanged){
            let result = mList.group(by: {$0.value})
            var mMoney = 0
            result.enumerated().forEach { (index, element) in
                let mResult = (Int(element.key ?? 0) * element.value.count)
                mMoney += mResult
                cashList.append(CashListTransactionsLogsDetailViewModel(status: true, money: element.key?.description ?? "" , data: element.value))
                debugPrint(mMoney)
            }
            
            self.money = mMoney.description
        }
        
        if let mList = SQLHelper.getListCashInvaidLogs(transactionsId: transactionsId){
            let result = mList.group(by: {$0.value})
            result.enumerated().forEach { (index, element) in
                cashList.append(CashListTransactionsLogsDetailViewModel(status: false, money: element.key?.description ?? "" , data: element.value))
            }
        }
        
        cashList = cashList.sorted{$0.groupId > $1.groupId}
        
        if let mData = SQLHelper.geteTransactionsLogs(key: transactionsId){
            self.content = mData.content
        }
        
        if let mQRCode = SQLHelper.getTransactionQRList(key: transactionsId){
            self.qrCode = mQRCode
            qrCodeList = mQRCode.map({ (value) -> String in
                return String(value.value ?? "")
            })
            debugPrint(qrCodeList)
        }
    }
}


class CashListTransactionsLogsDetailViewModel : CashListTransactionsLogsDetailViewModelDelegate, Codable{

    var moneyView: String {
        return money?.toMoney() ?? "0".toMoney()
    }
    
    var countView: String{
        return count?.description ?? ""
    }
    
    var imageNameView: String {
        return imageName ?? ""
    }
    
    var groupId : Int {
        return money?.toInt() ?? 0
    }
    
    var money : String?
    var count : Int?
    var imageName : String?
    
    init(status : Bool ,money : String,data : [CashLogsEntityModel]) {
        self.money = money
        self.count = data.count
        if status {
            self.imageName = AppImages.IC_CHECK_SUCCESS
        }else{
            self.imageName = AppImages.IC_CHECK_FAIL
        }
    }
}
