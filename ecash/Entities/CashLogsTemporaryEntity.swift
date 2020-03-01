//
//  CashLogsTemporaryEntity.swift
//  ecash
//
//  Created by phong070 on 9/18/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class CashLogsTemporaryEntity {
    static let instance = CashLogsTemporaryEntity()
    private let table = Table("CASH_LOGS_TEMPORARY")
    private let id = Expression<Int>("id")
    private let countryCode = Expression<String>("countryCode")
    private let issuerCode  = Expression<String>("issuerCode")
    private let decisionNo = Expression<String>("decisionNo")
    private let serial  = Expression<Int64>("serial")
    private let value  = Expression<Int64>("value")
    private let actived  = Expression<String>("actived")
    private let expired  = Expression<String>("expired")
    private let accountSignature  = Expression<String>("accountSignature")
    private let cycle  = Expression<Int>("cycle")
    private let treasureSignature  = Expression<String>("treasureSignature")
    // Input/output
    private let type  = Expression<Bool>("type")
    private let transactionSignature  = Expression<String>("transactionSignature")
    private let previousHash  = Expression<String>("previousHash")
    
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(id,primaryKey: .autoincrement)
                t.column(countryCode)
                t.column(issuerCode)
                t.column(decisionNo)
                t.column(serial)
                t.column(value)
                t.column(actived)
                t.column(expired)
                t.column(accountSignature)
                t.column(cycle)
                t.column(treasureSignature)
                t.column(type)
                t.column(transactionSignature)
                t.column(previousHash)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : CashLogsEntityModel) -> Bool{
        debugPrint("transactionSignature...... \(data.transactionSignature ?? "")")
        let request = table.insert(countryCode <- data.countryCode!,
                                   issuerCode <-  data.issuerCode!,
                                   decisionNo <- data.decisionNo!,
                                   serial <- data.serial!,
                                   value <- data.value!,
                                   actived <- data.actived!,
                                   expired <- data.expired!,
                                   accountSignature <- data.accountSignature!,
                                   cycle <- data.cycle!,
                                   treasureSignature <- data.treasureSignature!,
                                   type <- data.type!,
                                   transactionSignature <- data.transactionSignature!,
                                   previousHash <- data.previousHash!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted successfully...temporary")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }
    
    func allowInput(db : Connection,mSerial : Int64) -> Bool{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(serial == mSerial)    // WHERE "name" IS NOT NULL
            let response = try db.prepare(query).map({(event) -> CashLogsEntityModel in
                return CashLogsEntityModel(id: event[id], countryCode: event[countryCode], issuerCode: event[issuerCode], decisionNo: event[decisionNo], serial: event[serial], value: event[value], actived: event[actived], expired: event[expired], accountSignature: event[accountSignature], cycle: event[cycle], treasureSignature: event[treasureSignature], type: event[type], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
            })
            if (response.count % 2) > 0{
                return false
            }
            return true
        }catch {
            debugPrint(error)
        }
        return true
    }
    
    func allowOutput(db : Connection,mSerial : Int64) -> Bool{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(serial == mSerial)    // WHERE "name" IS NOT NULL
            let response = try db.prepare(query).map({(event) -> CashLogsEntityModel in
                return CashLogsEntityModel(id: event[id], countryCode: event[countryCode], issuerCode: event[issuerCode], decisionNo: event[decisionNo], serial: event[serial], value: event[value], actived: event[actived], expired: event[expired], accountSignature: event[accountSignature], cycle: event[cycle], treasureSignature: event[treasureSignature], type: event[type], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
            })
            if (response.count % 2) > 0{
                return true
            }
            return false
        }catch {
            debugPrint(error)
        }
        return false
    }
    
    func getList(db : Connection) -> [CashLogsEntityModel]?{
        do{
            let response = try db.prepare(table).map({(event) -> CashLogsEntityModel in
                return CashLogsEntityModel(id: event[id], countryCode: event[countryCode], issuerCode: event[issuerCode], decisionNo: event[decisionNo], serial: event[serial], value: event[value], actived: event[actived], expired: event[expired], accountSignature: event[accountSignature], cycle: event[cycle], treasureSignature: event[treasureSignature], type: event[type], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
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
                .filter(countryCode.like("%344"))   // WHERE "name" IS NOT NULL
                .limit(10)
            let response = try db.prepare(query).map({(event) -> CashLogsEntityModel in
                debugPrint(event[id])
                return CashLogsEntityModel()
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func getObject(db : Connection,key : Int64) -> CashLogsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(serial == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> CashLogsEntityModel in
                return CashLogsEntityModel(id: event[id], countryCode: event[countryCode], issuerCode: event[issuerCode], decisionNo: event[decisionNo], serial: event[serial], value: event[value], actived: event[actived], expired: event[expired], accountSignature: event[accountSignature], cycle: event[cycle], treasureSignature: event[treasureSignature], type: event[type], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
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
    func getLatestRow(db : Connection) -> CashLogsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .order(id.desc)
                .limit(1)
            let response = try db.prepare(query).map({(event) -> CashLogsEntityModel in
                return CashLogsEntityModel(id: event[id], countryCode: event[countryCode], issuerCode: event[issuerCode], decisionNo: event[decisionNo], serial: event[serial], value: event[value], actived: event[actived], expired: event[expired], accountSignature: event[accountSignature], cycle: event[cycle], treasureSignature: event[treasureSignature], type: event[type], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
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
    func getFirstRow(db : Connection) -> CashLogsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .order(id.asc)
                .limit(1)
            let response = try db.prepare(query).map({(event) -> CashLogsEntityModel in
                return CashLogsEntityModel(id: event[id], countryCode: event[countryCode], issuerCode: event[issuerCode], decisionNo: event[decisionNo], serial: event[serial], value: event[value], actived: event[actived], expired: event[expired], accountSignature: event[accountSignature], cycle: event[cycle], treasureSignature: event[treasureSignature], type: event[type], transactionSignature: event[transactionSignature], previousHash: event[previousHash])
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
