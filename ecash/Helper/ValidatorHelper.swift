//
//  ValidatorHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation

class ValidatorHelper {
  /**
   Validate the password is strong
   - parameter password: string - password value
   */
  static func isValidPassword(_ password: String?) -> Bool {
    guard password != nil else { return false }
    let regEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", regEx)
    return passwordTest.evaluate(with: password)
  }
  
  /**
   Validate the email
   - parameter email: string - email value
   */
  static func isValidEmail(_ email: String?) -> Bool {
    guard email != nil else { return false }
    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", regEx)
    return emailTest.evaluate(with: email)
  }
  
  /**
    Validate the birthday
     - parameter birthday: String - birthday value
  */
    static func isValidBirthday(_ birthday : String,_ format : String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let _ = dateFormatter.date(from:birthday) {
           return true
        }
        return false
    }
  
  /**
   Validate the phone number
   - parameter Phone: string - phone value
   */
  static func isValidPhone(_ phone: String?) -> Bool {
    guard phone != nil else { return false }
    let regEx = "^((\\+)|(00))[0-9]{6,14}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", regEx)
    return phoneTest.evaluate(with: phone)
  }
  
  /**
   Validate the pin code setting from user
   - parameter pin: string - pin code validate
   */
  static func isValidPin (_ pin: String?) -> Bool {
    guard pin != nil else { return false }
    let regEx = "^[0-9]{6}$"
    let pinTest = NSPredicate(format: "SELF MATCHES %@", regEx)
    return pinTest.evaluate(with: pin)
  }
  
  /**
   Validate the pin code setting from user
   - parameter str: string - value to check the maximum of the string
   - parameter maxLength: int Default max length of user want validate it
   */
    static func maxLength(_ str: String?, maxLength: Int = AppConstants.MAX_LENGHT) -> Bool {
    guard str != nil else { return false }
    if let countStr = str?.trimmingCharacters(in: .whitespacesAndNewlines), countStr.count > maxLength {
      return false
    }
    return true
  }
  
  /**
   Validate min lenght of the string
   - parameter str: string - value to check the maximum of the string
   - parameter minLength: int - Default max length of user want validate it
   */
   static func minLength(_ str: String?, minLength: Int = AppConstants.MIN_LENGHT) -> Bool {
    guard str != nil else { return false }
    if let countStr = str?.trimmingCharacters(in: .whitespacesAndNewlines), countStr.count < minLength {
      return false
    }
    return true
  }
  
  static func isValidLat(_ lat: Float) -> Bool {
    return (lat < 90 && lat > -90)
  }
  static func isValidLon(_ lon : Float) -> Bool {
    return (lon < 180 && lon > -180)
  }
}
