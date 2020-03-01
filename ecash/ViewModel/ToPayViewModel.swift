//
//  ToPayVCViewModel.swift
//  ecash
//
//  Created by ECAPP on 2/3/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
class ToPayViewModel: ToPayViewModelDelegate {
    
    var titleHeader: Bindable<String> = Bindable("")
    
    var titleAccountNameBinding: Bindable<String> = Bindable("")
    var acountNameValueBinding: Bindable<String> = Bindable("")
    var titleECashIdBinding: Bindable<String> = Bindable("")
    var eCashIdValueBinding: Bindable<String> = Bindable("")
    var titleECashBalanceBinding: Bindable<String> = Bindable("")
    var eCashBalanceValueBinding: Bindable<String> = Bindable("")
    
    var titleContentBinding: Bindable<String> = Bindable("")
    
    var amountValueBinding: Bindable<String> = Bindable("")
    var contentValueBinding: Bindable<String> = Bindable("")
    
    var titleConfirmBinding: Bindable<String> = Bindable("")
    
    private var focusTextField: UITextField?
    
    func setFocusTextField(textField: UITextField) {
        focusTextField = textField
    }
    
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    let userService = UserService()
    // status "ENABLE", "DISABLE"
    var btStatusBinding: Bindable<ButtonStatus> = Bindable(ButtonStatus.ENABLE)
    
    var amountInt = 0 {
        didSet {
            validateData()
        }
    }
    var contentString = "" {
        didSet {
            
        }
    }
    
    func doBindingUpdate(){
        let profile = userProfile.value
        acountNameValueBinding.value = profile.fullNameView ?? ""
        eCashIdValueBinding.value = profile.eCashIdView ?? ""
        eCashBalanceValueBinding.value = profile.eCashBalanceView ?? ""
    }
    
    func validateData(){
        if (amountInt > 0 && amountInt.isMultiple(of: 1000)) {
            btStatusBinding.value = ButtonStatus.ENABLE
        } else {
            btStatusBinding.value = ButtonStatus.DISABLE
        }
        
    }
    
    func doBindingDataToView(data : eDongInfoData? = nil){
        guard let mData = data else {
            doBindingUpdate()
            return
        }
        
        guard let mAccountList = mData.listAcc else{
            doBindingUpdate()
            return
        }
        userProfile.value = UserProfileViewModel(data: mAccountList)
        doBindingUpdate()
    }
    
    func saveFormToSingleton(completion: @escaping (() -> Void)){
        guard let sender = CommonService.getWalletId() else { return }
        let currentDate = Date()
//        let time = currentDate.currentTimeFormatSocket()
        let time = TimeHelper.getString(time: currentDate, dateFormat: TimeHelper.FormatSendEnc)
        let type = EnumTransferType.PAY_TO_TO_PAY_REQUEST_PAYMENT.rawValue
        
        self.userService.getWalletInfo(data: WalletInfoRequestModel(walletId: sender)) { result  in
            switch result {
            case .success(let result) :
                if let response = result{
                    Utils.logMessage(object: response)
                    if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                        let data = response.responseData
                        guard let senderPublicKey = data.ecKpValue else { return }
                        let hash = "\(self.contentString)\(sender)\(senderPublicKey)\(time)\(self.amountInt)\(type)"
                        let signature = ECSecp256k1.signData(strMessage: hash, strPrivateKey: data.ecKpValue)
                        let dataSet: ToPayQRModel = ToPayQRModel(
                                sender: sender,
                                time: time,
                                type: type,
                                content: self.contentString,
                                senderPublicKey: senderPublicKey,
                                totalAmount: "\(self.amountInt)",
                                channelSignature: signature ?? ""
                            )
                        ShareApplicationSingleton.shared.set(key: StorageKey.ToPayQRModel, value: dataSet)
                        completion()
                    } else {
                        // Handle eCash Id not exists
                    }
                }
                break
            case .failure( let error ):
                dump(error)
                break
            }
        }
    }
}
