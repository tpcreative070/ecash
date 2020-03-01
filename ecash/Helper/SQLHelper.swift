//
//  SQLHelper.swift
//  ecash
//
//  Created by phong070 on 8/15/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import SQLite
class SQLShareHelper {
    static let shared =  SQLShareHelper()
    private var connection : Connection?
    func setConnection(db : Connection? = nil){
        self.connection = db
    }
    func getConnection() ->Connection?{
        return connection
    }
}

class SQLHelper {
    
    class open func connect(mKey : String,url : String) ->Connection?{
        do {
            if let mConnection = SQLShareHelper.shared.getConnection()  {
                debugPrint("Already connected to SQLine")
                return mConnection
            }
            let  db = try Connection(url)
            guard let key = CommonService.getMasterKey() else {
                try db.key(mKey) // error with the version 0.11.5
                CommonService.setMasterKey(data : mKey)
                SQLShareHelper.shared.setConnection(db: db)
                debugPrint("Connected successfully")
                return db
            }
            if mKey != key {
                try db.key(key) // error with the version 0.11.5
                try db.rekey(mKey)
                CommonService.setMasterKey(data : mKey)
                SQLShareHelper.shared.setConnection(db: db)
                return db
            }
            try db.key(key) // error with the version 0.11.5
            SQLShareHelper.shared.setConnection(db: db)
            debugPrint("Connected successfully!!!")
            return db
        } catch let error{
            debugPrint("SQLite Database Error \(error.localizedDescription)")
            // Database cannot connect because of violent security
            AlertHelper.showErrorAlert(message: LanguageHelper.getTranslationByKey(LanguageKey.LocalDataHadViolented) ?? "")
            return nil
        }
//        return nil
    }
    
    class open func initCipher(isDelete : Bool? = nil){
        guard let mData = DocumentHelper.loadBundle(fileName: "eWalletCipher", mExtension: FolderName.db) else {
            debugPrint("Not found...")
            return
        }
        writeFile(data: mData,isDelete: isDelete)
    }
    
    class open func writeFile(data : Data,isDelete : Bool? = nil){
        let fileName = "eWalletCipher.db"
        if let _ = isDelete {
            DocumentHelper.createdFile(data: data, folderName: FolderName.db,fileName: fileName)
            return
        }
        guard let _ = DocumentHelper.getFilePath(fileName: fileName,folderName: FolderName.db) else {
            DocumentHelper.createdFile(data: data, folderName: FolderName.db,fileName: fileName)
            debugPrint("eWalletCipher.db was created")
            return
        }
    }
    
    class open func getPathFile() -> Bool{
        let fileName = "eWalletCipher.db"
        guard let _ = DocumentHelper.getFilePath(fileName: fileName,folderName: FolderName.db) else {
            return false
        }
        return true
    }
    
    class open func connection() -> Connection?{
        let fileName = "eWalletCipher.db"
        guard let mUrl = DocumentHelper.getFilePath(fileName: fileName,folderName: FolderName.db) else {
            return nil
        }
        
        guard let mKey = CommonService.getMasterKey() else {
            guard let db = SQLHelper.connect(mKey: CipherKey.Key,url: mUrl.path) else {
                return nil
            }
            return db
        }
        debugPrint("Key to connect db : \(mKey)")
        guard let db = SQLHelper.connect(mKey: mKey,url: mUrl.path) else {
            return nil
        }
        return db
    }
    
    class open func replaceKey(mKey : String){
        SQLShareHelper.shared.setConnection(db: nil)
        let fileName = "eWalletCipher.db"
        guard let mUrl = DocumentHelper.getFilePath(fileName: fileName,folderName: FolderName.db) else {
            return
        }
        guard let _ = SQLHelper.connect(mKey: mKey,url: mUrl.path) else {
            return
        }
    }
    
    /*Create IssuersDiaryh*/
    class open func createdIssuersDiary(){
        guard let db = connection() else {
            return
        }
        IssuersDiaryEntity.instance.createTable(db: db)
    }
    
    /*Insert issuers diary*/
    class open func insertedIssuersDiary(data : IssuersDiaryEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return IssuersDiaryEntity.instance.insert(db: db, data: data)
    }
    
    /*Get object issuers diary*/
    class open func geteCashToeCash(key : String) -> IssuersDiaryEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return IssuersDiaryEntity.instance.getObject(db: db, key: key)
    }
    
    /*Create CashLogs*/
    class open func createCashLogs(){
        guard let db = connection() else {
            return
        }
        CashLogsEntity.instance.createTable(db: db)
    }
    
    /*Insert cash logs*/
    class open func insertedCashLogs(data : CashLogsEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return CashLogsEntity.instance.insert(db: db, data: data)
    }
    
    /*Update cash logs*/
    class open func updatedCashLogs(id : Int, previousHash : String){
        guard let db = connection() else {
            return
        }
        return CashLogsEntity.instance.update(db: db, mId: id, mPreviousHash: previousHash)
    }
    
    /*Get object cash logs*/
    class open func geteCashLogs(key : Int64) -> CashLogsEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getObject(db: db, key: key)
    }
    
    /*Get latest row*/
    class open func getLatestCashLogs() -> CashLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getLatestRow(db: db)
    }
    
    /*Get first row*/
    class open func getFirstRowCashLogs() -> CashLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getFirstRow(db: db)
    }
    
    /*Get list ecash logs*/
    class open func getListCashLogs() -> [CashLogsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getList(db: db)
    }
    
    /*Get list ecash logs*/
    class open func getListCashLogs(transactionsId : String, isExchanged : Bool? = nil) -> [CashLogsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getList(value: transactionsId,isExchanged: isExchanged, db: db)
    }
    
    /*Get list all of ecash logs*/
    class open func getListAllCashLogs() -> [CashLogsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getListAll(db: db)
    }
    
    /*Delete at id*/
    class open func deleteCashLogs(id : Int){
        guard let db = connection() else {
            return
        }
        return CashLogsEntity.instance.delete(db: db, idValue: id)
    }
    
    /*Delete whole table*/
    class open func deleteCashLogs(){
        guard let db = connection() else {
            return
        }
        CashLogsEntity.instance.delete(db: db)
    }
    
    /*Checking allow input*/
    class open func allowInput(mSerial: Int64) -> Bool{
        guard let db = connection() else {
            return false
        }
        return CashLogsEntity.instance.allowInput(db: db, mSerial: mSerial)
    }
    
    /*Checking allow output*/
    class open func allowOutput(mSerial : Int64) -> Bool {
        guard let db = connection() else {
            return false
        }
        return CashLogsEntity.instance.allowOutput(db: db, mSerial: mSerial)
    }
    
    /*getting availableList*/
    class open func getListAvailable() -> [CashLogsEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return CashLogsEntity.instance.getListAvailable(db: db)
    }
    
    /*getting total eCash*/
    class open func getTotaleCash() -> Int64?{
        guard let db = connection() else {
            return 0
        }
        return CashLogsEntity.instance.getTotaleCashAvailable(db: db)
    }
    
    /*Create transaction logs*/
    class open func createTransactionsLogs(){
        guard let db = connection() else {
            return
        }
        TransactionsLogsEntity.instance.createTable(db: db)
    }
    
    /*Insert transactions log*/
    class open func insertedTransactionLogs(data : TransactionsLogsEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return TransactionsLogsEntity.instance.insert(db: db, data: data)
    }
    
    /*Update cash logs*/
    class open func updatedTransactionsLogs(id : Int, previousHash : String){
        guard let db = connection() else {
            return
        }
        return TransactionsLogsEntity.instance.update(db: db, mId: id, mPreviousHash: previousHash)
    }
    
    /*Get object transactions logs*/
    class open func geteTransactionsLogs(key : String) -> TransactionsLogsEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.getObject(db: db, key: key)
    }
    
    /*Get latest row*/
    class open func getLatestTransactionsLogs() -> TransactionsLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.getLatestRow(db: db)
    }
    
    /*Get first row*/
    class open func getFirstRowTransactionsLogs() -> TransactionsLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.getFirstRow(db: db)
    }
    
    /*Get list transactions logs*/
    class open func getListTransactionsLogs() -> [TransactionsLogsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.getList(db: db)
    }
    
    /*Get list all of transactions logs*/
    class open func getListAllTransactionsLogs() -> [TransactionsLogsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.getListAll(db: db)
    }
    
    class open func getListTransactionsLogsView() -> [TransactionHistoyEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.getListTransactions(db: db)
    }
    
    class open func searchTransactionsLogsView(key : String) -> [TransactionHistoyEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.searchView(db: db, key: key)
    }
    
    /*Delete at id*/
    class open func deleteTransactionsLogs(id : Int){
        guard let db = connection() else {
            return
        }
        return TransactionsLogsEntity.instance.delete(db: db, idValue: id)
    }
    
    /*Delete whole table*/
    class open func deleteTransactionsLogs(){
        guard let db = connection() else {
            return
        }
        TransactionsLogsEntity.instance.delete(db: db)
    }
    
    /*Filter params for transaction logs history*/
    
    class open func filterTransactionLogsHistory(transType : String, transDate : String, transStatus : String) ->[TransactionHistoyEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return TransactionsLogsEntity.instance.filterView(db: db, transType: transType, transDate: transDate, transStatus: transStatus)
    }
    
    /*Create CashLogsTemporary*/
    class open func createCashLogsTemporary(){
        guard let db = connection() else {
            return
        }
        CashLogsTemporaryEntity.instance.createTable(db: db)
    }
    
    /*Insert cash logs*/
    class open func insertedCashLogsTemporary(data : CashLogsEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return CashLogsTemporaryEntity.instance.insert(db: db, data: data)
    }
    
    /*Update cash logs*/
    class open func updatedCashLogsTemporary(id : Int, previousHash : String){
        guard let db = connection() else {
            return
        }
        return CashLogsTemporaryEntity.instance.update(db: db, mId: id, mPreviousHash: previousHash)
    }
    
    /*Get object cash logs*/
    class open func geteCashLogsTemporary(key : Int64) -> CashLogsEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return CashLogsTemporaryEntity.instance.getObject(db: db, key: key)
    }
    
    /*Get latest row*/
    class open func getLatestCashLogsTemporary() -> CashLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsTemporaryEntity.instance.getLatestRow(db: db)
    }
    
    /*Get first row*/
    class open func getFirstRowCashLogsTemporary() -> CashLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsTemporaryEntity.instance.getFirstRow(db: db)
    }
    
    /*Get list ecash logs*/
    class open func getListeCashLogsTemporary() -> [CashLogsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return CashLogsTemporaryEntity.instance.getList(db: db)
    }
    
    /*Delete at id*/
    class open func deleteCashLogsTemporary(id : Int){
        guard let db = connection() else {
            return
        }
        return CashLogsTemporaryEntity.instance.delete(db: db, idValue: id)
    }
    
    /*Delete whole table*/
    class open func deleteCashLogsTemporary(){
        guard let db = connection() else {
            return
        }
        CashLogsTemporaryEntity.instance.delete(db: db)
    }
    
    /*Checking allow input*/
    class open func allowTemporaryInput(mSerial: Int64) -> Bool{
        guard let db = connection() else {
            return false
        }
        return CashLogsTemporaryEntity.instance.allowInput(db: db, mSerial: mSerial)
    }
    
    /*Checking allow output*/
    class open func allowTemporaryOutput(mSerial : Int64) -> Bool {
        guard let db = connection() else {
            return false
        }
        return CashLogsTemporaryEntity.instance.allowOutput(db: db, mSerial: mSerial)
    }
    
    
    /*Create contacts*/
    class open func createContacts(){
        guard let db = connection() else {
            return
        }
        ContactsEntity.instance.createTable(db: db)
    }
    
    /*Insert contacts*/
    class open func insertedContacts(data : ContactsEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return ContactsEntity.instance.insert(db: db, data: data)
    }
    
    /*Update contacts*/
    class open func updatedContacts(id : Int64, value : Int64){
        guard let db = connection() else {
            return
        }
        return ContactsEntity.instance.update(db: db, mWalletId: id, value: value)
    }
    
    /*Get object contacts*/
    class open func getContacts(key : Int64) -> ContactsEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return ContactsEntity.instance.getObject(db: db, key: key)
    }
    
    /*Get list contacts*/
    class open func getListContacts() -> [ContactsEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return ContactsEntity.instance.getList(db: db)
    }
    
    class open func searchContacts(key : String) -> [ContactsEntityModel]? {
        guard let db = connection() else {
            return nil
        }
        return ContactsEntity.instance.search(db: db, key: key)
    }
    
    /*Delete at id*/
    class open func deleteContacts(id : Int64){
        guard let db = connection() else {
            return
        }
        ContactsEntity.instance.delete(db: db, value: id)
    }
    
    /*Delete whole table*/
    class open func deleteContacts(){
        guard let db = connection() else {
            return
        }
        ContactsEntity.instance.delete(db: db)
    }
    
    /*Update contact*/
    class open func updateContacts(walletId : Int64,value :  String) -> Bool{
        guard let db = connection() else {
            return false
        }
        return ContactsEntity.instance.update(db: db, mWalletId: walletId, value: value)
    }
    
    /*Update contact*/
    class open func updateContacts(walletId : Int64,value :  Bool) -> Bool{
        guard let db = connection() else {
            return false
        }
        return ContactsEntity.instance.update(db: db, mWalletId: walletId, value: value)
    }
    
    /*Delete contact*/
    class open func deleteContacts(walletId : Int64) ->Bool{
        guard let db = connection() else {
            return false
        }
        return ContactsEntity.instance.delete(db: db, value: walletId)
    }
    
    /*----------------------------------Invalid cash------------------------------*/
    /*Create invalid*/
    class open func createInvalidCash(){
        guard let db = connection() else {
            return
        }
        CashInValid.instance.createTable(db: db)
    }
    
    /*Insert invalids*/
    class open func insertedCashInvalid(data : CashLogsEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return CashInValid.instance.insert(db: db, data: data)
    }
    
    /*Get latest row*/
    class open func getLatestCashLogsInvalid() -> CashLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return CashInValid.instance.getLatestRow(db: db)
    }
    
    /*Get first row*/
    class open func getFirstRowCashLogsInvalid() -> CashLogsEntityModel? {
        guard let db = connection() else {
            return nil
        }
        return CashInValid.instance.getFirstRow(db: db)
    }
    
    /*Checking allow input*/
    class open func allowInputInValid(mSerial: Int64) -> Bool{
        guard let db = connection() else {
            return false
        }
        return CashInValid.instance.allowInput(db: db, mSerial: mSerial)
    }
    
    /*Checking allow output*/
    class open func allowOutputInValid(mSerial : Int64) -> Bool {
        guard let db = connection() else {
            return false
        }
        return CashInValid.instance.allowOutput(db: db, mSerial: mSerial)
    }
    
    /*Update cash logs*/
    class open func updatedCashLogsInvalid(id : Int, previousHash : String){
        guard let db = connection() else {
            return
        }
        return CashInValid.instance.update(db: db, mId: id, mPreviousHash: previousHash)
    }
    
    /*get invalid cash logs*/
    class open func getListCashInvaidLogs() -> [CashLogsEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return CashInValid.instance.getList(db: db)
    }
    
    /*get invalid cash logs*/
    class open func getListCashInvaidLogs(transactionsId : String) -> [CashLogsEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return CashInValid.instance.getList(value: transactionsId, db: db)
    }
    
    /*Create socket reply*/
    class open func createSocketReply(){
        guard let db = connection() else {
            return
        }
        SocketReplyEntities.instance.createTable(db: db)
    }
    
    /*Insert socket reyply*/
    class open func insertedSocketReply(data : SocketReplyEntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return SocketReplyEntities.instance.insert(db: db, data: data)
    }
    
    /*Get object socket reply*/
    class open func getSocketReply(key : String) -> SocketReplyEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return SocketReplyEntities.instance.getObject(db: db, key: key)
    }
    
    
    /*TransactionQRCode*/
    
    /*Create transactionqr*/
    class open func createdTransactionQR(){
        guard let db = connection() else {
            return
        }
        TransactionQREntity.instance.createTable(db: db)
    }
    
    /*Insert transactionqr*/
    class open func insertedTransactionQR(data : TransactionQREntityModel) -> Bool{
        guard let db = connection() else {
            return false
        }
        return TransactionQREntity.instance.insert(db: db, data: data)
    }
    
    /*Get object transactionqr*/
    class open func getTransactionQR(key : String) -> TransactionQREntityModel?{
        guard let db = connection() else {
            return nil
        }
        return TransactionQREntity.instance.getObject(db: db, key: key)
    }
    
    class open func getTransactionQR() -> [TransactionQREntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return TransactionQREntity.instance.getList(db: db)
    }
    
    class open func getTransactionQRList(key : String) -> [TransactionQREntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return TransactionQREntity.instance.getList(db: db, key: key)
    }
    
    class open func updateTransactionQR(valueUpdate : String,valueChange : String){
        guard let db = connection() else {
            return
        }
        return TransactionQREntity.instance.update(db: db, valueUpdate: valueUpdate, valueChange: valueChange)
    }
    
    class open func updateTransactionQR(data : TransactionQREntityModel){
        guard let db = connection() else {
            return
        }
        return TransactionQREntity.instance.update(db: db,data: data)
    }
    
     /*Create Notification history*/
     class open func createNotificationHistory(){
         guard let db = connection() else {
             return
         }
         NotificationHistoryEntity.instance.createTable(db: db)
     }
     
     /*Insert notification*/
     class open func insertedNotificationHistory(data : NotificationHistoryEntityModel){
         guard let db = connection() else {
             return
         }
         return NotificationHistoryEntity.instance.insert(db: db, data: data)
     }
     
     /*Get list of notification history*/
     class open func getNotificationHistoryList() -> [NotificationHistoryEntityModel]?{
         guard let db = connection() else {
             return nil
         }
         return NotificationHistoryEntity.instance.getList(db: db)
     }
    
    
     /*Updated notification history*/
    class open func updateNotificationHistory(index : Int64){
         guard let db = connection() else {
            return
         }
        return NotificationHistoryEntity.instance.update(db: db, mId: index)
     }
    
     class open func getAvailableNotificationHistoryList() -> [NotificationHistoryEntityModel]?{
            guard let db = connection() else {
                return nil
            }
            return NotificationHistoryEntity.instance.getListAvailable(db: db)
     }
    
    class open func deleteNotificationHistory(index : Int){
        guard let db = connection() else {
            return
        }
        return NotificationHistoryEntity.instance.delete(db: db, key: Int64(index))
    }
    
    //CashTemp
    
    /*Create cash temp*/
    class open func createCashTemp(){
        guard let db = connection() else {
            return
        }
        CashTempEntity.instance.createTable(db: db)
    }
       
    /*Insert cash temp*/
    class open func insertedCashTemp(data : CashTempEntityModel){
        guard let db = connection() else {
               return
        }
        CashTempEntity.instance.insert(db: db, data: data)
    }
    
    /*Get temp of object*/
    class open func getCashTempObject(key : String) -> CashTempEntityModel?{
        guard let db = connection() else {
            return nil
        }
        return CashTempEntity.instance.getObject(db: db, key: key)
    }
         
    /*Get list of cash temp*/
    class open func getCashTempList() -> [CashTempEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return CashTempEntity.instance.getList(db: db)
    }
      
    class open func deleteCashTemp(index : Int){
        guard let db = connection() else {
            return
        }
        return CashTempEntity.instance.delete(db: db, key: Int64(index))
    }
    
    class open func updateeCashTemp(data : CashTempEntityModel){
        guard let db = connection() else {
            return
        }
        return CashTempEntity.instance.update(db: db,data:data)
    }
    
    class open func getCountLixi() -> Int{
        guard let db = connection() else {
            return 0
        }
        return CashTempEntity.instance.getCountLixi(db: db)
    }
         
    //Denomination
       
    /*Create denomination*/
    class open func createDenomination(){
        guard let db = connection() else {
            return
        }
        CashValuesEntity.instance.createTable(db: db)
    }
          
    /*Insert denomination*/
    class open func insertedDenomination(data : CashValuesEntityModel){
        guard let db = connection() else {
            return
        }
        return CashValuesEntity.instance.insert(db: db, data: data)
    }
          
    /*Get list of denomination*/
    class open func getDenomination() -> [CashValuesEntityModel]?{
        guard let db = connection() else {
            return nil
        }
        return CashValuesEntity.instance.getList(db: db)
    }
         
    class open func deleteDenomination(){
        guard let db = connection() else {
            return
        }
        return CashValuesEntity.instance.delete(db: db)
    }
    
}


