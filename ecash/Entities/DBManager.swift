//
//  DbManager.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
import RealmSwift

class DbManager {
  private var database: Realm
  static let sharedInstance = DbManager()
  
  private init() {
    let config = Realm.Configuration(
      // Set the new schema version. This must be greater than the previously used
      // version (if you've never set a schema version before, the version is 0).
      schemaVersion: 1,
      // Set the block which will be called automatically when opening a Realm with
      // a schema version lower than the one set above
      migrationBlock: { migration, oldSchemaVersion in
        if oldSchemaVersion < 1 {
          
        }
    })
    database = try! Realm(configuration: config)
  }
  
  /**
   This function handle get data with any data model
   - Returns: Resulst<T>
  */
  func getData<T: Object>(type: T.Type) -> Results<T>? {
    let results = database.objects(type)
    return results
  }
  
  /**
   This function handle get data with any data model with filter options
   - Returns: Resulst<T>
   */
  func getDataByKey<T: Object>(data: T.Type, filter: String) -> Results<T> {
    let results = database.objects(data).filter(filter)
    return results
  }
    
  /**
  This function handle get data with any data model with filter muitple options
  - Returns: Resulst<T>
  */
  func getDataByKey<T: Object>(data: T.Type, filter: NSPredicate) -> Results<T> {
    let results = database.objects(data).filter(filter)
    return results
  }
  
  /**
   This function handle add data with any data model
   */
  func addData<T: Object>(data: T) {
    try! database.write {
       self.database.add(data, update: .all)
    }
  }
  
  /**
   This function handle delete one record by Object
   */
  func deleteData<T: Object>(data: T) {
    try! database.write {
      database.delete(data)
    }
  }
  
  /**
   This function handle get data with any data model with filter options
   - Returns: Resulst<T>
   */
  func inArray<T: Object>(data: T.Type, filter: String, inData: [Int]) -> Results<T> {
    let results = database.objects(data).filter(filter, inData)
    return results
  }  
}
