//
//  NotificationHistoryEntity.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class NotificationHistoryEntity {
    static let instance = NotificationHistoryEntity()
    private let table = Table("NOTIFICATION_HISTORY")
    private let id = Expression<Int64>("id")
    private let title    = Expression<String>("title")
    private let message = Expression<String>("message")
    private let createdDate = Expression<String>("createdDate")
    private let isView = Expression<Bool>("isView")
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(id,primaryKey: .autoincrement)
                t.column(title)
                t.column(message)
                t.column(createdDate)
                t.column(isView)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : NotificationHistoryEntityModel){
        let request = table.insert(title <- data.title!,message <- data.message!,createdDate <- data.createdDate!,isView <- data.isView!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted notification history successfully")
        }catch {
            debugPrint("\(error)")
        }
    }

    func getList(db : Connection) -> [NotificationHistoryEntityModel]?{
         do{
             let response = try db.prepare(table).map({(event) -> NotificationHistoryEntityModel in
                return NotificationHistoryEntityModel(id: event[id], title: event[title],message: event[message],createdDate: event[createdDate],isView: event[isView])
             })
             return response
         }catch {
             debugPrint(error)
         }
         return nil
    }
    
    func getListAvailable(db : Connection) -> [NotificationHistoryEntityModel]?{
          do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                          .filter(isView == false)
              let response = try db.prepare(query).map({(event) -> NotificationHistoryEntityModel in
                  return NotificationHistoryEntityModel(id: event[id], title: event[title], message: event[message], createdDate: event[createdDate], isView: event[isView])
              })
              if response.count > 0 {
                  return response
              }
          }catch {
              debugPrint(error)
          }
          return nil
    }
    
    func update(db : Connection,mId : Int64){
           let request = table.filter(id == mId).update(isView <- true)
           do{
               try db.run(request)
               debugPrint("Updated successfully")
           }catch {
               debugPrint(error)
           }
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
}
