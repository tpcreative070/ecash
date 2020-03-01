//
//  SocketReplyEntities.swift
//  ecash
//
//  Created by phong070 on 10/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class SocketReplyEntities {
    static let instance = SocketReplyEntities()
    private let table = Table("SOCKET_REPLY")
    private let id = Expression<Int>("id")
    private let replyId    = Expression<String>("replyId")
    private init() {
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(id,primaryKey: .autoincrement)
                t.column(replyId)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection, data : SocketReplyEntityModel) -> Bool{
    
        let request = table.insert(replyId <- data.replyId!)
        do{
            //let insert = try table.insert(data)
            try db.run(request)
            debugPrint("Inserted socket reply logs successfully")
            return true
        }catch {
            debugPrint("\(error) \(data.replyId ?? "")")
        }
        return false
    }

    func getObject(db : Connection,key : String) -> SocketReplyEntityModel?{
        do{
            let query = table.select(table[*])  // SELECT "email" FROM "users"
                .filter(replyId == key)    // WHERE "name" IS NOT NULL
                .limit(1)
            let response = try db.prepare(query).map({(event) -> SocketReplyEntityModel in
                return SocketReplyEntityModel(replyId: event[replyId])
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
