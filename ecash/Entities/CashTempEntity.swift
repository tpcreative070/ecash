//
//  CashLuckyEntity.swift
//  ecash
//
//  Created by phong070 on 12/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class CashTempEntity {
    static let instance = CashTempEntity()
    private let table = Table("CASH_TEMP")
    var id = Expression<Int64>("id")
    var senderAccountId = Expression<Int64>("senderAccountId")
    var content = Expression<String>("content")
    var transactionSignature = Expression<String>("transactionSignature")
    var receiveDate = Expression<String>("receiveDate")
    var status = Expression<Bool>("status")
    
    func createTable(db : Connection){
           do{
               try db.run(table.create { t in
                   t.column(id,primaryKey: .autoincrement)
                   t.column(senderAccountId)
                   t.column(content)
                   t.column(transactionSignature)
                   t.column(receiveDate)
                   t.column(status)
               })
           }catch {
               debugPrint(error)
           }
       }
       
    func insert(db : Connection, data : CashTempEntityModel){
        let request = table.insert(senderAccountId <- data.senderAccountId!,content <- data.content!,transactionSignature <- data.transactionSignature!,receiveDate <- data.receiveDate!, status <- data.status!)
           do{
               //let insert = try table.insert(data)
               try db.run(request)
               debugPrint("Inserted CashTempEntity successfully")
           }catch {
               debugPrint("\(error)")
           }
    }
    
    func getObject(db : Connection,key : String) -> CashTempEntityModel?{
          do{
              let query = table.select(table[*])  // SELECT "email" FROM "users"
                  .filter(transactionSignature == key)    // WHERE "name" IS NOT NULL
                  .limit(1)
              let response = try db.prepare(query).map({(event) -> CashTempEntityModel in
                   return CashTempEntityModel(id: event[id], senderAccountId: event[senderAccountId], content: event[content], transactionSignature: event[transactionSignature], receiveDate: event[receiveDate], status: event[status],fullName: "")
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

    func getList(db : Connection) -> [CashTempEntityModel]?{
            do{
                let response = try db.prepare("SELECT IFNULL((SELECT CONTACTS.fullName FROM CONTACTS WHERE CONTACTS.walletId = TEMP.senderAccountId), '') as Sender, TEMP.id, TEMP.senderAccountId, TEMP.content, TEMP.transactionSignature, TEMP.receiveDate, TEMP.status from CASH_TEMP as TEMP;").map({(event) -> CashTempEntityModel in
                             let mFullName = event[0] as? String ?? ""
                             let mId = event[1] as? Int64 ?? 0
                             let mSenderAccountId = event[2] as? Int64 ?? 0
                             let mContent = event[3] as? String ?? ""
                             let mTransactionSignature = event[4] as? String ?? ""
                             let mReceiveDate = event[5] as? String ?? ""
                             let mStatus = Int(event[6] as? Int64 ?? 0)
                           
                    return CashTempEntityModel(id: mId, senderAccountId: mSenderAccountId, content: mContent, transactionSignature: mTransactionSignature, receiveDate: mReceiveDate, status: mStatus.boolValue,fullName: mFullName)
                         })
                         if response.count > 0 {
                             return response
                         }
            }catch {
                debugPrint(error)
            }
            return nil
    }
    
    func getCountLixi(db : Connection) ->Int{
        do{
            let response = try db.prepare("select count(status) AS countLixi from CASH_TEMP where status=0;").map({(event) -> Int in
                    let mCountLixi = event[0] as? Int64 ?? 0
                    debugPrint("Count lixi \(mCountLixi)")
                    return Int(mCountLixi
                )
            })
            Utils.logMessage(object: response)
            if response.count > 0 {
                return response[0]
            }
        }catch {
             debugPrint(error)
        }
        return 0
    }
       
       func delete(db : Connection, key : Int64){
           do{
               let query = table.select(table[*])  // SELECT "email" FROM "users"
                   .filter(id == key)   // WHERE "name" IS NOT NULL
               try db.run(query.delete())
               debugPrint("Deleted successfully")
           }catch {
               debugPrint(error)
           }
       }
    
       func update(db : Connection,data : CashTempEntityModel){
           let request = table.filter(transactionSignature == data.transactionSignature ?? "")
            .update(status <- true,receiveDate <- data.receiveDate!)
           do{
               try db.run(request)
               debugPrint("Updated successfully")
           }catch {
               debugPrint(error)
           }
       }
    
}
 
