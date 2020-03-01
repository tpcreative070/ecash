//
//  LanguageHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import Foundation
class LanguageHelper {
    
    /**
     Store language from server to local database
     - parameter key: string - this is key of languages(en, de, etc)
     - parameter data: string - this is a json string with key: key of the translation, value: value of the translation key
     */
    class func storeLanguageByKey(_ key: String, data: String) {
        let language = TranslationEntity()
        language.lang = key
        language.translations = data
        DbManager.sharedInstance.addData(data: language)
    }
    
    /**
     Store language from server to local database
     - parameter key: string - this is key of languages(en, de, etc)
     - parameter data: string - this is a json string with key: key of the translation, value: value of the translation key
     */
    class func getLanguageByKey(_ key: String) -> Dictionary<String, Any>? {
        var dataLang = GlobalVariableHelper.languages[key] as? Dictionary<String, Any>
        if dataLang?.count == 0 {
            let translation = DbManager.sharedInstance.getDataByKey(data: TranslationEntity.self, filter: "lang='"+key+"'").first
            if let data =  JSONHelper.convertStringToDictionary(translation?.translations ?? "")  {
                dataLang = data
                GlobalVariableHelper.languages[key] = data
            }
        }
        return dataLang
    }
    
    /**
     - parameter key: string - this is key of languages(en, de, etc)
     - parameter data: string - this is a json string with key: key of the translation, value: value of the translation key
     */
    class func getTranslationByKey(_ key: String, data: Dictionary<String, Any> = Dictionary<String, Any>(), params: CVarArg... ) -> String? {
        var langData = Dictionary<String, Any>()
        if data.count > 0 {
            langData = data
        } else {
            var currentLang = LanguageCode.Vietnamese
            if let mData = CommonService.getMultipleLanguages(){
                currentLang = mData
            }
            langData = LanguageHelper.getLanguageByKey(currentLang) ?? [:]
        }
        if params.count > 0  {
            return String(format: langData[key] as? String ?? "", params)
        }
        return langData[key] as? String
    }
    
    class func mappingErrorCode(code: String,param : String? = nil) -> String? {
        switch code {
            case EnumResponseCode.EXISTING_VALUE.rawValue :
                return getTranslationByKey(LanguageKey.TransactionSuccessful)
            case EnumResponseCode.OTP_INCORRECT.rawValue :
                return getTranslationByKey(LanguageKey.OTPIncorrect)
            case EnumResponseCode.PASSWORD_INVALID.rawValue :
                return getTranslationByKey(LanguageKey.PasswordIncorrect)
            case EnumResponseCode.USER_NOT_ACTIVE.rawValue:
                return getTranslationByKey(LanguageKey.AccountNotActivated)
            case EnumResponseCode.USER_IS_NOT_EXISTED.rawValue:
                return getTranslationByKey(LanguageKey.AccountDoesNotExist)
            case EnumResponseCode.MISS_PARAM.rawValue :
                if let mParam = param {
                    return String(format: LanguageHelper.getTranslationByKey(LanguageKey.PleaseEnterParam) ?? "", arguments: [mParam])
                }
                return getTranslationByKey(LanguageKey.PleaseEnterFullFields)
        case EnumResponseCode.Value_IS_EXISTED.rawValue :
                return String(format: LanguageHelper.getTranslationByKey(LanguageKey.ValueExisted) ?? "", arguments: [param ?? ""])
        case EnumResponseCode.RENEW_NOT_ALLOW.rawValue :
                return LanguageHelper.getTranslationByKey(LanguageKey.ReNewNotAllow)
            default:
              return String(format: LanguageHelper.getTranslationByKey(LanguageKey.ErrorOccurredFromSystem) ?? "", arguments: [code])
        }
    }
}
