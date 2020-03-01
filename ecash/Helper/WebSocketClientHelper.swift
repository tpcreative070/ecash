//
//  WebSocketClientHelper.swift
//  ecash
//
//  Created by phong070 on 8/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Starscream

class WebSocketClientHelper {
    var socket = WebSocket(url: URL(string: CommonService.websocketURLString())!)
    static let instance = WebSocketClientHelper()
    private let userService: UserService
    
    var isSocket = false
    
    private init(userService: UserService = UserService()){
         self.userService = userService
    }
    
    func connect(){
        socket =  WebSocket(url: URL(string: CommonService.websocketURLString())!)
        guard let  data = CommonService.getSignInData() else {
            debugPrint("Please sign in first")
            return
        }
        if data.username == nil || data.username == "" {
            debugPrint("Please sign in first")
            return
        }
        
        Utils.logMessage(message: CommonService.websocketURLString())
        socket.onConnect = {
            debugPrint("websocket is connected")
        }
        
        //websocketDidDisconnect
        socket.onDisconnect = { (error: Error?) in
            //let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            if let mSignUpData = CommonService.getSignUpStoreData() {
                if let _ = mSignUpData.username{
                    //appDelegate?.onDoAlert(value: String(describing: error))
                    WebSocketClientHelper.instance.connect()
                }
            }
            debugPrint("websocket is disconnected: \(String(describing: error))")
            self.isSocket = false
        }
        
        //websocketDidReceiveMessage
        socket.onText = { (text: String) in
            print("=================================== Socket onText =====================================")
            dump(text)
            print("===================================      End      =====================================")
            DispatchQueue.main.async {
                self.isSocket = true
                if let mData = text.toObject(value: TransferTypeModel.self){
//                    print("=================================== Socket mData =====================================")
//                    dump(mData)
//                    print("==== mData.type: \(String(describing: mData.type))")
//                    print("=============      End      =============")
                    if (mData.type == EnumTransferType.ECASH_TO_ECASH.rawValue || mData.type == EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue) {
//                         print("==== PAY_TO_TO_PAY_PAID ====")
//                         self.receiverData(data: text)
                        print("^^^^^^^^^^^^^^^^^^^^^^^^^^ PAY_TO_TO_PAY_PAID Success ^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
                        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
                            if (isVerifiedTransaction) {
                                self.receiverData(data: text)
                            }
                        }
                    }
                    else if mData.type == EnumTransferType.RECEIVE_SYNC_CONTACT.rawValue {
                        if let mResponse = text.toObject(value: TransferDataSyncContactModel.self){
                            self.stoppingReceiveSocket(value: TransferDataModel(data: mResponse))
                            if let mListContact = mResponse.contacts {
                                if let mHashContact = ContactHelper.instance.getPhoneMapByFullName(){
                                   let contactResponse =  CommonService.getContactList(data: mListContact)
                                    if contactResponse.count > 0{
                                        self.saveItemToContact(index: 0, data:contactResponse, contact: mHashContact)
                                    }
                                }
                            }
                        }
                    }
                    else if mData.type == EnumTransferType.DESTROY_WALLET.rawValue {
                        if let mResponse = text.toObject(value: DestroyContactModel.self){
                            self.stoppingReceiveSocket(value: TransferDataModel(data: mResponse))
                            if let mId = mResponse.sender {
                                 SQLHelper.deleteContacts(id: Int64(mId))
                            }
                        }
                    }
                    else if mData.type == EnumTransferType.LIXI.rawValue {
//                         self.receiverData(data: text)
                        print("^^^^^^^^^^^^^^^^^^^^^^^^^^ LIXI Success ^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
                        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
                            if (isVerifiedTransaction) {
                                self.receiverData(data: text)
                            }
                        }
                    }
                    else if mData.type == EnumTransferType.PAY_TO_TO_PAY_REQUEST_PAYMENT.rawValue {
                        if let mResponse = text.toObject(value: SocketRequestPaytoModel.self){
//                            print("------------On Text mResponse------------")
//                            dump(mResponse)
//                            print("------------mResponse End------------")
                            guard let mWalletId = CommonService.getWalletId() else { return }
                            let userService = UserService()
                            userService.getWalletInfo(data: WalletInfoRequestModel(walletId: mWalletId)) { result in
                                switch result {
                                    case .success(let result) :
                                        if let response = result{
                                            if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                                                self.stoppingReceiveSocket(value: TransferDataModel(data: mResponse))
                                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "eventPayToRequest"), object: self, userInfo: ["obj": mResponse])
                                            }
                                        }
                                        break
                                    case .failure( let error ):
                                        dump(error)
                                        break
                                }
                            }
                        }
                    }
                } else {
                    debugPrint("JSON Cannot parse")
                }
            }
            debugPrint("got some text:...\(text)")
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            debugPrint("got some data: \(data.count)")
            let result = String(data: data, encoding: .utf32)
            //let decryptData =  ELGamalHelper.instance.decryptedPackage(encData: data.toArray(type: String.self))
            debugPrint(result ?? "")
        }
        socket.connect()
    }
    
    /**
     Sender data
     */
    func senderData(transfer : TransferDataModel){
        let value = JSONSerializerHelper.toJson(transfer)
        Utils.logMessage(message: "Socklet sending...")
        WebSocketClientHelper.instance.socket.write(string: value)
    }
    
    /**
     Receiver data - Step 1
     */
    func receiverData(data : String){
        guard  let result = data.toObject(value: TransferDataModel.self) else {
//            print("=-=-=-=-=-=-=-=-=-=-=-=-< Error Nil Data >=-=-=-=-=-=-=-=-=-=-=-=-=-=")
             Utils.logMessage(message: "Nil data")
            return
        }
        let transactionsId = result.id ?? ""
        debugPrint("Wallet id sender \(result.sender ?? "")")
        
//        // This "if" will change the type "TT" to "CT"
//        if(result.type == EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue ){
//            result.type = EnumTransferType.ECASH_TO_ECASH.rawValue
//        }
        
        GlobalRequestApiHelper.shared.doGetPublicKey(transferData: result) { (mResponsePublicKey) in
            if mResponsePublicKey.handleAction == EnumTransactionsAction.WALLET_PUBLIC_KEY_SUCCESS.rawValue {
                debugPrint("data  \(result.dataeCashToeCash())")
                debugPrint("Starting \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................verify")
                let verify = ELGamalHelper.instance.verifyData(signature: result.id ?? "", data: result.dataeCashToeCash() , publicKeySender: mResponsePublicKey.publicKeySender ?? "")
                debugPrint("Ending  \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................veriy")
                //let verify = true
                debugPrint("Public key sender... \(mResponsePublicKey.publicKeySender ?? "")")
                Utils.logMessage(message: "Data \(verify.description)")
//                print("=-=-=-=-=-=-=-=-=-=-=-=-< verify = \(verify) >=-=-=-=-=-=-=-=-=-=-=-=-=-=")
                if verify {
                    //Verify lixi
                    if result.type == EnumTransferType.LIXI.rawValue {
                        let mCashTemp = CashTempEntityModel(data: result)
                        SQLHelper.insertedCashTemp(data: mCashTemp)
                        self.stoppingReceiveSocket(value: TransferDataModel(data: mCashTemp))
                        CommonService.eventPushActionToView(data: EnumResponseToView.UPDATE_HOME_TO_LIXI)
                        debugPrint("This is lixi")
                    }else{
                        self.handleTransactionsLogs(transferData: result) { (mResponseTrasactions) ->() in
                            if mResponseTrasactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue{
                                self.handCashLogsTemporary(mTransferData: mResponseTrasactions.transferData!, completion: { (mResponseTemporary) in
                                if mResponseTemporary.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_TEMPORARY_SUCCESS.rawValue{
                                    self.handCallBackLoop(transactionsId: transactionsId)
                                }
                                })
                            }else if mResponseTrasactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_FAILED.rawValue {
                                self.handCashLogsTemporary(mTransferData: mResponseTrasactions.transferData!, completion: { (mResponseTemporary) in
                                    if mResponseTemporary.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_TEMPORARY_SUCCESS.rawValue{
                                        self.handCallBackLoop(transactionsId: transactionsId)
                                    }
                                })
                            }
                        }
                    }
                }else{
                    debugPrint("Message \(mResponsePublicKey.message ?? "")")
                }
            }
        }
    }
    
    func handCallBackLoop(transactionsId : String){
        self.doeCashRelease(completion: { (mResponseCashRelease)  ->() in
            if mResponseCashRelease.handleAction == EnumTransactionsAction.CASH_RELEASE_SUCCESS.rawValue {
                self.doVerifyKey(mCash: mResponseCashRelease.cashLogs!, mDecicitionsDiary: mResponseCashRelease.decisionsDiary!, completion: { (mResponseVerifyKey) ->() in
                    if mResponseVerifyKey.handleAction == EnumTransactionsAction.VERIFY_KEY_SUCCESS.rawValue{
                        
                        self.handleCashLogs(transaction: mResponseVerifyKey.transactionsLogs!, mCashLog: mResponseVerifyKey.cashLogs!, completion: { (mResponseCashLogs) in
                            if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue || mResponseCashLogs.handleAction == EnumTransactionsAction.CASH_LOGS_EXISTING.rawValue {
                                self.doFinshTranctions(transaction: mResponseCashLogs.transactionsLogs!, mCash:
                                    mResponseCashLogs.cashLogs!, completion: { (mResponseFishTranction) in
                                    if mResponseFishTranction.handleAction == EnumTransactionsAction.FINISH_TRANSACTION_SUCCESS.rawValue{
                                        self.doeCashRelease(completion: { (mComplete) in
                                            if mComplete.handleAction == EnumTransactionsAction.CASH_RELEASE_SUCCESS.rawValue {
                                                self.handCallBackLoop(transactionsId: transactionsId)
                                            }
                                            else{
                                                debugPrint("Complete synced data")
                                                CommonService.bindingData()
                                                let obj = EventBusObjectData(data: EnumPassdata.UserDataDidChange.rawValue, type: DataKeyType.StringOriginal, identify: EnumViewControllerNameIdentifier.GlobalUpdateEvent)
                                                print("=-=-==-=-=-=-=-= Call event bus =-=-==-=-=-=-=-=")
                                                CommonService.eventPushActionToObjectView(obj: obj)
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }else{
                        
                        /*Invalid cash*/
                        self.handleCashLogsInvalid(transaction: mResponseVerifyKey.transactionsLogs!, mCashLog: mResponseVerifyKey.cashLogs!, completion: { (mResponseCashLogs) in
                            if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_INVALID_LOGS_SUCCESS.rawValue || mResponseCashLogs.handleAction == EnumTransactionsAction.CASH_INVALID_LOGS_EXISTING.rawValue {
                                self.doFinshTranctions(transaction: mResponseCashLogs.transactionsLogs!, mCash:
                                    mResponseCashLogs.cashLogs!, completion: { (mResponseFishTranction) in
                                        if mResponseFishTranction.handleAction == EnumTransactionsAction.FINISH_TRANSACTION_SUCCESS.rawValue{
                                            self.doeCashRelease(completion: { (mComplete) in
                                                if mComplete.handleAction == EnumTransactionsAction.CASH_RELEASE_SUCCESS.rawValue {
                                                    self.handCallBackLoop(transactionsId: transactionsId)
                                                }
                                                else{
                                                    debugPrint("Complete synced data")
                                                     CommonService.bindingData()
                                                }
                                            })
                                        }
                                })
                            }
                        })
                        
                    }
                })
            }
        })
    }
    
    
    /*Handle transactions log  - step 2*/
    func handleTransactionsLogs(transferData : TransferDataModel , completion: @escaping (_ result: TransactionsModel)->()){
        debugPrint("transactions id \(transferData.id ?? "")")
        var transactionsLogs : TransactionsLogsEntityModel!
        if let mTransferExisting = SQLHelper.getLatestTransactionsLogs(){
            transactionsLogs = TransactionsLogsEntityModel(data: transferData,dataExisting: mTransferExisting)
            debugPrint("Exsiting value.......")
            if (SQLHelper.insertedTransactionLogs(data: transactionsLogs)){
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue, transferData: transferData)
                if let mFirstData = SQLHelper.getFirstRowTransactionsLogs(){
                    let mId = mFirstData.id ?? 0
                    let mPreviousHash =  TransactionsLogsEntityModel.caculatePreviousHash(transactionsLogs)(transactionsLogs: transactionsLogs)
                    SQLHelper.updatedTransactionsLogs(id: mId , previousHash: mPreviousHash)
                }
                completion(mTransactionModel)
            }else{
                  let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_FAILED.rawValue, transferData: transferData)
                 completion(mTransactionModel)
            }
        }else{
            debugPrint("Not exsiting value.......")
            transactionsLogs = TransactionsLogsEntityModel(data: transferData,dataExisting: nil)
            if (SQLHelper.insertedTransactionLogs(data: transactionsLogs)){
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue, transferData: transferData)
                completion(mTransactionModel)
                debugPrint("Inserted transactions successfully")
            }else{
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.TRANSACTIONS_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_TRANSACTION_FAILED.rawValue, transferData: transferData)
                completion(mTransactionModel)
            }
        }
    }
    
    /*Handle cash logs temporary - step 3*/
    func handCashLogsTemporary(mTransferData : TransferDataModel ,completion: @escaping (_ result: TransactionsModel)->()){
        let data = mTransferData.cashEnc?.stringToArray(separatedBy: "$")
        guard let moneyEncrypted = data else {
            debugPrint("moneyEncrypted is nil")
            return
        }
        debugPrint("Starting \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................decrypt")
        let decryptedData = ELGamalHelper.instance.decryptedPackage(receiverPrivateKey: CommonService.getPrivateKey() ?? "", encData: moneyEncrypted)
        debugPrint("Ending \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................decrypt")
        debugPrint("Count decrypted \(decryptedData.count)")
        var mCount = 0
        decryptedData.forEach { value in
            let transferValue = CashEncModel(dataPackage: value,transactionSignature: mTransferData.id ?? "")
            var cashLogs : CashLogsEntityModel!
            debugPrint("This cash was received from sender and serial is====================> \(transferValue.serialNo?.description ?? "")")
            if let eCashExisting = SQLHelper.getLatestCashLogsTemporary(){
                cashLogs = CashLogsEntityModel(data: transferValue, inputOutput: CommonService.isInput,dataExisting: eCashExisting)
                debugPrint("Exsiting value.......")
                if (SQLHelper.allowTemporaryInput(mSerial: cashLogs.serial ?? 0) && SQLHelper.insertedCashLogsTemporary(data: cashLogs)){
                    if let mFirstData = SQLHelper.getFirstRowCashLogsTemporary(){
                        let mId = mFirstData.id ?? 0
                        let mPreviousHash = cashLogs.previousHash ?? ""
                        SQLHelper.updatedCashLogsTemporary(id: mId , previousHash: mPreviousHash)
                    }
                }
            }else{
                debugPrint("Not exsiting value.......")
                cashLogs = CashLogsEntityModel(data: transferValue, inputOutput: CommonService.isInput,dataExisting: nil)
                if (SQLHelper.allowTemporaryInput(mSerial: cashLogs.serial ?? 0) && SQLHelper.insertedCashLogsTemporary(data: cashLogs)){
                    debugPrint("Inserted cash successfully")
                }
            }
            debugPrint("Serial handCashLogsTemporary....\(transferValue.serialNo ?? "")")
            mCount += 1
            if mCount == decryptedData.count{
                 let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS_TEMPORARY.rawValue , handleAction:  EnumTransactionsAction.INSERT_CASH_LOGS_TEMPORARY_SUCCESS.rawValue)
                 completion(mTransactionModel)
            }
        }
    }
    
    /*Handle cash  logs - step 4*/
    /*Skip loop*/
    func handleCashLogs(transaction : TransactionsLogsEntityModel, mCashLog : CashLogsEntityModel ,completion: @escaping (_ result: TransactionsModel)->()){
            debugPrint("handCashLogs")
            var cashLogs : CashLogsEntityModel!
            if let eCashExisting = SQLHelper.getLatestCashLogs(){
                cashLogs = CashLogsEntityModel(data: mCashLog, inputOutput: CommonService.isInput,dataExisting: eCashExisting)
                if (SQLHelper.allowInput(mSerial: mCashLog.serial ?? 0) && SQLHelper.insertedCashLogs(data: cashLogs)){
                    debugPrint("Allow insert")
                    if let mFirstData = SQLHelper.getFirstRowCashLogs(){
                        let mId = mFirstData.id ?? 0
                         let mPreviousHash =  CashLogsEntityModel.caculatePreviousHash(cashLogs)(cashLogs: cashLogs)!
                        SQLHelper.updatedCashLogs(id: mId , previousHash: mPreviousHash)
                        let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                        completion(mTransactionModel)
                    }
                }else{
                    let message = "This cash: \(mCashLog.serial?.description ?? "") already stored with status is IN"
                    CommonService.localPush(message: message)
                    debugPrint("This cash already inserted====================> \(mCashLog.serial?.description ?? "")")
                    debugPrint("Not Allowed insert")
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.CASH_LOGS_EXISTING.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                    completion(mTransactionModel)
                }
            }else{
                debugPrint("Not exsiting value.......")
                cashLogs = CashLogsEntityModel(data: mCashLog, inputOutput: CommonService.isInput,dataExisting: nil)
                if (SQLHelper.allowInput(mSerial: mCashLog.serial ?? 0) &&
                    SQLHelper.insertedCashLogs(data: cashLogs)){
                     debugPrint("Allow insert...")
                    debugPrint("Inserted cash successfully")
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_LOGS_SUCCESS.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                    completion(mTransactionModel)
                }else{
                    debugPrint("Not Allowed insert...")
                    let message = "This cash: \(mCashLog.serial?.description ?? "") already stored with status is IN"
                    CommonService.localPush(message: message)
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_LOGS.rawValue , handleAction: EnumTransactionsAction.CASH_LOGS_EXISTING.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                    completion(mTransactionModel)
                }
            }
    }
    
    func handleCashLogsInvalid(transaction : TransactionsLogsEntityModel, mCashLog : CashLogsEntityModel ,completion: @escaping (_ result: TransactionsModel)->()){
        debugPrint("handCashLogs")
        var cashLogs : CashLogsEntityModel!
        if let eCashExisting = SQLHelper.getLatestCashLogsInvalid(){
            cashLogs = CashLogsEntityModel(data: mCashLog, inputOutput: CommonService.isInput,dataExisting: eCashExisting)
            if (SQLHelper.allowInputInValid(mSerial: mCashLog.serial ?? 0) && SQLHelper.insertedCashInvalid(data: cashLogs)){
                debugPrint("Allow insert")
                if let mFirstData = SQLHelper.getFirstRowCashLogsInvalid(){
                    let mId = mFirstData.id ?? 0
                    let mPreviousHash = cashLogs.previousHash ?? ""
                    SQLHelper.updatedCashLogsInvalid(id: mId , previousHash: mPreviousHash)
                    
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_INVALID_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_INVALID_LOGS_SUCCESS.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                    completion(mTransactionModel)
                }
            }else{
                let message = "This cash: \(mCashLog.serial?.description ?? "") already stored with status is IN"
                CommonService.localPush(message: message)
                debugPrint("This cash already inserted====================> \(mCashLog.serial?.description ?? "")")
                debugPrint("Not Allowed insert")
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_INVALID_LOGS.rawValue , handleAction: EnumTransactionsAction.CASH_INVALID_LOGS_EXISTING.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                completion(mTransactionModel)
            }
        }else{
            debugPrint("Not exsiting value.......")
            cashLogs = CashLogsEntityModel(data: mCashLog, inputOutput: CommonService.isInput,dataExisting: nil)
            if (SQLHelper.allowInputInValid(mSerial: mCashLog.serial ?? 0) &&
                SQLHelper.insertedCashInvalid(data: cashLogs)){
                debugPrint("Allow insert...")
                debugPrint("Inserted cash successfully")
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_INVALID_LOGS.rawValue , handleAction: EnumTransactionsAction.INSERT_CASH_INVALID_LOGS_SUCCESS.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                completion(mTransactionModel)
            }else{
                debugPrint("Not Allowed insert...")
                let message = "This cash: \(mCashLog.serial?.description ?? "") already stored with status is IN"
                CommonService.localPush(message: message)
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_INVALID_LOGS.rawValue , handleAction: EnumTransactionsAction.CASH_INVALID_LOGS_EXISTING.rawValue, transactionsLogs:transaction,cashLogs: mCashLog)
                completion(mTransactionModel)
            }
        }
    }
    
    /*Handle finish transaction - step 5*/
    func doFinshTranctions(transaction : TransactionsLogsEntityModel, mCash : CashLogsEntityModel , completion: @escaping (_ result: TransactionsModel)->()){
        guard let mTransaction = SQLHelper.geteTransactionsLogs(key: mCash.transactionSignature ?? "") else{
            debugPrint("Could not get data")
            return
        }
        let mValue = TransferDataModel(data: mTransaction)
        Utils.logMessage(message: "Stopping receive socket...")
        stoppingReceiveSocket(value: mValue)
        SQLHelper.deleteCashLogsTemporary(id: mCash.id ?? 0)
        let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.FINISH_TRANSACTION.rawValue , handleAction: EnumTransactionsAction.FINISH_TRANSACTION_SUCCESS.rawValue)
        completion(mTransactionModel)
    }
    
    /*Verify cash*/
    func doeCashRelease(completion: @escaping (_ result: TransactionsModel)->()){
        guard let mCash =  SQLHelper.getFirstRowCashLogsTemporary() else {
            debugPrint("Synced Cash logs completely")
            let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_RELEASE.rawValue , handleAction:  EnumTransactionsAction.CASH_RELEASE_COMPLETE.rawValue)
            completion(mTransactionModel)
            return
        }
        
        if let mDecisionsDiary = SQLHelper.getDecisionsDiary(key: mCash.decisionNo ?? "") {
            let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_RELEASE.rawValue , handleAction:  EnumTransactionsAction.CASH_RELEASE_SUCCESS.rawValue, cashLogs : mCash, decisionsDiary : mDecisionsDiary)
            completion(mTransactionModel)
            debugPrint("DecisionsDiary already found....")
            return
        }
        
        debugPrint("doeCashRelease=====>mDecisionsDiary")
        Utils.logMessage(object: mCash)
        userService.getPublicKeyeCashRelease(data: PublicKeueCashReleaseRequestModel(decisionCode: mCash.decisionNo ?? "")) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("Get cash release")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let decisionsDiary = DecisionsDiaryEntityModel(data:response.responseData,decisionNo: mCash.decisionNo ?? "")
                        if SQLHelper.insertedDecisionsDiary(data: decisionsDiary){
                            let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.CASH_RELEASE.rawValue , handleAction:  EnumTransactionsAction.CASH_RELEASE_SUCCESS.rawValue, cashLogs : mCash, decisionsDiary : decisionsDiary)
                            completion(mTransactionModel)
                        }
                        debugPrint("Re call")
                    }else{
                       debugPrint(response.responseMessage ?? "")
                    }
                }
                break
            case .failure( let error ):
                debugPrint(error.message ?? "")
                break
            }
        }
    }
    
    func doVerifyKey(mCash : CashLogsEntityModel, mDecicitionsDiary : DecisionsDiaryEntityModel,completion: @escaping (_ result: TransactionsModel)->()){
        debugPrint("Starting \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................verify cash")
        let requestAccSign = CashLogsEntityModel(isAccSign: true, data: mCash, response: mDecicitionsDiary)
        let requestTreSign = CashLogsEntityModel(isAccSign: false, data: mCash, response: mDecicitionsDiary)
        debugPrint("Ending \(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.FormatTimeSecond))....................................................verify cash")
        if requestAccSign.verify ?? false && requestTreSign.verify ?? false {
            debugPrint("This case is valid")
            guard let mTransaction = SQLHelper.geteTransactionsLogs(key: mCash.transactionSignature ?? "") else {
                return
            }
            let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.VERIFY_KEY.rawValue , handleAction:  EnumTransactionsAction.VERIFY_KEY_SUCCESS.rawValue,transactionsLogs: mTransaction,cashLogs: mCash)
            completion(mTransactionModel)
        }else{
            guard let mTransaction = SQLHelper.geteTransactionsLogs(key: mCash.transactionSignature ?? "") else {
                return
            }
            let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.VERIFY_KEY.rawValue , handleAction:  EnumTransactionsAction.VERIFY_KEY_FAILED.rawValue,transactionsLogs: mTransaction,cashLogs: mCash)
            completion(mTransactionModel)
        }
    }
    
    /*Stopping receive socket*/
    func stoppingReceiveSocket(value : TransferDataModel){
        if Helper.isConnectedToNetwork(){
            if WebSocketClientHelper.instance.socket.isConnected {
                let socketId = value.refId ?? ""
                guard let _ = SQLHelper.getSocketReply(key: socketId) else{
                    let mDataSend = JSONSerializerHelper.toJson(value)
                    if SQLHelper.insertedSocketReply(data: SocketReplyEntityModel(replyId: socketId)){
                        WebSocketClientHelper.instance.socket.write(string: mDataSend)
                    }
                    debugPrint("Stopping received socket \(mDataSend)")
                    return
                }
            }
        }
    }
    
    func saveItemToContact(index : Int,data : [TransferDataSyncContactData], contact : [String:String]){
        CommonService.saveContact(index: index, data: data[index], contact: contact) { (result) in
            if result > -1 {
                if result == (data.count) {
                    Utils.logMessage(message: "Saved items to db successfully")
                }else{
                    self.saveItemToContact(index: result, data: data,contact: contact)
                }
            }
        }
    }
}
