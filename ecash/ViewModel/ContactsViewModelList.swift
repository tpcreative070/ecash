//
//  ContactViewModelList.swift
//  ecash
//
//  Created by phong070 on 10/7/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ContactsViewModelList : ContactsViewModelListDeletegate {
    var listReceiver: [String] = [String]()
    var isSelected: Bindable<Bool> = Bindable(false)
    var isCallFirstTime: Bool? = false
    var isContactBinding: Bindable<Bool> = Bindable(false)
    var currentCell: ContactsViewModel?
    var onShowError: ((SingleButtonAlert) -> Void)?
    var showLoading: Bindable<Bool> = Bindable(false)
    var search: String? {
        didSet{
            doSearch()
        }
    }
    var responseToView: ((String) -> ())?
    var listContacts: [ContactsViewModel] = [ContactsViewModel]()
    var navigate: (() -> ())?
    private let userService : UserService
   
    init(userService : UserService = UserService()) {
        self.userService = userService
    }
    
    func doGetListContacts(){
        if let mList = SQLHelper.getListContacts(){
            var index = 0
            self.listContacts = mList.map({ (data) -> ContactsViewModel in
                index += 1
                return ContactsViewModel(data:  data,index: index)
            })
        }
        listContacts = listContacts.sorted {$0.groupId > $1.groupId}
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doSearch(){
        guard let result = search else {
            debugPrint("Search nil")
            return
        }
        debugPrint("key \(result)")
        if let value = SQLHelper.searchContacts(key: result){
            var index = 0
            listContacts = value.map({ (data) -> ContactsViewModel in
                index += 1
                return ContactsViewModel(data:  data,index: index)
            })
            Utils.logMessage(object: value)
        }
        listContacts = listContacts.sorted {$0.groupId > $1.groupId}
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    
    /**
     Checking username
     */
    func doSyncContact(){
        guard let _ = ContactHelper.instance.getRealContactPhoneNumber() else {
            return
        }
        showLoading.value = true
        userService.syncContact(data: SyncContactRequestModel()) { result  in
            self.showLoading.value = false
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        CommonService.setIsNewApp(value: false)
                    }else{
                       
                    }
//                    let okAlert = SingleButtonAlert(
//                            title: LanguageHelper.getTranslationByKey(LanguageKey.Alert) ?? "Alert",
//                            message: response.responseMessage,
//                            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
//                    )
//                    self.onShowError?(okAlert)
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
    
    func checkContactPermission(){
        GrantPermission.checkContactPermission { (data) in
            switch (data){
            case .authorized:
                debugPrint("authorized")
                DispatchQueue.main.async {
                    if CommonService.getIsNewApp() ?? false {
                        self.doSyncContact()
                    }else{
                        self.requestContactPermission()
                    }
                }
                break
            case .denied:
                DispatchQueue.main.async {
                    self.isContactBinding.value = false
                }
                debugPrint("denied")
                break
            case .notDetermined:
                self.isCallFirstTime = true
                DispatchQueue.main.async {
                   self.requestContactPermission()
                }
                debugPrint("notDetermined")
                break
            case .restricted:
                debugPrint("restricted")
                break
            default :
                break
            }
        }
    }
    
    func requestContactPermission(){
        GrantPermission.requestContactPermission { (data) in
            if data {
                DispatchQueue.main.async {
                    if let mValue =  ContactHelper.instance.getContact(){
                        debugPrint("getContact...")
                        Utils.logMessage(object: mValue)
                        if (self.isCallFirstTime ?? false) {
                            self.doSyncContact()
                            self.isCallFirstTime = false
                        }
                    }
                }
            }
        }
    }
    
    func doUpdateContact(){
        if let mData = currentCell {
            if SQLHelper.updateContacts(walletId:  Int64(mData.walletId ?? "0") ?? 0, value: false){
                doGetListContacts()
            }
        }
    }
    
    func doDeleteContact(){
         if let mData = currentCell {
            if SQLHelper.deleteContacts(walletId:  Int64(mData.walletId ?? "0") ?? 0){
                 doGetListContacts()
             }
         }
     }
    
    func openAppSetting() {
        UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    func doSelectItem(coable : Codable){
        if let value = coable.get(value: ContactsViewModel.self){
            Utils.logMessage(object: listContacts)
            for (index, element) in listContacts.enumerated() {
                if element.walletId == value.walletId {
                    debugPrint(index)
                    let mObject = listContacts[index]
                    mObject.check = !value.check
                }
            }
            
            var isSelect = false
            for index in listContacts {
                if index.check{
                    isSelect = true
                }
            }
            isSelected.value = isSelect
            listContacts = listContacts.sorted {$0.groupId > $1.groupId}
            responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
        }
    }
    
    func doDone(){
        listReceiver.removeAll()
        for index in listContacts {
            if index.check{
                listReceiver.append(index.walletId ?? "")
            }
        }
        self.responseToView!(EnumResponseToView.MULTIPLE_SELECTED_DONE.rawValue)
        
        // Bus Event send data to any VC is override method updateActionToObjectView from BaseViewController and define by key ConfigKey.ActionToObjectView
        let obj = EventBusObjectData(data: listReceiver, type: DataKeyType.ArrayString, identify: EnumViewControllerNameIdentifier.ContactVC)
        CommonService.eventPushActionToObjectView(obj: obj)
    }
    
}
