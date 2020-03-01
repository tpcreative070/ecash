//
//  InfoTransactionOptionsViewModel.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
class InfoTransactionOptionsViewModel: InfoTransactionOptionsViewModelDelegate {
    
    var grantTotalBinding: Bindable<String> = Bindable("")
    var accountBinding: Bindable<String> = Bindable("")
    var totalAmountBinding: Bindable<String> = Bindable("")
    var contentBinding: Bindable<String> = Bindable("")
    var responseToView: ((String) -> ())?
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    var mListAvailablePayTo: [CashLogsEntityModel] = []
    
    var listItems: [InfoTransactionOptionsViewModelList] = []
    
    var btStatusBinding: Bindable<ButtonStatus> = Bindable(ButtonStatus.ENABLE)
    
    private let userService = UserService()
    private let productService : ProductService = ProductService()
    private let findECashUtil = FindECashUtil()
    private var finalArrayECashPickedFromWallet : [CashLogsEntityModel] = []
    private var finalArrayECashUseToExchange : [CashLogsEntityModel] = []
    private var expectationCash = ExpectationCashData()
    private var isNeedExchange = false
    
    var socketRequestPaytoModel: SocketRequestPaytoModel? {
        didSet {
            accountBinding.value = "\(socketRequestPaytoModel?.fullName ?? "") - \(socketRequestPaytoModel?.sender ?? "")"
            grantTotalBinding.value = socketRequestPaytoModel?.totalAmount.toMoney() ?? ""
            totalAmountBinding.value = socketRequestPaytoModel?.totalAmount.toMoney() ?? ""
            contentBinding.value = socketRequestPaytoModel?.content ?? ""
            getListAvailable()
        }
    }
    
    init() {
        
    }
    
    func getListAvailable(){
        guard let mList = SQLHelper.getListAvailable() else{
            return
        }
        let eCashSorted = mList.sorted {$0.value ?? 0 > $1.value ?? 0}
        var completed:([CashLogsEntityModel], Int64, [CashLogsEntityModel]) -> Void = {(result, remain, remainWalletList) in
            if (remain <= 0) {
                let grouped = result.group(by: {$0.value})
                self.listItems.removeAll()
                grouped.enumerated().forEach { (index, element) in
                    self.listItems.append(InfoTransactionOptionsViewModelList(money : element.key?.description ?? "" ,data: element.value))
                }
                // mListAvailablePayTo will use on comfirm
                self.mListAvailablePayTo = result
            } else {
                self.isNeedExchange = true
                print(" ========> Need To Exchange First <======== " )
                let totalAmountRemainInWallet = remainWalletList.map({($0.value ?? 0)}).reduce(0, { x, y in
                    x + y
                })
                print(" ========> Debug totalAmountRemainInWallet = \(totalAmountRemainInWallet)")
                if(totalAmountRemainInWallet > remain){
                    // This array is pick from remain wallet will use to exchange
                    self.finalArrayECashUseToExchange = []
                    var amountExchange: Int64 = 0
                    let remainSorted = remainWalletList.sorted {$0.value ?? 0 < $1.value ?? 0}
                    for item in remainSorted {
                        amountExchange += item.value ?? 0
                        self.finalArrayECashUseToExchange.append(item)
                        if amountExchange >= remain {
                            break
                        }
                    }
                    let otherExchange = amountExchange - remain
                    // This array is the eCash Pager blank in this transaction
                    let arrayECashNeedExchange = self.findECashUtil.recursiveGetArrayNeedExchange(remainAmount: remain, partialArray: []).array
                    // This array is the eCash Pager remain other
                    let arrayOtherNeedExchange = self.findECashUtil.recursiveGetArrayNeedExchange(remainAmount: otherExchange, partialArray: []).array
                    self.finalArrayECashPickedFromWallet = result
                    // This will use as input for expectation to exchange
                    let arrayExpectationCash = arrayECashNeedExchange + arrayOtherNeedExchange
                    let groupedDenominations = arrayExpectationCash.group(by: {$0.value})
                    groupedDenominations.enumerated().forEach { (index, element) in
                        self.expectationCash.quantities.append(element.value.count)
                        let denomination = Int("\(element.key ?? 0)") ?? 0
                        self.expectationCash.value.append(denomination)
                    }
                    // this Array will use to show on VC's List
                    let arrayFulFill = result + arrayExpectationCash + arrayOtherNeedExchange;
                    let sortedFulFill = arrayFulFill.sorted {$0.value ?? 0 > $1.value ?? 0}
                    var subCompleted:([CashLogsEntityModel], Int64, [CashLogsEntityModel]) -> Void = {(result, remain, remainWalletList) in
                        
                        let groupedFulFill = result.group(by: {$0.value})
                        groupedFulFill.enumerated().forEach { (index, element) in
                            self.listItems.append(InfoTransactionOptionsViewModelList(money : element.key?.description ?? "" ,data: element.value))
                        }
                        self.listItems = self.listItems.sorted {$0.groupId > $1.groupId}
                        self.responseToView?(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
                    }
                    let amount = Int64(self.socketRequestPaytoModel?.totalAmount ?? "0") ?? 0
                    self.findECashUtil.recursiveFindeCashs(walletList: sortedFulFill, partialList: [], amount: amount, completed: &subCompleted)
//                    // this Array will use to show on VC's List
//                    let arrayToShow = result + arrayECashNeedExchange
//                    let grouped = arrayToShow.group(by: {$0.value})
//                    self.listItems.removeAll()
//                    grouped.enumerated().forEach { (index, element) in
//                        self.listItems.append(InfoTransactionOptionsViewModelList(money : element.key?.description ?? "" ,data: element.value))
//                    }
                }
            }
        }
        
        let amount = Int64(self.socketRequestPaytoModel?.totalAmount ?? "0") ?? 0
        findECashUtil.recursiveFindeCashs(walletList: eCashSorted, partialList: [], amount: amount, completed: &completed)
        listItems = listItems.sorted {$0.groupId > $1.groupId}
        self.responseToView?(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func confirmPayToAction(){
        if (isNeedExchange == false) {
            self.doSendeCashToReceiver(receiverECashId: self.socketRequestPaytoModel!.sender, publicKeyReceicer: self.socketRequestPaytoModel!.senderPublicKey, mListAvailable: self.mListAvailablePayTo, content: self.socketRequestPaytoModel!.content, type: EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue)
        } else {
            // Need exchange eCash First
            exchangeDoGetKeyOrganizeRelease()
        }
    }
    
    func doSendeCashToReceiver(
        receiverECashId : String,
        publicKeyReceicer : String,
        mListAvailable : [CashLogsEntityModel],
        content: String,
        type: String
    ){
        var requestArray = [[String]]()
        for index in mListAvailable {
            let eCash = CashLogsEntityModel(mDataExisting: index)
            let array = [eCash.data ?? "", eCash.accountSignature ?? "", eCash.treasureSignature ?? ""]
            requestArray.append(array)
        }
        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: receiverECashId)) { result  in
            switch result {
                case .success(let result) :
                    if let response = result{
                        if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                            let data = response.responseData
                            guard let mWalletId = CommonService.getWalletId() else { return }
                            let publicKeyReceicer = data.ecKpValue ?? ""
                            let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: publicKeyReceicer, cashArray: requestArray)
                            let cashEncResult = cashEnc.joined(separator: "$")
                            if cashEnc.count > 0{
                                let time = TimeHelper.getString(time: Date() ,dateFormat: TimeHelper.StandardFormatTime)
                                let transfer = TransferDataModel(sender: mWalletId , receiver: receiverECashId, time: time, type: type,content: content, cashEnc: cashEncResult)
                                if Helper.isConnectedToNetwork(){
                                    if WebSocketClientHelper.instance.socket.isConnected {
                                        WebSocketClientHelper.instance.senderData(transfer: transfer)
                                        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
                                            if (isVerifiedTransaction) {
                                                self.savedToDB(requestArray : requestArray, time: time, receiver: self.socketRequestPaytoModel!.sender, content: content)
                                            }
                                        }
                                    } else {
                                        self.responseToView!(EnumResponseToView.NO_SOCKET_CONNECTION.rawValue)
                                        self.showLoading.value = false
                                    }
                                }else{
                                    self.responseToView!(EnumResponseToView.NO_INTERNET_CONNECTION.rawValue)
                                    WebSocketClientHelper.instance.connect()
                                    self.showLoading.value = false
                                }
                            }
                        }
                    }
                    break
                case .failure( let error ):
                    dump(error)
                    break
            }
        }
    }
    
    
    
    func saveQRCodeToDB(index : Int, transactionSignature : String, mSplitData : [QRCodeModel]){
        CommonService.savedTransactionQRToDB(index: index, data:  mSplitData[index], transactionSignature: transactionSignature) { (value) in
            if value == mSplitData.count{
                Utils.logMessage(message: "Saved QR transaction to db successfully")
            }else{
                self.saveQRCodeToDB(index: value, transactionSignature: transactionSignature, mSplitData: mSplitData)
            }
        }
    }
    
    func savedToDB(requestArray : [[String]],time : String, receiver : String, splitData : [QRCodeModel]? = nil, content: String){
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: CommonService.getPublicKey() ?? "", cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
            guard let mWalletId = CommonService.getWalletId() else {
                self.showLoading.value = false
                return
            }
            let transfer = TransferDataModel(sender: mWalletId , receiver: receiver, time: time, type: EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue,content: content, cashEnc: cashEncResult)
            CommonService.handleTransactionsLogsOutput(transferData: transfer) { (mResponseTransactions) in
                let obj = EventBusObjectData(data: EnumPassdata.PayToToPayStatusPaidSuccessful.rawValue, type: DataKeyType.StringOriginal, identify: EnumViewControllerNameIdentifier.GlobalUpdateEvent)
                print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Call Event Bus Success =-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
                CommonService.eventPushActionToObjectView(obj: obj)
                self.responseToView!(EnumResponseToView.PayToAndToPaySuccessfully.rawValue)
                if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                    CommonService.handCashLogsOutput(mTransferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogsOut) in
                        if mResponseCashLogsOut.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue {
                            if let mSplitData = splitData{
                                self.saveQRCodeToDB(index: 0, transactionSignature: transfer.id ?? "", mSplitData: mSplitData)
                            }
                        }
                    })
                }
            }
        }
    }

    func exchangeDoGetKeyOrganizeRelease(){
        if !CommonService.isSigined() {
            return
        }
        showLoading.value = true
        userService.getPublicKeyOrganizeRelease(data : PublicKeyOrganizeReleaseRequestModel()) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let organizeRelease = PublicKeyOrganizeReleaseViewModel(data: response.responseData)
                        self.exchangeDoPreparingData(issuerKpValue: organizeRelease.issuerKpValue ?? "")
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                            message: response.responseMessage,
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

    
    func exchangeDoPreparingData(issuerKpValue : String){
        let mListAvailable = self.finalArrayECashUseToExchange
        var requestArray = [[String]]()
        for index in mListAvailable {
            let eCash = CashLogsEntityModel(mDataExisting: index)
            let array = [eCash.data ?? "", eCash.accountSignature ?? "", eCash.treasureSignature ?? ""]
            requestArray.append(array)
        }
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey:issuerKpValue, cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
            guard let mWalletId = CommonService.getWalletId() else {
                return
            }
            let time = TimeHelper.getString(time: Date() ,dateFormat: TimeHelper.StandardFormatTime)
            let transfer = TransferDataModel(sender: CipherKey.ECPAY , receiver: mWalletId, time: time, type: EnumTransferType.EXCHANGE_MONEY.rawValue,content: CipherKey.ExchangeCash, cashEnc: cashEncResult)
            let mExchangeCash = ExchangeCashRequestModel(transferData: transfer, expectationCash: self.expectationCash)
            exchangeDoExchangeCash(savedLocalExchanged : transfer,data: mExchangeCash,requestArray: requestArray)
        }
    }
    
    func exchangeDoExchangeCash(savedLocalExchanged : TransferDataModel, data : ExchangeCashRequestModel , requestArray : [[String]]){
        showLoading.value = true
        productService.exchangeCash(data: data) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
//                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let transferData = TransferDataModel(data: ExchangeeCashViewModel(data: response.responseData))
                        CommonService.handleTransactionsLogs(transferData: transferData, completion: { (mResponseTransactions) in
                            if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                                CommonService.handCashLogs(transferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogs) in
                                    if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_COMPLETED.rawValue{
                                        CommonService.bindingData()
//                                        self.getListAvailable()
                                        self.responseToView!(EnumResponseToView.EXCHANGE_CASH.rawValue)
                                        debugPrint("Saved in successfully")
                                    }
                                })
                            }
                        })
                        self.exchangeSavedToDB(golbalTransactionId: transferData.id ?? "", requestArray: requestArray)
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: response.responseMessage,
                            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                        )
                        self.onShowError?(okAlert)
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
    
    func exchangeSendRequest(isExchangeCash : Bool,isResponse : Bool){
        guard var mData = CommonService.getShareExchangeCash() else {
            let exchangeData = ExchangeeCashData(totalExchangeCash: nil, totalExpectationCash: nil, listExchangeCash: [ExchangeCashModel](), expectationCash: ExpectationCashData(), isExchangeCash : isExchangeCash)
            CommonService.sendDataToExchangeCash(data: exchangeData, isResponse: isResponse)
            return
        }
        mData.isExchangeCash = isExchangeCash
        CommonService.sendDataToExchangeCash(data: mData, isResponse: isResponse)
    }
    
    func exchangeDoFinalCalculatorExchangeCash() ->  [CashLogsEntityModel]{
        if let mData = CommonService.getShareExchangeCash() {
            return mData.listExchangeCash.map({ (data) -> CashLogsEntityModel in
                return CashLogsEntityModel(data: data)
            })
        }
        return [CashLogsEntityModel]()
    }
    
    func exchangeDoFinalCalculatorExpectationCash() -> ExpectationCashData{
        if let mData = CommonService.getShareExchangeCash() {
            return mData.expectationCash
        }
        return ExpectationCashData()
    }
    
    
    //Saved data to local database
    func exchangeSavedToDB(golbalTransactionId : String,requestArray : [[String]]){
        let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: CommonService.getPublicKey() ?? "", cashArray: requestArray)
        if cashEnc.count > 0{
            let cashEncResult = cashEnc.joined(separator: "$")
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
                print("----------------------------------------> Start Paid")
                guard let endList = SQLHelper.getListAvailable() else{
                    return
                }
                let endECashSorted = endList.sorted {$0.value ?? 0 > $1.value ?? 0}
                var endCompleted:([CashLogsEntityModel], Int64, [CashLogsEntityModel]) -> Void = {(endResult, endRemain, endRemainWalletList) in
                        if (endRemain <= 0) {
                            self.mListAvailablePayTo = endResult
                            self.doSendeCashToReceiver(receiverECashId: self.socketRequestPaytoModel!.sender, publicKeyReceicer: self.socketRequestPaytoModel!.senderPublicKey, mListAvailable: self.mListAvailablePayTo, content: self.socketRequestPaytoModel!.content, type: EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue)
                        }
                }


                let endAmount = Int64(self.socketRequestPaytoModel?.totalAmount ?? "0") ?? 0
                self.findECashUtil.recursiveFindeCashs(walletList: endECashSorted, partialList: [], amount: endAmount, completed: &endCompleted)
            }
        }
        }
    }
    
    func doAlertConnection(value : String){
        let okAlert = SingleButtonAlert(
            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
            message: value,
            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
        )
        self.onShowError?(okAlert)
    }
}
