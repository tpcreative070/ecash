//
//  PayToViewModel.swift
//  ecash
//
//  Created by ECAPP on 1/10/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

class PayToViewModel: PayToViewModelDelegate{
    var titleAccountNameBinding: Bindable<String> = Bindable("")

    var acountNameValueBinding: Bindable<String> = Bindable("")
    var titleECashIdBinding: Bindable<String> = Bindable("")
    var eCashIdValueBinding: Bindable<String> = Bindable("")
    var titleECashBalanceBinding: Bindable<String> = Bindable("")
    var eCashBalanceValueBinding: Bindable<String> = Bindable("")
    
    var lbTitleContentBinding: Bindable<String> = Bindable("")
    var titleGetQRCodeBinding: Bindable<String> = Bindable("")
    var eCashAccountNumberBinding: Bindable<String> = Bindable("")
    var amountBinding: Bindable<String> = Bindable("")
    var contentBinding: Bindable<String> = Bindable("")
    
    var titleConfirmBinding: Bindable<String> = Bindable("")
    
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    
    var responseToView: ((String) -> Void)!
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    var amountInt = 0 {
        didSet {
            validateData()
        }
    }
    var contentString = "" {
        didSet {
            contentBinding.value = contentString
        }
    }
    
    // status "ENABLE", "DISABLE"
    var btStatusBinding: Bindable<ButtonStatus> = Bindable(ButtonStatus.ENABLE)
    
    var listCashIds: [String] = [] {
        didSet {
            eCashAccountNumberBinding.value = listCashIds.joined(separator: ",")
            validateData()
        }
    }
    
    private var focusTextField: UITextField?
    
    let userService = UserService()
    
    func setFocusTextField(textField: UITextField) {
        focusTextField = textField
    }
    
    func setResponseToView(responseToView: inout ((String) -> Void)){
        self.responseToView = responseToView
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
    
    func doBindingUpdate(){
        let profile = userProfile.value
        acountNameValueBinding.value = profile.fullNameView ?? ""
        eCashIdValueBinding.value = profile.eCashIdView ?? ""
        eCashBalanceValueBinding.value = profile.eCashBalanceView ?? ""
    }
    
    func validateData(){
        if (amountInt > 0 && amountInt.isMultiple(of: 1000) && listCashIds.count > 0){
            btStatusBinding.value = ButtonStatus.ENABLE
        } else {
            btStatusBinding.value = ButtonStatus.DISABLE
        }
        
    }
    
    func sentRequest() {
        let currentDate = Date()
//        let time = currentDate.currentTimeFormatSocket()
        let time = TimeHelper.getString(time: currentDate, dateFormat: TimeHelper.FormatSendEnc)
        let type = EnumTransferType.PAY_TO_TO_PAY_REQUEST_PAYMENT.rawValue
        
        if Helper.isConnectedToNetwork(){
            if WebSocketClientHelper.instance.socket.isConnected {
                var totalCompleted = 0;
                for receiverWalletId in self.listCashIds {
                    let senderPublicKey = CommonService.getPublicKey()
                    guard let sender = CommonService.getWalletId() else { return }
                    if (self.contentString == "") {
                        self.contentString = "nil"
                    }
                    let hash = "\(self.contentString)\(receiverWalletId)\(sender)\(senderPublicKey ?? "")\(time)\(self.amountInt)\(type)"
                    // Use Sender's publicKey to sign
                    let signature = ECSecp256k1.signData(strMessage: hash, strPrivateKey: senderPublicKey)
                    let profile = self.userProfile.value
                    let socketRequest = SocketRequestPaytoModel(
                        sender: sender,
                        receiver: receiverWalletId,
                        time: time,
                        type: type,
                        content: self.contentString,
                        senderPublicKey: senderPublicKey ?? "",
                        totalAmount: "\(self.amountInt)",
                        channelSignature: signature ?? "",
                        fullName: profile.fullNameView ?? ""
                    )
                    
                    let transfer = TransferDataModel(data: socketRequest)
                    print("--------------- Pay To - To Pay WebSocket Sender Data --------------->")
                    dump(transfer)
                    print("-------------------------- WebSocket End ------------------------------>")
                    totalCompleted += 1
                    if(totalCompleted == self.listCashIds.count){
                        self.responseToView(EnumResponseToView.PayToToPayUnloadingButton.rawValue)
                    }
                    WebSocketClientHelper.instance.senderData(transfer: transfer)
                }
            } else {
                self.responseToView(EnumResponseToView.NO_SOCKET_CONNECTION.rawValue)
            }
        }else{
            self.responseToView(EnumResponseToView.NO_INTERNET_CONNECTION.rawValue)
        }
    }

    func doAlertConnection(value : String){
        let okAlert = SingleButtonAlert(
            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
            message: value,
            action: AlertAction(buttonTitle: "Ok", handler: { print("Ok pressed!") })
        )
        self.onShowError?(okAlert)
    }
    
    func saveTmpState() {
        let state = PayToStateModel(receiverECashWalletIds: listCashIds, amount: amountInt, content: contentString)
        ShareApplicationSingleton.shared.set(key: StorageKey.CurrentPayToState, value: state)
    }
    
    func initTmpState() {
        let stateAny: Any? = ShareApplicationSingleton.shared.get(key: StorageKey.CurrentPayToState) as? PayToStateModel
        switch stateAny {
            case Optional<Any>.none:
                break
            default:
                let state = stateAny as! PayToStateModel
                if (state.amount > 0) {
                    amountBinding.value = "\(state.amount)".withSeparator()
                    amountInt = state.amount
                }
                contentBinding.value = state.content
                contentString = state.content
                validateData()
        }
    }
    
    func resetTmpState() {
        let state = PayToStateModel(receiverECashWalletIds: [], amount: 0, content: "")
        ShareApplicationSingleton.shared.set(key: StorageKey.CurrentPayToState, value: state)
    }
}
