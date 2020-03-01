//
//  TransactionQREntity.swift
//  ecash
//
//  Created by phong070 on 9/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class TransactionQREntity {
    static let instance = TransactionQREntity()
    private let table = Table("TRANSACTION_QR")
    var transactionSignature =   Expression<String>("transactionSignature")
    var sequence =   Expression<Int>("sequence")
    var total =   Expression<Int>("total")
    var value =   Expression<String>("value")
    
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(transactionSignature)
                t.column(sequence)
                t.column(total)
                t.column(value)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : TransactionQREntityModel) -> Bool{
        do{
            let insert = try table.insert(data)
            try db.run(insert)
            debugPrint("Inserted successfully...TransactionQREntityModel")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }
    
    func getObject(db : Connection,key : String) -> TransactionQREntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> TransactionQREntityModel in
                return TransactionQREntityModel(transactionSignature: event[transactionSignature], sequence: event[sequence], total: event[total], value: event[value])
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
    
    func getList(db : Connection) -> [TransactionQREntityModel]?{
        do{
            
            let response = try db.prepare(table).map({(event) -> TransactionQREntityModel in
                return TransactionQREntityModel(transactionSignature: event[transactionSignature], sequence: event[sequence], total: event[total], value: event[value])
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func getList(db : Connection, key : String) -> [TransactionQREntityModel]?{
        do{
            debugPrint(key)
            let query = table.select(table[*])
                .filter(transactionSignature == key)
            let response = try db.prepare(query).map({(event) -> TransactionQREntityModel in
                return TransactionQREntityModel(transactionSignature: event[transactionSignature], sequence: event[sequence], total: event[total], value: event[value])
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func delete(db : Connection, key : String){
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(transactionSignature == key)   // WHERE "name" IS NOT NULL
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
    
    func update(db : Connection,valueUpdate : String , valueChange : String){
        let request = table.filter(transactionSignature == valueUpdate).update(transactionSignature <- valueChange)
        do{
            try db.run(request)
            debugPrint("Updated successfully")
        }catch {
            debugPrint(error)
        }
    }
    
    func update(db : Connection,data : TransactionQREntityModel){
        let request = table.filter(transactionSignature == data.transactionSignature ?? "").filter(sequence == data.sequence ?? 0)
            .update(value <- data.value ?? "")
        do{
            try db.run(request)
            debugPrint("Updated successfully")
        }catch {
            debugPrint(error)
        }
    }
}
