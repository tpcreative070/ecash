//
//  GlobalRequestApiHelper.swift
//  ecash
//
//  Created by phong070 on 9/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
import UIKit

class GlobalRequestApiHelper {
    static let shared =  GlobalRequestApiHelper()
    private let userService: UserService
    private let productService: ProductService
    
    private init(productService: ProductService = ProductService(),userService : UserService = UserService()) {
        self.productService = productService
        self.userService = userService
    }
    
    /**
     do re sign in
     */
    func doReSignIn() {
        guard let mUser = CommonService.getSignInData() else {
            return
        }
        let user = SignInRequestModel(channelCode: EnumChannelName.MB001.rawValue, functionCode: EnumFunctionName.SIGN_IN_USER.rawValue , terminalId: CommonService.getUniqueId(), token: mUser.token ?? "" , transactionId: "", username: mUser.username ?? "" , uuid: CommonService.getUniqueId())
        userService.signIn(data: user) { result  in
            switch result {
            case .success(let userResult):
                if let response = userResult{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        CommonService.setSignInData(storeInfo: SignInStoreModel(data: response.responseData))
                    }
                }
                break
            case .failure( let error ):
                debugPrint(error)
                break
            }
        }
    }

    func doApplicationSignOut() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let appWindow = appDelegate.window
        var topViewController = appWindow?.rootViewController
        while topViewController?.presentedViewController != nil
        {
            topViewController = topViewController?.presentedViewController
        }
        if(topViewController != nil){
            let className = NSStringFromClass(topViewController!.classForCoder)
            if (className != Controller.classNameSignInVC && className != Controller.classNameIntroVC) {
                userService.signOut(data: SignOutRequestModel()) { result  in
                    switch result {
                    case .success(let userResult):
                        if userResult != nil{
                            CommonService.setIsSignOut(value: true)
                            CommonService.signOutGlobal()
                            WebSocketClientHelper.instance.socket.disconnect()
                            Navigator.pushViewMainStoryboard(from: topViewController!, identifier : Controller.signin, isNavigation: false, present : true)
                        }
                        break
                    case .failure( let error ):
                        print(">>>>> doApplicationSignOut Error <<<<<")
                        dump(error)
                        break
                    }
                }
            }
        }
    }

    /*do eDong info*/
    func doGeteDongInfo(completion: @escaping (_ result: GlobalModel)->()){
        if !CommonService.isSigined() {
            return
        }
        productService.geteDongInfo(data: eDongInfoRequestModel()) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("Get eDong info=====>")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        completion(GlobalModel(success:true , message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"), responseCode: response.responseCode, eDongInfoData: result?.responseData))
                    }else{
                        completion(GlobalModel(success:false , message: LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0"), responseCode: response.responseCode, eDongInfoData: result?.responseData))
                    }
                }
                break
            case .failure( let error ):
                completion(GlobalModel(success:false , message: error.message, responseCode: error.code?.description, eDongInfoData: nil))
                debugPrint(error)
                break
            }
        }
    }
    
    /**
       Sync contact
    */
    func doSyncContact(data : [String]){
        userService.syncContact(data: SyncContactRequestModel(data: data)) { result  in
            switch result {
            case .success(let userResult):
                       if let response = userResult{
                           Utils.logMessage(object: response)
                           if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                           }
                       }
                       break
            case .failure( let error ):
                       debugPrint(error)
                       break
            }
        }
    }
    
    /**
        Add contact
    */
    func doAddContact(walletData : [String]){
           userService.addContact(data: AddContactRequestModel(data: walletData)) { result  in
               switch result {
               case .success(let userResult):
                          if let response = userResult{
                              Utils.logMessage(object: response)
                              if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                              }
                          }
                          break
               case .failure( let error ):
                          debugPrint(error)
                          break
               }
           }
    }
    
    /**
          Delete contact
      */
    func doDeleteContact(walletId : String){
             userService.deleteContact(data: DeleteContactRequestModel(walletId : walletId)) { result  in
                 switch result {
                 case .success(let userResult):
                            if let response = userResult{
                                Utils.logMessage(object: response)
                                if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                                }
                            }
                            break
                 case .failure( let error ):
                            debugPrint(error)
                            break
                 }
             }
      }
    
    /*Get public key sender*/
    func doGetPublicKey(transferData : TransferDataModel,completion: @escaping (_ result: TransactionsModel)->()){
        if !CommonService.isSigined() {
            return
        }
        
        if let mData = SQLHelper.getContacts(key: Int64(transferData.sender ?? "0") ?? 0){
            if let mPublicKey = mData.publicKeyValue {
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.WALLET_PUBLIC_KEY.rawValue , handleAction:  EnumTransactionsAction.WALLET_PUBLIC_KEY_SUCCESS.rawValue,publicKeySender : mPublicKey)
                                    completion(mTransactionModel)
                return
            }
        }
        
        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: transferData.sender ?? "")) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("Get public key api=====>")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        GlobalRequestApiHelper.shared.doAddContact(walletData: [transferData.sender ?? ""])
                        CommonService.saveItemToContact(contact: ContactsEntityModel(data : response.responseData,walletId: transferData.sender ?? ""))
                         let data = response.responseData
                        guard let mPublicKey = data.ecKpValue else {
                            let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.WALLET_PUBLIC_KEY.rawValue , handleAction:  EnumTransactionsAction.WALLET_PUBLIC_KEY_FAILED.rawValue,message : "Public key is nil")
                            completion(mTransactionModel)
                            return
                        }
                        let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.WALLET_PUBLIC_KEY.rawValue , handleAction:  EnumTransactionsAction.WALLET_PUBLIC_KEY_SUCCESS.rawValue,publicKeySender : mPublicKey)
                        completion(mTransactionModel)
                    }else if response.responseCode == EnumResponseCode.SESSION_NOT_EXISTED.rawValue{
                        
                    }
                    let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.WALLET_PUBLIC_KEY.rawValue , handleAction:  EnumTransactionsAction.WALLET_PUBLIC_KEY_FAILED.rawValue,message : LanguageHelper.mappingErrorCode(code: response.responseCode ?? "0") ?? "")
                    completion(mTransactionModel)
                }
                break
            case .failure( let error ):
                let mTransactionModel = TransactionsModel(handleName: EnumTransactionsName.WALLET_PUBLIC_KEY.rawValue , handleAction:  EnumTransactionsAction.WALLET_PUBLIC_KEY_FAILED.rawValue,message : error.message ?? "")
                completion(mTransactionModel)
                debugPrint(error)
                break
            }
        }
    }
    
    /*Get denomination*/
    func getDenomination(){
        productService.getDenomination(data: DenominationRequestModel()) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    debugPrint("getDenomination=====>")
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                    SQLHelper.deleteDenomination()
                    if let mData = response.responseData.listDenomination {
                        for index in mData {
                            SQLHelper.insertedDenomination(data: CashValuesEntityModel(value: Int64(index.value ?? 0)))
                        }
                    }
                }
            }
            break
            case .failure(let error ):
                debugPrint(error)
                break
            }
        }
    }
    
    func checkSessionExpired(completed: @escaping (Bool) -> Void) {
           guard let mWalletId = CommonService.getWalletId() else { return }
           userService.getWalletInfo(data: WalletInfoRequestModel(walletId: mWalletId)) {
               result in
                   switch result {
                       case .success(let result) :
                           if let response = result{
                               if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                                   completed(true)
                               } else {
                                   completed(false)
                               }
                           } else {
                               completed(false)
                           }
                           break
                       case .failure( let error ):
                           dump(error)
                           completed(false)
                           break
                   }
           }
       }

    func getWalletInfo(mWalletId: String, completed: @escaping (WalletInfoData?) -> Void) {
        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: mWalletId)) {
            result in
                switch result {
                    case .success(let result) :
                        if let response = result{
                            if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                                let data = response.responseData
                                completed(data)
                            } else {
                                completed(nil)
                            }
                        } else {
                            completed(nil)
                        }
                        break
                    case .failure( let error ):
                        dump(error)
                        completed(nil)
                        break
                }
        }
    }

    /*Checking master key and lastAccessTime*/
    func checkingMasterKeyAndLastAccessTime(completed: @escaping (Bool) -> Void) {
        let lastAccessTimeKey = CommonService.getLastAccessTimeKey()
        if (lastAccessTimeKey != nil && lastAccessTimeKey != "") {
            print("New App need check +++++++++++++++++++")
            productService.getVerifyTransaction(data: VerifyTransactionRequestModel()) {
                result in
                switch result {
                case .success(let result) :
                    if let response = result{
                        Utils.logMessage(object: response)
                        if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                            let responseData = response.responseData
                            CommonService.setLastAccessTimeKey(data: responseData.lastAccessTime ?? "")
                            SQLHelper.replaceKey(mKey: responseData.masterKey ?? "")
                            completed(true)
                        } else {
                            self.showAlert(message: LanguageHelper.getTranslationByKey(LanguageKey.ErrorOccurredLocalDB) ?? "")
                            completed(false)
                        }
                    } else {
                        self.showAlert(message: LanguageHelper.getTranslationByKey(LanguageKey.RequestFailed) ?? "")
                        completed(false)
                    }
                    break
                case .failure( let error ):
                    dump(error)
                    self.showAlert(message: error.message ?? "")
                    completed(false)
                    break
                }
            }
        } else {
            print("Old App no need check =================>>>>>>")
            completed(true)
        }
    }

    func showAlert(message: String){
        let alert = SingleButtonAlert(
            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
            message: message,
            action: AlertAction(buttonTitle: "Ok", handler: {})
        )
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let appWindow = appDelegate.window
        var topViewController = appWindow?.rootViewController
        while topViewController?.presentedViewController != nil
        {
            topViewController = topViewController?.presentedViewController
        }
        if (topViewController != nil) {
            AlertHelper.presentSingleButtonDialog(vc: topViewController!, alert: alert)
        }
    }
 }

