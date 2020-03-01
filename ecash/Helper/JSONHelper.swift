//
//  JSONHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//


import Foundation

class JSONHelper {

  /**
   Convert to JSONData
   - Returns: NSData
   */
  class func convertJSONToData(_ dic: [String:AnyObject]) -> Data? {
    let data = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
    return data
  }
  
  /**
   Convert JSONData to dictionary
   - Returns: Dictionary
   */
  class func convertDataToJSON(_ data: Data) -> [AnyHashable: Any]? {
    
    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    if let json = json as? [AnyHashable: Any] {
      return json
    }
    
    return nil
  }
  
  /**
   Convert JSONData to array
   - Returns: [AnyObject]?
   */
  class func convertDataToJSONArray(_ data: Data) -> [AnyObject]? {
    
    let jsonArr = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    if let jsonArr = jsonArr as? [AnyObject] {
      return jsonArr
    }
    
    return nil
  }
  
  /**
   Convert string to Dictionary
   - parameter data: string
   - Returns: Dictionary<String, Any>?
   */
  class func convertStringToDictionary(_ data: String) -> Dictionary<String, Any>? {
    let jsonData = data.data(using: .utf8)!
    let jsonArr = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
    if let jsonArr = jsonArr as? Dictionary<String, Any>? {
      return jsonArr
    }
    return nil
  }
  
  /**
   Convert Dictionary to string
   - parameter data: Dictionary<String, Any>
   - Returns: String?
   */
  class func convertDictionaryToJson(_ data: Dictionary<String, Any>) -> String? {
    let jsonArr = try? JSONSerialization.data(withJSONObject: data, options: [])
    if let jsonString = String(data: jsonArr!, encoding: .utf8) {
      return jsonString
    }
    return nil
  }
  
  /**
   parse data from JSON file
   - Parameter fileName: String
   - Returns: Dictionary<String, AnyObject>
  */
  class func loadJsonfromLocal(_ fileName: String ) -> Dictionary<String, AnyObject>? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
          return jsonResult
        }
      } catch {
        return nil
      }
    }
    return nil
  }
    
    /**
     parse data from JSON file
     - Parameter fileName: String
     - Returns: Dictionary<String, AnyObject>
     */
    class func loadJsonfromLocalList(_ fileName: String ) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
    
    class func get<T : Codable>(value : T.Type,anyObject : Codable) ->T?{
        do{
            let jsonData = JSONSerializerHelper.toJson(anyObject).data(using: .utf8)
            if let jsonDataValue = jsonData{
                return try JSONDecoder().decode(value.self, from: jsonDataValue)
            }
        }catch{
            Utils.logMessage(message: "Could not cast data")
        }
        return value as? T
    }
    
}
