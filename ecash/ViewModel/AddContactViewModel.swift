//
//  AddContactViewModel.swift
//  ecash
//
//  Created by phong070 on 11/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class AddContactViewModel  : AddContactViewModelDelegate{
    var listContacts: [ContactsViewModel] = [ContactsViewModel]()
    var responseToView: ((String) -> ())?
    
    var search: String? {
        didSet {
            if self.search != nil && ValidatorHelper.minLength(self.search) {
                if self.search?.first == "0" {
                     doSearchContactByPhone()
                }else{
                     doSearchContactByWalletId()
                }
            }
        }
    }
    
    var currentCell: ContactsViewModel?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    private let userService : UserService
    
    init(userService : UserService = UserService()) {
        self.userService = userService
    }
    
    /**
     Checking walletId
     */
    func doSearchContactByPhone(){
        showLoading.value = true
        userService.searchByPhoneNumber(data: SearchByPhoneRequestModel(phoneNumber: self.search ?? "")) { result  in
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let mValue = response.responseData
                        if let mList = mValue.wallets {
                            self.listContacts = mList.map({ (data) -> ContactsViewModel in
                                return ContactsViewModel(data: data, searchData: mValue)
                            })
                        }
                        self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
                    }else{
                        let okAlert = SingleButtonAlert(
                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                            message: LanguageHelper.getTranslationByKey(LanguageKey.NotFound),
                            action: AlertAction(buttonTitle: "Ok", handler: {
                                print("Ok pressed!")
                        }))
                        self.onShowError?(okAlert)
                    }
                }
                self.showLoading.value = false
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                break
            }
        }
    }
    
    /*Get public key sender*/
    func doSearchContactByWalletId(){
        showLoading.value = true
        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: search ?? "")) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("Get public key api=====>")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                       let mValue = response.responseData
                        var mList = [ContactsViewModel]()
                        mList.append(ContactsViewModel(data: mValue, walletId: self.search ?? ""))
                        self.listContacts = mList
                        self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
                    }else{
                         let okAlert = SingleButtonAlert(
                                title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                                message:  LanguageHelper.getTranslationByKey(LanguageKey.NotFound),
                                action: AlertAction(buttonTitle: "Ok", handler: {
                                                      print("Ok pressed!")
                        }))
                        self.onShowError?(okAlert)
                    }
                    self.showLoading.value = false
                }
                break
            case .failure( let error ):
                let okAlert = SingleButtonAlert(
                    title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
                    message: error.message,
                    action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                )
                self.onShowError?(okAlert)
                self.showLoading.value = false
                break
            }
        }
    }
    
    func isAllowInsert(data : ContactsViewModel) -> Bool{
        if let mData = CommonService.getWalletId(){
            if data.walletId != mData{
                return true
            }
        }
        return false
    }
    
    /**
       Checking username
    */
    func doSyncContact(data : [String]){
            showLoading.value = true
            userService.syncContact(data: SyncContactRequestModel(data: data)) { result  in
                self.showLoading.value = false
                switch result {
                case .success(let userResult):
                    if let response = userResult{
                        Utils.logMessage(object: response)
                        if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        }
                    }
                    break
                case .failure( let error ):
                    let okAlert = SingleButtonAlert(
                        title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Error",
                        message: error.message,
                        action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
                    )
                    self.onShowError?(okAlert)
                    break
                }
            }
        }
}
