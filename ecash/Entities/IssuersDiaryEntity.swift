//
//  IssuersDiaryEntity.swift
//  ecash
//
//  Created by phong070 on 10/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

//CREATE TABLE "ISSUERS_DIARY" (
//    "issuerCode"    BIGINT,
//    "publicKeyAlias"    TEXT,
//    "publicKeyValue"    TEXT,
//    "systemDate"    DATETIME
//);

import SQLite
class IssuersDiaryEntity {
    static let instance = IssuersDiaryEntity()
    private let table = Table("ISSUERS_DIARY")
    
    var issuerCode =  Expression<String>("issuerCode")
    var publicKeyAlias =   Expression<String>("publicKeyAlias")
    var publicKeyValue =   Expression<String>("publicKeyValue")
    var systemDate =   Expression<Int64>("systemDate")
    
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(issuerCode)
                t.column(publicKeyAlias)
                t.column(publicKeyValue)
                t.column(systemDate)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : IssuersDiaryEntityModel) -> Bool{
        //let request = table.insert()
        let request = table.insert(issuerCode <- data.issuerCode!,
                                   publicKeyAlias <-  data.publicKeyAlias!,
                                   publicKeyValue <- data.publicKeyValue!,
                                   systemDate <- data.systemDate!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted successfully...issuers diary")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }
    
    func getObject(db : Connection,key : String) -> IssuersDiaryEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(issuerCode == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> IssuersDiaryEntityModel in
                return IssuersDiaryEntityModel(issuerCode: event[issuerCode], publicKeyAlias: event[publicKeyAlias], publicKeyValue: event[publicKeyValue], systemDate: event[systemDate])
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
    
    func getList(db : Connection) -> [IssuersDiaryEntityModel]?{
        do{
            
            let response = try db.prepare(table).map({(event) -> IssuersDiaryEntityModel in
                return IssuersDiaryEntityModel(issuerCode: event[issuerCode], publicKeyAlias: event[publicKeyAlias], publicKeyValue: event[publicKeyValue], systemDate: event[systemDate])
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
                .filter(issuerCode == key)   // WHERE "name" IS NOT NULL
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
