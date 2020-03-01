    //
    //  TransfereCashMultipleViewModel.swift
    //  ecash
    //
    //  Created by phong070 on 12/24/19.
    //  Copyright © 2019 thanhphong070. All rights reserved.
    //

    import Foundation
    struct TransfereCashMultipleViewModelKey {
        public static let ECASHID = "eCashId"
        public static let MONEY = "money"
        public static let CONTENT = "content"
    }
    class TransfereCashMultipleViewModelList  : TransfereCashMultipleListDelegate{
        var leftWalletId: Int = 0
        var readyToSubmit: Bindable<Bool> = Bindable(false)
        var listeCash: Dictionary<String, [CashLogsEntityModel]> = [String : [CashLogsEntityModel]]()
        var countContactBinding: Bindable<Int> = Bindable(1)
        var eCashId: String?
        var isQRCode: Bool? = false
        var idNumberBinding: Bindable<String> = Bindable("")
        var totalMoneyDispay: String? = ""
        var eCashPhoneNumber: Bindable<String> = Bindable("")
        var eDongAvailableAmount: Int? = 0
        var eDongMinBalance: Int? = 0
        var isTypeMoney: Bool? = false
        var totalMoney: String? = ""
        var totalMoneyBinding: Bindable<String> = Bindable("0")
        
        var eDongIdSelected: String?
        
        var eDongIdTransferSelected: String?
        
        var listAvailable  = [TransferMultipleViewModel]()
        
        var selectedItem: Bindable<Dictionary<Int, Int>> = Bindable(Dictionary<Int, Int>())
        
        var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
        
        var fullNameBinding: Bindable<String> = Bindable("")
        
        var eCashIdBinding: Bindable<String> = Bindable("")
        
        var eCashBalanceBinding: Bindable<String> = Bindable("")
        
        var eDongIdBinding: Bindable<String> = Bindable("")
        
        var eDongBalanceBinding: Bindable<String> = Bindable("")
        
        var eDongAccountListBinding: Bindable<[String]> = Bindable([])
        
        var eCashIdArray: [String] = [String]()  {
            didSet {
                 validateeCashArray()
            }
        }
      
        var moneyInput: String?{
            didSet {
                validateMoney()
            }
        }
        
        var content: String?{
            didSet{
                validateContent()
            }
        }
        
        var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())
        
        var responseToView: ((String) -> ())?
        
        var showLoading: Bindable<Bool> = Bindable(false)
        
        var onShowError: ((SingleButtonAlert) -> Void)?
        
        
        private let userService : UserService
        init(userService : UserService = UserService()) {
            self.userService = userService
        }
        
        /**
         Validation for eCashId
         */
        func validateeCashArray() {
            if eCashIdArray.count == 0{
                 errorMessages.value[TransfereCashMultipleViewModelKey.ECASHID] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorWalletIdRequired ) ?? ""
            }
            else {
                errorMessages.value.removeValue(forKey: TransfereCashMultipleViewModelKey.ECASHID)
            }
        }
        
        /**
         Validation for money
         */
        func validateMoney() {
            if moneyInput == nil || !ValidatorHelper.minLength(moneyInput) {
                errorMessages.value[TransfereCashMultipleViewModelKey.MONEY] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorEmailRequired) ?? ""
            }
            else {
                errorMessages.value.removeValue(forKey: TransfereCashMultipleViewModelKey.MONEY)
            }
        }
        
        /**
         Validation for content
         */
        func validateContent() {
            if content == nil || !ValidatorHelper.minLength(content) {
                errorMessages.value[TransfereCashMultipleViewModelKey.CONTENT] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorContentRequired) ?? ""
            }
            else {
                errorMessages.value.removeValue(forKey: TransfereCashMultipleViewModelKey.CONTENT)
            }
        }
        
        /*Get public key sender*/
        func doGetPublicKey(){
            validateeCashArray()
            if (isTypeMoney ?? false) {
                validateMoney()
            }
            validateContent()
            if (errorMessages.value.count > 0 ) {
                return
            }
            
            if !CommonService.isSigined() {
                return
            }
            
            if !(isTypeMoney ?? false) {
                let mListAvailable = doFinalCompletedMultiCalculator()
                if mListAvailable.count == 0 {
                    let okAlert = SingleButtonAlert(
                        title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                        message: LanguageHelper.getTranslationByKey(LanguageKey.SelectMoney),
                        action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                    )
                    self.onShowError?(okAlert)
                    return
                }
            }
            
            guard let mCount = SQLHelper.getTotaleCash() else {
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
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
            userService.getWalletInfo(data: WalletInfoRequestModel(walletId: eCashId ?? "")) { result  in
                switch result {
                case .success(let result) :
                    if let response = result{
                        debugPrint("Get public key api=====>")
                        Utils.logMessage(object: response)
                        if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                            let data = response.responseData
                            CommonService.saveItemToContact(contact: ContactsEntityModel(data : response.responseData,walletId: self.eCashId ?? ""))
                            guard let publicKeyReceiver = data.ecKpValue else {
                                let okAlert = SingleButtonAlert(
                                    title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                    message: LanguageHelper.getTranslationByKey(LanguageKey.InvalidData),
                                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                                )
                                self.onShowError?(okAlert)
                                self.showLoading.value = false
                                return
                            }
                            self.doSendeCash(publicKeyReceicer : publicKeyReceiver)
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
        
        
        func doSendeCash(publicKeyReceicer : String){
            let mListAvailable = doFinalCompletedMultiCalculator()
            var requestArray = [[String]]()
            for index in mListAvailable {
                let eCash = CashLogsEntityModel(mDataExisting: index)
                let array = [eCash.data ?? "", eCash.accountSignature ?? "", eCash.treasureSignature ?? ""]
                requestArray.append(array)
            }
            let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: publicKeyReceicer, cashArray: requestArray)
            if cashEnc.count > 0{
                let cashEncResult = cashEnc.joined(separator: "$")
                debugPrint(cashEncResult)
                guard let mWalletId = CommonService.getWalletId() else {
                    return
                }
                
                let time = TimeHelper.getString(time: Date() ,dateFormat: TimeHelper.StandardFormatTime)
                let transfer = TransferDataModel(sender: mWalletId , receiver: eCashId ?? "", time: time, type: EnumTransferType.ECASH_TO_ECASH.rawValue,content: content ?? "", cashEnc: cashEncResult)
                Utils.logMessage(object: transfer)
                
                if isQRCode ?? false{
                    let mData = QRCodeSenderModel(data: transfer)
                    Utils.logMessage(object: mData)
                    if let mSplitData = CommonService.splitFile(msg: JSONSerializerHelper.toJson(mData)){
                        Utils.logMessage(message: "Split...")
                        Utils.logMessage(object: mSplitData)
                        //let mTransactionSignature = mData.id ?? ""
                        //saveFileToDocument(index: 0,transactionSignature : mTransactionSignature, mSplitData: mSplitData,requestArray: requestArray,time: time,receiver: eCashId ?? "")
                        self.savedToDB(requestArray : requestArray,time: time,receiver: eCashId ?? "",splitData: mSplitData)
                    }
                    self.showLoading.value = false
                }else{
                    if Helper.isConnectedToNetwork(){
                        if WebSocketClientHelper.instance.socket.isConnected {
                            WebSocketClientHelper.instance.senderData(transfer: transfer)
                            savedToDB(requestArray : requestArray,time: time,receiver: eCashId ?? "")
                        }else{
                            responseToView!(EnumResponseToView.NO_SOCKET_CONNECTION.rawValue)
                            self.showLoading.value = false
                        }
                    }else{
                        responseToView!(EnumResponseToView.NO_INTERNET_CONNECTION.rawValue)
                        WebSocketClientHelper.instance.connect()
                        self.showLoading.value = false
                    }
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
        
        func savedToDB(requestArray : [[String]],time : String,receiver : String, splitData : [QRCodeModel]? = nil){
            let cashEnc = ELGamalHelper.instance.encryptedPackage(receiverPublicKey: CommonService.getPublicKey() ?? "", cashArray: requestArray)
            if cashEnc.count > 0{
                let cashEncResult = cashEnc.joined(separator: "$")
                debugPrint(cashEncResult)
                guard let mWalletId = CommonService.getWalletId() else {
                    self.showLoading.value = false
                    return
                }
                let transfer = TransferDataModel(sender: mWalletId , receiver:receiver, time: time, type: EnumTransferType.ECASH_TO_ECASH.rawValue,content: content ?? "", cashEnc: cashEncResult)
                CommonService.handleTransactionsLogsOutput(transferData: transfer) { (mResponseTransactions) in
                    if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                        CommonService.handCashLogsOutput(mTransferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogsOut) in
                            if mResponseCashLogsOut.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue {
                                
                                self.leftWalletId = self.leftWalletId + 1
                                if self.listeCash.count == self.leftWalletId {
                                    self.showLoading.value = false
                                    self.doGeteDongInfo()
                                    CommonService.bindingData()
                                    self.getListAvailable()
                                    self.responseToView!(EnumResponseToView.ECASH_TO_ECASH.rawValue)
                                }else{
                                    self.doGetPublicKey()
                                    debugPrint("Call doGetPublicKey again")
                                    //Call again when finished list
                                }
                                if let mSplitData = splitData{
                                    self.saveQRCodeToDB(index: 0, transactionSignature: transfer.id ?? "", mSplitData: mSplitData)
                                }
                            }
                        })
                    }
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
            let userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
            let profile = userProfile.value
            fullNameBinding.value = profile.fullNameView ?? ""
            eCashIdBinding.value = profile.eCashIdView ?? ""
            eCashBalanceBinding.value = profile.eCashBalanceView ?? ""
            eDongIdSelected = profile.eDongId ?? ""
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
            let result = mList.group(by: {$0.value})
            listAvailable.removeAll()
            result.enumerated().forEach { (index, element) in
                debugPrint(result.count)
                listAvailable.append(TransferMultipleViewModel(money : element.key?.description ?? "" ,data: element.value,eCashIdArray: eCashIdArray))
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
        
        func doAlertConnection(value : String){
            let okAlert = SingleButtonAlert(
                title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                message: value,
                action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
            )
            self.onShowError?(okAlert)
        }
        
        
        func isAllowInsert(walletId : String) -> Bool{
            if let mData = CommonService.getWalletId(){
                if walletId != mData{
                    return true
                }
            }
            return false
        }
        
        func doCheckRefresheCashAvailable(eCashArray : [String]){
            self.eCashIdArray = eCashArray
            if self.eCashIdArray.count > 0 {
                getListAvailable()
            }
        }
        
        func doFinalMultiCalculator() {
            let mCountWalletId = eCashIdArray.count
            let mData = doFinalCalculator()
            var mListCashTemp = [Int : [CashLogsEntityModel]]()
            let result = mData.group(by: {$0.value})
            result.enumerated().forEach { (index, element) in
                //debugPrint("Index root value \(element.key ?? 0)")
                //debugPrint("Index root count value \(element.value.count)")
                let mDataValue = element.value
                let mSplitValue = mDataValue.count / mCountWalletId
                if mSplitValue > 0 {
                    //debugPrint("Count split \(mSplitValue)")
                    let mSplitArrayResult = mDataValue.chunked(by: mSplitValue)
                    //debugPrint("Index of array \(mSplitArrayResult.count)")
                    for (index, element) in mSplitArrayResult.enumerated() {
                        //debugPrint("Index sub \(index)")
                        //debugPrint("Index sub value \(element.count)")
                        if let mValueIndex = mListCashTemp[index] {
                           let mMergedArray = mValueIndex + element
                           mListCashTemp[index] = mMergedArray
                        }else{
                           mListCashTemp[index] = element
                        }
                    }
                }
            }
            listeCash.removeAll()
            for (index, element) in mListCashTemp {
                listeCash[eCashIdArray[index]] = element
                debugPrint("Index...")
            }
            self.leftWalletId = 0
            self.responseToView!(EnumResponseToView.READY_TO_SUBMIT.rawValue)
        }
        
        func doFinalCompletedMultiCalculator()-> [CashLogsEntityModel]{
            var mList = [CashLogsEntityModel]()
            let mWalletId = eCashIdArray[leftWalletId]
            if let meCashList = listeCash[mWalletId] {
                mList = meCashList
                self.eCashId = mWalletId
            }
            return mList
        }
        
    }
