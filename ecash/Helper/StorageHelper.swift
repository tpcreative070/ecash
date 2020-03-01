//
//  StorageHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//


import Foundation
class StorageHelper{
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return AnyObject
   */
  class func getObject(key: String) -> AnyObject? {
    return UserDefaults.standard.object(forKey: key) as AnyObject
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return Int
   */
  class func getInt(key: String) -> Int {
    return UserDefaults.standard.integer(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return Int
   */
  class func getDouble(key: String) -> Double {
    return UserDefaults.standard.double(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return Bool
   */
  class func getBool(key: String) -> Bool {
    return UserDefaults.standard.bool(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key
   return AnyObject
   */
  class func getFloat(key: String) -> Float {
    return UserDefaults.standard.float(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key : string
   return String
   */
  class func getString(key: String) -> String? {
    return UserDefaults.standard.string(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return Data
   */
  class func getData(key: String) -> Data? {
    return UserDefaults.standard.data(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return Array<Any>?
   */
  class func getArray(key: String) -> Array<Any>? {
    return UserDefaults.standard.array(forKey: key)
  }
  
  /**
   get data from nsdefault by key
   - Parameter: key: string
   return Dictionary<String, Any>?
   */
  class func getDictionary(key: String) -> Dictionary<String, Any>? {
    return UserDefaults.standard.dictionary(forKey: key)
  }
  
  
  //-------------------------------------------------------------------------------------------
  // MARK: - Get value with default value
  //-------------------------------------------------------------------------------------------
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue : AnyObject
   return Array<Any>?
   */
  class func getObject(key: String, defaultValue: AnyObject) -> AnyObject? {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getObject(key: key)
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: Int
   return Int
   */
  class func getInt(key: String, defaultValue: Int) -> Int {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getInt(key: key)
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: Bool
   return Bool
   */
  class func getBool(key: String, defaultValue: Bool) -> Bool {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getBool(key: key)
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: Float
   return Float
   */
  class func getFloat(key: String, defaultValue: Float) -> Float {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getFloat(key: key)
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: String
   return String
   */
  class func getString(key: String, defaultValue: String) -> String? {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getString(key: key)
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: NSData
   return Array<Any>?
   */
  class func getData(key: String, defaultValue: NSData) -> NSData? {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getData(key: key)! as NSData
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: NSArray
   return Array<Any>?
   */
  class func getArray(key: String, defaultValue: NSArray) -> NSArray? {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getArray(key: key)! as NSArray
  }
  
  /**
   get data from nsdefault by key with default value
   - Parameter: key: string
   - Parameter: defaultValue: Dictionary<String, Any>
   return Array<Any>?
   */
  class func getDictionary(key: String, defaultValue: Dictionary<String, Any>) -> Dictionary<String, Any>? {
    if getObject(key: key) == nil {
      return defaultValue
    }
    return getDictionary(key: key)
  }
  
  
  //-------------------------------------------------------------------------------------------
  // MARK: - Set value
  //-------------------------------------------------------------------------------------------
  
  class func setObject(key: String, value: Any) {
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
  }
  
  
  //-------------------------------------------------------------------------------------------
  // MARK: - Synchronize
  //-------------------------------------------------------------------------------------------
  
  class func Sync() {
     UserDefaults.standard.synchronize()
  }
}
