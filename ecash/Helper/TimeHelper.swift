//
//  TimeHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
class TimeHelper {
    static let FormatYear = "dd-MM-YYYY"
    static let FormatHour = "dd-MM-YYYY HH:mm"
    static let FormatDateTime = "dd-MM-YYYY HH:mm:ss"
    static let FormatVNDate = "dd/MM/yyyy"
    static let FormatMonth = "MMMM yyyy"
    static let FormatMonthDay = "MMM d, yyyy HH:mm"
    static let FormatHM = "HH:mm"
    static let FormatBIRTHDAY = "dd/MM/yyyy"
    static let FormatSendEnc = "yyyyMMdd HH:mm:ss"
    static let StandardFormatTime = "yyyyMMdd HH:mm:ss"
    static let FormatTimeSecond = "yyyy-MM-dd'T'HH:mm:ss"
    static let StandardSaveContact = "yyyyMMddHHmmss"
    static let StandardFilterMonthYear = "MM/yyyy"
    static let StandardYearMonthQuery = "yyyyMM"
    static let StandardTransaction = "dd/MM/YYYY HH:mm:ss"
    static let StandardSortedDateTime = "ddMMYYYYHHmmss"
    // conver String to Date with format
    static func getTime(timeString: String, dateFormat: String = TimeHelper.FormatHour) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: timeString)
    }
    // conver Date to String with format
    static func getString(time : Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: time)
    }
    // conver String to String with in-out format
    static func converStringTime(inputTime: String, inputFormat: String, outputFormat : String = TimeHelper.FormatHour) -> String {
        if let inputDate = getTime(timeString: inputTime, dateFormat: inputFormat)  {
            return getString(time: inputDate, dateFormat: outputFormat)
        }
        return ""
    }
    
    static func convertStringTimeT(inputTime : String,inputFormat : String) -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: inputTime) ?? Date()
        dateFormatter.dateFormat = inputFormat ; //"dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale --> but no need here
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    static func getTimeFrom1970(time: Int, formatString: String = TimeHelper.FormatHour) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        return getString(time: date, dateFormat: formatString)
    }
    
    static func getDifferent(start: Date, end: Date) -> String {
        let difference = Calendar.current.dateComponents([.day ,.hour, .minute, .second], from: start, to: end)
        var runningString = ""
        if difference.day! > 1 {
            runningString = "\(difference.day!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Days)!)"
        } else if difference.day! > 0 {
            runningString = "\(difference.day!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Day)!)"
        }
        
        if difference.hour! > 1 {
            runningString = "\(runningString) \(difference.hour!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Hours)!)"
        } else if difference.hour! > 0 {
            runningString = "\(runningString) \(difference.hour!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Hour)!)"
        }
        if difference.minute! > 1 {
            runningString = "\(runningString) \(difference.minute!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Minutes)!)"
        } else if difference.hour! > 0 {
            runningString = "\(runningString) \(difference.minute!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Minute)!)"
        }
        if difference.second! > 1 {
            runningString = "\(runningString) \(difference.second!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Seconds)!)"
        } else if difference.second! > 0 {
            runningString = "\(runningString) \(difference.second!) \(LanguageHelper.getTranslationByKey(LanguageKey.Time_Second)!)"
        }
        
        return runningString.trimmingCharacters(in: .whitespaces)
    }
}
