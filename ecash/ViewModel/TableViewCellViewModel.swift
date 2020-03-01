//
//  TableViewCellViewModel.swift
//  vietlifetravel
//
//  Created by phong070 on 7/9/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
struct TbViewCellViewModelKey {
    public static let FIRSTNAME = "firstName"
    public static let LASTNAME = "lastName"
    public static let BIRTHDAY = "birthday"
}
class AnyObjectViewModel : Codable{
    
}
class TableViewCellViewModel  : TbViewCellViewModelDelegate{
    var maxBinding: Bindable<Int> = Bindable(0)
    var codable: Codable = AnyObjectViewModel()
    var verified: (() -> ())?
    var genderType: String?
    
    var firstName: String? {
        didSet {
           validateFirstName()
        }
    }
    
    var lastName: String? {
        didSet {
            validateLastName()
        }
    }
    
    var birthday: String? {
        didSet{
            validateBirthday()
        }
    }
    
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())
    
    /**
     Validation for firstName field
     */
    func validateFirstName() {
        if firstName == nil || !ValidatorHelper.minLength(firstName) {
            errorMessages.value[TbViewCellViewModelKey.FIRSTNAME] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorFirstNameRequired) ?? ""
        } else {
            errorMessages.value.removeValue(forKey: TbViewCellViewModelKey.FIRSTNAME)
        }
    }
    
    /**
     Validation for lastName field
     */
    func validateLastName() {
        if lastName == nil || !ValidatorHelper.minLength(lastName) {
            errorMessages.value[TbViewCellViewModelKey.LASTNAME] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorLastNameRequired) ?? ""
        } else {
            errorMessages.value.removeValue(forKey: TbViewCellViewModelKey.LASTNAME)
        }
    }
   
    /**
     Validation for birthday field
     */
    func validateBirthday() {
        if birthday == nil || !ValidatorHelper.minLength(birthday) {
            errorMessages.value[TbViewCellViewModelKey.BIRTHDAY] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorBirthdayRequired) ?? ""
        } else if let birthday = birthday, ValidatorHelper.minLength(birthday) && !ValidatorHelper.isValidBirthday(birthday,TimeHelper.FormatBIRTHDAY) {
            errorMessages.value[TbViewCellViewModelKey.BIRTHDAY] = LanguageHelper.getTranslationByKey(LanguageKey.ErrorBirthdayInvalid) ?? ""
        } else {
            errorMessages.value.removeValue(forKey: TbViewCellViewModelKey.BIRTHDAY)
        }
    }
}
