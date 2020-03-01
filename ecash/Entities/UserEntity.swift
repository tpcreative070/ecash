//
//  UserEntity.swift
//  ecash
//
//  Created by phong070 on 8/15/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class UserEntity {
    static let instance = UserEntity()
    
    private let table = Table("users")
    private let id = Expression<Int64>("id")
    private let name = Expression<String?>("name")
    private let email = Expression<String>("email")
    
    private init(){
        
    }
    
    func createTable(db : Connection){
        do{
            try db.run(table.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            })
        }catch {
            debugPrint(error)
        }
    }
    
    func insert(db : Connection){
        do{
            let insert = table.insert(name <- "Alice", email <- "alice@mac1236.com")
            try db.run(insert)
            for index in try db.prepare(table) {
                debugPrint("id: \(index[id]), name: \(String(describing: index[name])), email: \(index[email])")
            }
        }catch {
            debugPrint(error)
        }
    }
}
