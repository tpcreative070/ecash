//
//  TransactionLogsEntity.swift
//  ecash
//
//  Created by phong070 on 9/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class TransactionsLogsEntity {
    static let instance = TransactionsLogsEntity()
    private let table = Table("TRANSACTIONS_LOGS")
    private let id = Expression<Int>("id")
    private let senderAccountId    = Expression<Int64>("senderAccountId")
    private let receiverAccountId = Expression<Int64>("receiverAccountId")
    private let type  = Expression<String>("type")
    private let time = Expression<String>("time")
    private let content  = Expression<String>("content")
    private let cashEnc  = Expression<String>("cashEnc")
    private let refId = Expression<String>("refId")
    private let transactionSignature  = Expression<String>("transactionSignature")
    private let previousHash  = Expression<String>("previousHash")
   //for view
    private let amount    = Expression<Int64>("amount")
    
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(id,primaryKey: true)
                t.column(senderAccountId)
                t.column(receiverAccountId)
                t.column(type)
                t.column(time)
                t.column(content)
                t.column(cashEnc)
                t.column(refId)
                t.column(transactionSignature,unique: true)
                t.column(previousHash)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : TransactionsLogsEntityModel) -> Bool{
        debugPrint("transactionSignature !!!!\(data.transactionSignature ?? "")")
        debugPrint("Saved transaction...\(data.senderAccountId ?? 0)")
        dump(data)
        let request = table.insert(senderAccountId <- data.senderAccountId!,
                                   receiverAccountId <-  data.receiverAccountId!,
                                   type <- data.type!,
                                   time <- data.time!,
                                   content <- data.content!,
                                   cashEnc <- data.cashEnc!,
                                   refId <- data.refId!,
                                   transactionSignature <- data.transactionSignature!,
                                   previousHash <- data.previousHash!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted transactions logs successfully")
            return true
        }catch {
            debugPrint("\(error) \(data.transactionSignature ?? "")")
        }
        return false
    }
    
    func getList(db : Connection) -> [TransactionsLogsEntityModel]?{
        do{
            let response = try db.prepare(table).map({(event) -> TransactionsLogsEntityModel in
               return TransactionsLogsEntityModel(id: event[id], senderAccountId: event[senderAccountId], receiverAccountId: event[receiverAccountId], type: event[type], time: event[time], content: event[content], cashEnc: event[cashEnc],refId: event[refId], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
            })
            
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func getListAll(db : Connection) -> [TransactionsLogsEntityModel]?{
        do{
            
            //let alphobelCode =  "\(String(transactionsLogs!.senderAccountId ?? 0))\(String(transactionsLogs!.receiverAccountId ?? 0))\(String(transactionsLogs!.type ?? ""))\(String(transactionsLogs!.time ?? ""))\(String(transactionsLogs!.content ?? ""))\(String(transactionsLogs!.cashEnc ?? ""))\(String(transactionsLogs!.refId ?? ""))\(String(transactionsLogs!.transactionSignature ?? ""))"
            
            let query = "select * from TRANSACTIONS_LOGS order by id;"
            let response = try db.prepare(query).map({(event) -> TransactionsLogsEntityModel in
                debugPrint(event)
                let mId = Int(event[0] as? Int64 ?? 0)
                let mSenderAccountId = event[1] as? Int64 ?? 0
                let mReceiverAccountId = event[2] as? Int64 ?? 0
                let mType = event[3] as? String ?? ""
                let mTime = event[4] as? String ?? ""
                let mContent = event[5] as? String ?? ""
                let mCashEnc = event[6] as? String ?? ""
                let mRefId = event[7] as? String ?? ""
                let mTransactionSignature = event[8] as? String ?? ""
                let mPreviousHash = event[9] as? String ?? ""
                
                return TransactionsLogsEntityModel(id: mId, senderAccountId: mSenderAccountId, receiverAccountId: mReceiverAccountId, type: mType, time: mTime, content: mContent, cashEnc: mCashEnc,refId: mRefId, transactionSignature: mTransactionSignature, previousHash: mPreviousHash)
            })
            if response.count > 0 {
                return response
            }
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    
    func getListTransactions(db : Connection) -> [TransactionHistoyEntityModel]?{
        /*do{
            let response = try db.prepare("SELECT type,* FROM TRANSACTIONS_LOGS").map({(event) -> TransactionsLogsEntityModel in
              //let mType = event[3] as! String
                
                
                let mType = event[4] as! String
                let mReceiverAccountId = "aaaaaaaa"//event[3] as! String
                let mAmount = "1000000"//event[7] as! String
                let mTime = "10-10-2019"//event[5] as! String
                return TransactionsLogsEntityModel()
            })
            
            
        }catch {
            debugPrint(error)
        }*/
        
        do{
            let response = try db.prepare("SELECT IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TRAN.senderAccountId), '') as Sender, TRAN.senderAccountId,IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TRAN.receiverAccountId), '') as Receiver, TRAN.receiverAccountId, TRAN.type, TRAN.time, TRAN.content, TRAN.transactionSignature,CASE WHEN TRAN.Type='DC' THEN (SELECT SUM(CASH_LOGS.value) FROM CASH_LOGS WHERE CASH_LOGS.transactionSignature = TRAN.transactionSignature AND CASH_LOGS.type=true) ELSE (SELECT SUM(CASH_LOGS.value) FROM CASH_LOGS WHERE CASH_LOGS.transactionSignature = TRAN.transactionSignature) END as Amount , CASE WHEN (SELECT COUNT(TIMEOUT.transactionSignature) FROM TRANSACTIONS_TIMEOUT as TIMEOUT WHERE TIMEOUT.transactionSignature=TRAN.transactionSignature AND TIMEOUT.status=1) >0 THEN 0 ELSE 1 END as Status,IFNULL((SELECT CONTACTS.phone FROM CONTACTS WHERE CONTACTS.walletId = TRAN.senderAccountId), '') as SenderPhone,IFNULL((SELECT CONTACTS.phone FROM CONTACTS WHERE CONTACTS.walletId = TRAN.receiverAccountId), '') as ReceiverPhone FROM TRANSACTIONS_LOGS as TRAN ORDER BY TRAN.time DESC;").map({(event) -> TransactionHistoyEntityModel in
                
                debugPrint(event)
                let mType = event[4] as? String ?? ""
                let mReceiverAccountId = event[3] as? Int64 ?? 0
                let mAmount = event[8] as? Int64 ?? 0
                let mStatus = event[9] as? Int64 ?? 0
                let mTime = event[5] as? String ?? ""
                let mTransactionId = event[7] as? String ?? ""
                let index = mTime.index(mTime.startIndex, offsetBy: 8)
                let mSenderName = event[0] as? String ?? ""
                let mReceiverName = event[2] as? String ?? ""
                let mSenderAccountId = event[1] as? Int64 ?? 0
                let mSenderPhone = event[10] as? String ?? ""
                let mReceiverPhone = event[11] as? String ?? ""
                
                return TransactionHistoyEntityModel(transactionId : mTransactionId,receiverName: mReceiverName ,senderName: mSenderName,receiverPhone: mReceiverPhone,senderPhone: mSenderPhone,transactionType: mType, receiverId: String(mReceiverAccountId),senderId: String(mSenderAccountId), transactionAmount: String(mAmount).toMoney(), transactionStatus: String(mStatus), transactionDate: String(mTime[..<index]),transactionDateTime: mTime)
            })
            
            if response.count > 0 {
                return response
            }
            
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    
    func searchView(db : Connection, key  : String) -> [TransactionHistoyEntityModel]?{
        do{
            let response = try db.prepare("SELECT IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TRAN.senderAccountId), '') as Sender, TRAN.senderAccountId,IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TRAN.receiverAccountId), '') as Receiver, TRAN.receiverAccountId, TRAN.type, TRAN.time, TRAN.content ,TRAN.transactionSignature,CASE WHEN TRAN.Type='DC' THEN (SELECT SUM(CASH_LOGS.value) FROM CASH_LOGS WHERE CASH_LOGS.transactionSignature = TRAN.transactionSignature AND CASH_LOGS.type=true) ELSE (SELECT SUM(CASH_LOGS.value) FROM CASH_LOGS WHERE CASH_LOGS.transactionSignature = TRAN.transactionSignature) END as Amount, CASE WHEN (SELECT COUNT(TIMEOUT.transactionSignature) FROM TRANSACTIONS_TIMEOUT as TIMEOUT WHERE TIMEOUT.transactionSignature=TRAN.transactionSignature AND TIMEOUT.status=1) >0 THEN 0 ELSE 1 END as Status,IFNULL((SELECT CONTACTS.phone FROM CONTACTS WHERE CONTACTS.walletId = TRAN.senderAccountId), '') as SenderPhone,IFNULL((SELECT CONTACTS.phone FROM CONTACTS WHERE CONTACTS.walletId = TRAN.receiverAccountId), '') as ReceiverPhone FROM TRANSACTIONS_LOGS as TRAN WHERE Sender like '%\(key)%' OR Receiver like '%\(key)%' OR TRAN.receiverAccountId like '%\(key)%' OR TRAN.receiverAccountId like '%\(key)%' OR TRAN.content like '%\(key)%'  ORDER BY TRAN.time DESC;").map({(event) -> TransactionHistoyEntityModel in
                let mType = event[4] as? String ?? ""
                let mReceiverAccountId = event[3] as? Int64 ?? 0
                let mAmount = event[8] as? Int64 ?? 0
                let mStatus = event[9] as? Int64 ?? 0
                let mTime = event[5] as? String ?? ""
                let mTransactionId = event[7] as? String ?? ""
                let index = mTime.index(mTime.startIndex, offsetBy: 8)
                let mSenderName = event[0] as? String ?? ""
                let mReceiverName = event[2] as? String ?? ""
                let mSenderAccountId = event[1] as? Int64 ?? 0
                let mSenderPhone = event[10] as? String ?? ""
                let mReceiverPhone = event[11] as? String ?? ""
                
                return TransactionHistoyEntityModel(transactionId : mTransactionId,receiverName: mReceiverName ,senderName: mSenderName,receiverPhone: mReceiverPhone,senderPhone: mSenderPhone,transactionType: mType, receiverId: String(mReceiverAccountId),senderId: String(mSenderAccountId), transactionAmount: String(mAmount).toMoney(), transactionStatus: String(mStatus), transactionDate: String(mTime[..<index]),transactionDateTime: mTime)
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func filterView(db : Connection, transType : String, transDate: String, transStatus: String) -> [TransactionHistoyEntityModel]?{
        do{
            var strQuery = "SELECT IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TRAN.senderAccountId), '') as Sender, TRAN.senderAccountId,IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TRAN.receiverAccountId), '') as Receiver, TRAN.receiverAccountId, TRAN.type, TRAN.time, TRAN.content, TRAN.transactionSignature, CASE WHEN TRAN.Type='DC' THEN (SELECT SUM(CASH_LOGS.value) FROM CASH_LOGS WHERE CASH_LOGS.transactionSignature = TRAN.transactionSignature AND CASH_LOGS.type=true) ELSE (SELECT SUM(CASH_LOGS.value) FROM CASH_LOGS WHERE CASH_LOGS.transactionSignature = TRAN.transactionSignature) END as Amount , CASE WHEN (SELECT COUNT(TIMEOUT.transactionSignature) FROM TRANSACTIONS_TIMEOUT as TIMEOUT WHERE TIMEOUT.transactionSignature=TRAN.transactionSignature AND TIMEOUT.status=1) >0 THEN 0 ELSE 1 END as Status,IFNULL((SELECT CONTACTS.phone FROM CONTACTS WHERE CONTACTS.walletId = TRAN.senderAccountId), '') as SenderPhone,IFNULL((SELECT CONTACTS.phone FROM CONTACTS WHERE CONTACTS.walletId = TRAN.receiverAccountId), '') as ReceiverPhone FROM TRANSACTIONS_LOGS as TRAN WHERE 1=1 "
            if !transType.isEmpty{
                strQuery = strQuery + " AND TRAN.Type='\(transType)' "
            }
            
            if !transDate.isEmpty{
                strQuery = strQuery + " AND substr(TRAN.time,1,6) = '\(transDate)' "
            }
            
            if !transStatus.isEmpty{
                strQuery = strQuery + " AND Status = \(transStatus)"
            }
            
            strQuery = strQuery + " ORDER BY TRAN.time DESC;"
          
            let response = try db.prepare(strQuery).map({(event) -> TransactionHistoyEntityModel in
                let mType = event[4] as? String ?? ""
                let mReceiverAccountId = event[3] as? Int64 ?? 0
                let mAmount = event[8] as? Int64 ?? 0
                let mStatus = event[9] as? Int64 ?? 0
                let mTime = event[5] as? String ?? ""
                let mTransactionId = event[7] as? String ?? ""
                let index = mTime.index(mTime.startIndex, offsetBy: 8)
                let mSenderName = event[0] as? String ?? ""
                let mReceiverName = event[2] as? String ?? ""
                let mSenderAccountId = event[1] as? Int64 ?? 0
                let mSenderPhone = event[10] as? String ?? ""
                let mReceiverPhone = event[11] as? String ?? ""
                
                return TransactionHistoyEntityModel(transactionId : mTransactionId,receiverName: mReceiverName ,senderName: mSenderName,receiverPhone: mReceiverPhone,senderPhone: mSenderPhone,transactionType: mType, receiverId: String(mReceiverAccountId),senderId: String(mSenderAccountId), transactionAmount: String(mAmount).toMoney(), transactionStatus: String(mStatus), transactionDate: String(mTime[..<index]),transactionDateTime: mTime)
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func search(db : Connection){
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature.like("%344"))   // WHERE "name" IS NOT NULL
                .limit(10)
            let response = try db.prepare(query).map({(event) -> TransactionsLogsEntityModel in
                debugPrint(event[id])
                return TransactionsLogsEntityModel()
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func search(db : Connection, key: String){
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature.like("%\(key)%"))   // WHERE "name" IS NOT NULL
                .limit(10)
            let response = try db.prepare(query).map({(event) -> TransactionsLogsEntityModel in
                debugPrint(event[id])
                return TransactionsLogsEntityModel()
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func getObject(db : Connection,key : String) -> TransactionsLogsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> TransactionsLogsEntityModel in
                return TransactionsLogsEntityModel(id: event[id], senderAccountId: event[senderAccountId], receiverAccountId: event[receiverAccountId], type: event[type], time: event[time], content: event[content], cashEnc: event[cashEnc], refId : event[refId],transactionSignature: event[transactionSignature], previousHash: event[previousHash])
            })
            if response.count > 0{
                return response[0]
            }
            return nil
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func delete(db : Connection, idValue : Int){
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(id == idValue)   // WHERE "name" IS NOT NULL
            try db.run(query.delete())
            debugPrint("Deleted successfully")
        }catch {
            debugPrint(error)
        }
    }
    
    func delete(db : Connection){
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
            try db.run(query.delete())
            debugPrint("Deleted successfully")
        }catch {
            debugPrint(error)
        }
    }
    
    func update(db : Connection,mId : Int , mPreviousHash : String){
        let request = table.filter(id == mId).update(previousHash <- mPreviousHash)
        do{
            try db.run(request)
            debugPrint("Updated successfully")
        }catch {
            debugPrint(error)
        }
    }
    
    /*
     - get latest row
     */
    func getLatestRow(db : Connection) -> TransactionsLogsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .order(id.desc)
                .limit(1)
            let response = try db.prepare(query).map({(event) -> TransactionsLogsEntityModel in
                debugPrint(event[transactionSignature])
                return TransactionsLogsEntityModel(id: event[id], senderAccountId: event[senderAccountId], receiverAccountId: event[receiverAccountId], type: event[type], time: event[time], content: event[content], cashEnc: event[cashEnc],refId:event[refId], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
            })
            if response.count > 0{
                return response[0]
            }
            return nil
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    /*
     - get fist row
     */
    func getFirstRow(db : Connection) -> TransactionsLogsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .order(id.asc)
                .limit(1)
            let response = try db.prepare(query).map({(event) -> TransactionsLogsEntityModel in
               return TransactionsLogsEntityModel(id: event[id], senderAccountId: event[senderAccountId], receiverAccountId: event[receiverAccountId], type: event[type], time: event[time], content: event[content], cashEnc: event[cashEnc],refId: event[refId], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
            })
            if response.count > 0{
                return response[0]
            }
            return nil
        }catch {
            debugPrint(error)
        }
        return nil
    }
}
