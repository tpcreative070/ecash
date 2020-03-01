//
//  ContactsEntity.swift
//  ecash
//
//  Created by phong070 on 9/18/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class ContactsEntity {
    
    static let instance = ContactsEntity()
    private let table = Table("CONTACTS")
    private let walletId = Expression<Int64>("walletId")
    private let phone = Expression<String>("phone")
    private let publicKeyValue = Expression<String>("publicKeyValue")
    private let fullName  = Expression<String>("fullName")
    private let email  = Expression<String>("email")
    private let address  = Expression<String>("address")
    private let mobileInfo  = Expression<String>("mobileInfo")
    private let status  = Expression<Int>("status")
    private let created  = Expression<Int64>("created")
    private let modified  = Expression<Int64>("modified")
    private let destroyed  = Expression<Int64>("destroyed")
  
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(walletId,primaryKey: true)
                t.column(phone)
                t.column(publicKeyValue)
                t.column(fullName)
                t.column(email)
                t.column(address)
                t.column(mobileInfo)
                t.column(status)
                t.column(created)
                t.column(modified)
                t.column(destroyed)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : ContactsEntityModel) -> Bool{
        let request = table.insert(walletId <- data.walletId!,
                                   phone <-  data.phone!,
                                   publicKeyValue <- data.publicKeyValue!,
                                   fullName <- data.fullName!,
                                   email <- data.email!,
                                   address <- data.address!,
                                   mobileInfo <- data.mobileInfo!,
                                   status <- data.status!,
                                   created <- data.created!,
                                   modified <- data.modified!,
                                   destroyed <- data.destroyed!)
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
    
    func getList(db : Connection) -> [ContactsEntityModel]?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(status == true.intValue)
            let response = try db.prepare(query).map({(event) -> ContactsEntityModel in
                return ContactsEntityModel(walletId: event[walletId], phone: event[phone],publicKeyValue: event[publicKeyValue], fullName: event[fullName], email: event[email], address: event[address], mobileInfo: event[mobileInfo], status: event[status], created: event[created], modified: event[modified], destroyed: event[destroyed])
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func search(db : Connection, key  : String) -> [ContactsEntityModel]?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(fullName.like("%\(key)%"))
                .filter(status == true.intValue)
            let response = try db.prepare(query).map({(event) -> ContactsEntityModel in
                return ContactsEntityModel(walletId: event[walletId], phone: event[phone],publicKeyValue: event[publicKeyValue], fullName: event[fullName], email: event[email], address: event[address], mobileInfo: event[mobileInfo], status: event[status], created: event[created], modified: event[modified], destroyed: event[destroyed])
            })
            return response
        }catch {
            debugPrint(error)
        }
        return nil
    }
    
    func getObject(db : Connection,key : Int64) -> ContactsEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(walletId == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> ContactsEntityModel in
                 return ContactsEntityModel(walletId: event[walletId], phone: event[phone],publicKeyValue: event[publicKeyValue], fullName: event[fullName], email: event[email], address: event[address], mobileInfo: event[mobileInfo], status: event[status], created: event[created], modified: event[modified], destroyed: event[destroyed])
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
    
    func delete(db : Connection, value : Int64) ->Bool{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(walletId == value)   // WHERE "name" IS NOT NULL
            try db.run(query.delete())
            debugPrint("Deleted successfully")
            return true
        }catch {
            debugPrint(error)
        }
        return false
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
    
    func update(db : Connection,mWalletId : Int64 , value : Int64){
        let request = table.filter(walletId == mWalletId).update(created <- value)
        do{
            try db.run(request)
            debugPrint("Updated successfully")
        }catch {
            debugPrint(error)
        }
    }
    
    func update(db : Connection,mWalletId : Int64 , value : String) -> Bool{
        debugPrint("full name \(value)")
        let request = table.filter(walletId == mWalletId).update(fullName <- value, modified <- Int64(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)) ?? 0)
        do{
            try db.run(request)
            debugPrint("Updated successfully")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }
    
    func update(db : Connection,mWalletId : Int64, value : Bool) -> Bool{
        let request = table.filter(walletId == mWalletId).update(status <- value.intValue , modified <- Int64(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)) ?? 0, destroyed <- Int64(TimeHelper.getString(time: Date(), dateFormat: TimeHelper.StandardSaveContact)) ?? 0)
        do{
            try db.run(request)
            debugPrint("Updated successfully")
            return true
        }catch {
            debugPrint(error)
        }
        return false
    }
}
