//
//  EditContactViewModel.swift
//  ecash
//
//  Created by phong070 on 11/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
struct EditContactViewModelKey {
    public static let FULLNAME = "fullname"
}

class EditContactViewModel : EditContactViewModelDelegate{
    var walletIdBinding: Bindable<String> = Bindable("")
    var fullNameBinding: Bindable<String> = Bindable("")
    var phoneNumberBinding: Bindable<String> = Bindable("")
    var mobileInfoBinding: Bindable<String> = Bindable("")
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var responseToView: ((String) -> ())?
    var errorMessages: Bindable<Dictionary<String, String>> = Bindable(Dictionary<String, String>())
    var fullName: String? {
        didSet{
            validateFullname()
        }
    }
    
    /**
     ValidateFullname
     */
    func validateFullname(){
        if fullName == nil || !ValidatorHelper.minLength(fullName) {
            errorMessages.value[EditContactViewModelKey.FULLNAME] =  LanguageHelper.getTranslationByKey(LanguageKey.ErrorFullNameRequired ) ?? ""
        }
        else {
            errorMessages.value.removeValue(forKey: EditContactViewModelKey.FULLNAME)
        }
    }
    
    func doSaveContact(){
        validateFullname()
        let walletId = Int64(walletIdBinding.value) ?? 0
        if SQLHelper.updateContacts(walletId: walletId, value: fullName ?? ""){
        }
        responseToView!(EnumResponseToView.UPDATED_CONTACT_SUCCESSFULLY.rawValue)
    }
    
    func doContactInfo(){
        if let mValue = CommonService.getShareContactEntities(){
            self.walletIdBinding.value = mValue.walletId?.description ?? ""
            self.fullNameBinding.value = mValue.fullName?.description ?? ""
            self.phoneNumberBinding.value = mValue.phone ?? ""
            self.mobileInfoBinding.value = mValue.mobileInfo ?? ""
        }
    }
}
