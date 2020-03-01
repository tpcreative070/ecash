//
//  CashValueEntity.swift
//  ecash
//
//  Created by phong070 on 12/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import SQLite
class CashValuesEntity {
    static let instance = CashValuesEntity()
    private let table = Table("CASH_VALUES")
    var value = Expression<Int64>("value")
   
    func createTable(db : Connection){
              do{
                  try db.run(table.create { t in
                      t.column(value)
                  })
              }catch {
                  debugPrint(error)
              }
          }
          
    func insert(db : Connection, data : CashValuesEntityModel){
           let request = table.insert(value <- data.value!)
              do{
                  //let insert = try table.insert(data)
                  try db.run(request)
                  debugPrint("Inserted notification history successfully")
              }catch {
                  debugPrint("\(error)")
              }
    }

    func getList(db : Connection) -> [CashValuesEntityModel]?{
        do{
            let response = try db.prepare(table).map({(event) -> CashValuesEntityModel in
                return CashValuesEntityModel(value: event[value])
            })
            return response
            }catch {
                debugPrint(error)
        }
        return nil
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
