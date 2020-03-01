//
//  DecisionsDiary.swift
//  ecash
//
//  Created by phong070 on 9/21/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class DecisionsDiaryEntity {
    static let instance = DecisionsDiaryEntity()
    private let table = Table("DECISIONS_DIARY")
    var decisionNo =  Expression<String>("decisionNo")
    var accountPublicKeyAlias =   Expression<String>("accountPublicKeyAlias")
    var accountPublicKeyValue =   Expression<String>("accountPublicKeyValue")
    var treasurePublicKeyAlias =   Expression<String>("treasurePublicKeyAlias")
    var treasurePublicKeyValue =   Expression<String>("treasurePublicKeyValue")
    var systemDate =   Expression<Int64>("systemDate")
    
    private init() {

    }

    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(decisionNo,primaryKey: true)
                t.column(accountPublicKeyAlias)
                t.column(accountPublicKeyValue)
                t.column(treasurePublicKeyAlias)
                t.column(treasurePublicKeyValue)
                t.column(systemDate)
            })
        }catch {
            debugPrint(error)
        }
    }

    func insert(db : Connection, data : DecisionsDiaryEntityModel) -> Bool{
        //let request = table.insert()
        let request = table.insert(decisionNo <- data.decisionNo!,
                                   accountPublicKeyAlias <-  data.accountPublicKeyAlias!,
                                   accountPublicKeyValue <- data.accountPublicKeyValue!,
                                   treasurePublicKeyAlias <- data.treasurePublicKeyAlias!,
                                   treasurePublicKeyValue <- data.treasurePublicKeyValue!,
                                   systemDate <- data.systemDate!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted successfully...decisions diary")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }

    func getObject(db : Connection,key : String) -> DecisionsDiaryEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(decisionNo == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> DecisionsDiaryEntityModel in
                return DecisionsDiaryEntityModel(decisionNo: event[decisionNo], accountPublicKeyAlias: event[accountPublicKeyAlias], accountPublicKeyValue: event[accountPublicKeyValue], treasurePublicKeyAlias: event[treasurePublicKeyAlias], treasurePublicKeyValue: event[treasurePublicKeyValue], systemDate:   event[systemDate])
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
    
    func getList(db : Connection) -> [DecisionsDiaryEntityModel]?{
        do{
            
            let response = try db.prepare(table).map({(event) -> DecisionsDiaryEntityModel in
                return DecisionsDiaryEntityModel(decisionNo: event[decisionNo], accountPublicKeyAlias: event[accountPublicKeyAlias], accountPublicKeyValue: event[accountPublicKeyValue], treasurePublicKeyAlias: event[treasurePublicKeyAlias], treasurePublicKeyValue: event[treasurePublicKeyValue], systemDate:  event[systemDate])
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
                .filter(decisionNo == key)   // WHERE "name" IS NOT NULL
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
