//
//  PassDataViewModel.swift
//  ecash
//
//  Created by phong070 on 9/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class PassDataViewModel : Codable {
    var identifier : String = EnumPassdata.NONE.rawValue
    var alert : AlertData
    var signUp : SignUpResponse
    var navigation : NavigationData
    var eDongToeCash : eDongToeCashPassData
    var eCashToeDong : eCashToeDongPassData
    var eCashtoeCash : eCashToeCashPassData
    var receiveQRCodeData : ReceiveQRCodeData
    var exchangeeCash : ExchangeeCashData
    var contact  : ContactsEntityModel
    var filter : FilterData
    var transactionLogs : TransactionLogsData
    var destroyWalletOptions : DestroyWalletOptionsData
    var otpShareData : OTPShareData
    var forgotPasswordCompleted : ForgotPasswordShareData
    var galleryOptions : GalleryOptionsData
    var receiveLixiOptions : ReceiveLixiOptionsData
    init(identifier : EnumPassdata, alert : AlertData) {
        self.identifier = identifier.rawValue
        self.alert = alert
        self.signUp = SignUpResponse()
        self.navigation = NavigationData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata, response : SignUpResponse) {
        self.identifier = identifier.rawValue
        self.signUp = response
        self.alert = AlertData()
        self.navigation = NavigationData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata, navigation : NavigationData) {
        self.identifier = identifier.rawValue
        self.navigation = navigation
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , eDongToeCash : eDongToeCashPassData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.eDongToeCash = eDongToeCash
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , eCashToeDong : eCashToeDongPassData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.eCashToeDong = eCashToeDong
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , eCashToeCash : eCashToeCashPassData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.eCashtoeCash = eCashToeCash
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , receiveQRCodeData : ReceiveQRCodeData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.receiveQRCodeData = receiveQRCodeData
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , exchangeeCash : ExchangeeCashData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.contact = ContactsEntityModel()
        self.exchangeeCash = exchangeeCash
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , contact : ContactsEntityModel) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = contact
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , filter : FilterData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = filter
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , transactionLogs : TransactionLogsData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = transactionLogs
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
   
    init(identifier : EnumPassdata , destroyWalletOptions : DestroyWalletOptionsData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = destroyWalletOptions
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , otpShareData : OTPShareData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = otpShareData
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , forgotPassword : ForgotPasswordShareData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = forgotPassword
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , galleryOptions : GalleryOptionsData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = galleryOptions
        self.receiveLixiOptions = ReceiveLixiOptionsData()
    }
    
    init(identifier : EnumPassdata , receiveLixiOptions : ReceiveLixiOptionsData) {
        self.identifier = identifier.rawValue
        self.navigation = NavigationData()
        self.signUp = SignUpResponse()
        self.alert = AlertData()
        self.eDongToeCash = eDongToeCashPassData()
        self.eCashToeDong = eCashToeDongPassData()
        self.eCashtoeCash = eCashToeCashPassData()
        self.receiveQRCodeData = ReceiveQRCodeData()
        self.exchangeeCash = ExchangeeCashData()
        self.contact = ContactsEntityModel()
        self.filter = FilterData()
        self.transactionLogs = TransactionLogsData()
        self.destroyWalletOptions = DestroyWalletOptionsData()
        self.otpShareData = OTPShareData()
        self.forgotPasswordCompleted = ForgotPasswordShareData()
        self.galleryOptions = GalleryOptionsData()
        self.receiveLixiOptions = receiveLixiOptions
    }
    
}

struct AlertData : Codable {
    var codeAction : String?
    var name : String?
    var nameValue : String?
    var message : String?
}

struct NavigationData  : Codable{
    var codeAction : String?
}

struct SignUpResponse : Codable{
    var navigation : String?
}

struct eDongToeCashPassData : Codable  {
    var total : String?
}

struct eCashToeDongPassData : Codable {
    var total : String?
    var eDong : String?
}

struct eCashToeCashPassData : Codable {
    var total : String?
    var eCash : String?
    var ecashArray : [String]?
}

struct ReceiveQRCodeData  : Codable {
    var transactionsId : String?
}

struct ExchangeeCashData : Codable {
    var totalExchangeCash : String?
    var totalExpectationCash : String?
    var listExchangeCash : [ExchangeCashModel] = [ExchangeCashModel]()
    var expectationCash : ExpectationCashData = ExpectationCashData()
    var exchangeCashOverviewOptions : [ListAvailableViewModel] = [ListAvailableViewModel]()
    var expectationCashOverviewOptions : [ExpectationCashViewModel] = [ExpectationCashViewModel]()
    var isExchangeCash : Bool?
}

struct ExpectationCashData : Codable {
    var quantities : [Int] = [Int]()
    var value : [Int] = [Int]()
}

struct FilterData : Codable {
    var time : String?
    var type : String?
    var status : String?
}

struct TransactionLogsData : Codable {
    var receiverId : String?
    var senderId : String?
    var transactionType : String?
    var transactionStatus : String?
    var transactionAmount : String?
    var transactionDate : String?
    var transactionDateTime : String?
    var transactionId : String?
    var receiverName : String?
    var senderName : String?
    var receiverPhone : String?
    var senderPhone : String?
    var transactionIcon : String?
    
    var isNameOrPhoneSender : Bool{
        if senderName == "" || senderPhone == "" {
            return false
        }
        return true
    }
    
    
    var isNameOrPhoneReceiver : Bool{
        if receiverName == "" || receiverPhone == "" {
            return false
        }
        return true
    }
    
    
    init() {
    }
    
    init(data : TransactionsLogsViewModel) {
        self.receiverName = data.receiverName
        self.senderName = data.senderName
        self.receiverPhone = data.receiverPhone
        self.senderPhone = data.senderPhone
        self.receiverId = data.receiverId
        self.senderId = data.senderId
        self.transactionType = data.transactionType
        self.transactionStatus = data.transactionStatus
        self.transactionAmount = data.transactionAmount
        self.transactionDate = data.transactionDate
        self.transactionDateTime = data.transactionDateTime
        self.transactionId = data.transactionId
        self.transactionIcon = data.transactionIcon
    }
    
    init(data : TransactionLogsData) {
        self.receiverName = data.receiverName
        self.senderName = data.senderName
        self.receiverPhone = data.receiverPhone
        self.senderPhone = data.senderPhone
        self.receiverId = data.receiverId
        self.senderId = data.senderId
        self.transactionType = data.transactionType
        self.transactionStatus = data.transactionStatus
        self.transactionAmount = data.transactionAmount
        self.transactionDate = data.transactionDate
        self.transactionDateTime = data.transactionDateTime
        self.transactionId = data.transactionId
        self.transactionIcon = data.transactionIcon
    }
    
}

struct DestroyWalletOptionsData : Codable {
    var balance : String?
}

struct OTPShareData : Codable {
    var userId : String?
    var transactionCode : String?
    var userName : String?
}

struct ForgotPasswordShareData : Codable {
    var title  : String?
}

struct GalleryOptionsData : Codable {
    var isAvatar : Bool?
    var bIconLarge : String?
    var bIconMedium : String?
    var bIconSmall : String?
    
    init(data : UIImage) {
        let mLarge =  data.resizeImage(targetSize: CGSize(width: AppConstants.LARGE_SIZE, height: AppConstants.LARGE_SIZE))
        self.bIconLarge = mLarge.doConvertImageToBase64String()
    }
    
    init(isAvatar : Bool) {
        self.isAvatar = isAvatar
    }
    
    init() {
        
    }
}

struct ReceiveLixiOptionsData  : Codable {
    var id : String?
    var noted : String?
    var templateCode : String?
}
