//
//  AppConstant.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension Date {
  
  var millisecondsSince1970:Int {
    return Int((self.timeIntervalSince1970 * 1000.0).rounded())
  }
    
  var milliseconds:Int {
        return Int((self.timeIntervalSince1970).rounded())
  }
    
  func toString() -> String {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm"
    let formattedDate = format.string(from: self)
    return formattedDate
  }
  
  func toString( withFormat: String ) -> String {
    let format = DateFormatter()
    format.dateFormat = withFormat
    let formattedDate = format.string(from: self)
    return formattedDate
  }
  
  func timeAgoDisplay() -> String {
    let secondsAgo = Int (Date().timeIntervalSince(self))
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    let week = 7 * day
    if secondsAgo < minute {
      return "\(secondsAgo) seconds ago"
    } else if secondsAgo < hour {
      return "\(secondsAgo / minute ) minutes ago"
    } else if secondsAgo < day {
      return "\(secondsAgo / hour) hours ago"
    } else if secondsAgo < week {
      return "\(secondsAgo / day ) days ago"
    }
    return "\(secondsAgo / week) weeks ago"
  }
  
//    func currentTimeFormatSocket() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyyMMdd HH:mm:ss"
//        return dateFormatter.string(from: self)
//    }
  /**
   This function handle get current unix time
   Example: 1552622729.971545
  */
  func getCurrentTimeUnix() -> Double {
    return self.timeIntervalSince1970
  }
}
