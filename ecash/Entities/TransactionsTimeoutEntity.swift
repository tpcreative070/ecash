//
//  TransactionsTimeOut.swift
//  ecash
//
//  Created by phong070 on 11/4/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

//"transactionSignature"    TEXT,
//"transactionTime"    DATETIME,
//"status"    INTEGER,
//"confirmedTime"    DATETIME

import SQLite
class TransactionsTimeoutEntity {
    static let instance = TransactionsTimeoutEntity()
    private let table = Table("TRANSACTIONS_TIMEOUT")
    private let transactionSignature = Expression<String>("transactionSignature")
    private let transactionTime = Expression<Int64>("transactionTime")
    private let status = Expression<Int>("status")
    private let confirmedTime  = Expression<Int64>("confirmedTime")

    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(transactionSignature)
                t.column(transactionTime)
                t.column(status)
                t.column(confirmedTime)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : TransactionsTimeoutEntityModel) -> Bool{
        let request = table.insert(transactionSignature <- data.transactionSignature!,
                                   transactionTime <-  data.transactionTime!,
                                   status <- data.status!,
                                   confirmedTime <- data.confirmedTime!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted contact successfully")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }
    
    func getList(db : Connection) -> [TransactionsTimeoutEntityModel]?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(status == true.intValue)
            let response = try db.prepare(query).map({(event) -> TransactionsTimeoutEntityModel in
                return TransactionsTimeoutEntityModel(transactionSignature: event[transactionSignature], transactionTime: event[transactionTime], status: event[status], confirmedTime: event[confirmedTime])
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    

    func getObject(db : Connection,key : String) -> TransactionsTimeoutEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> TransactionsTimeoutEntityModel in
                return TransactionsTimeoutEntityModel(transactionSignature: event[transactionSignature], transactionTime: event[transactionTime], status: event[status], confirmedTime: event[confirmedTime])
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
    
    func delete(db : Connection, value : String){
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature == value)   // WHERE "name" IS NOT NULL
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

}
