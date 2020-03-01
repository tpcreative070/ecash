//
//  LixiViewModelList.swift
//  ecash
//
//  Created by phong070 on 12/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import Foundation
class LixiViewModelList : LixiViewModelListDelegate {
    
    var receiveLixiOptionsData: Bindable<ReceiveLixiOptionsData> = Bindable(ReceiveLixiOptionsData())
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var responseToView: ((String) -> ())?
    var listLixi: [LixiViewModel]  = [LixiViewModel]()
    
    func getLixi(){
        if let mData = SQLHelper.getCashTempList() {
            listLixi = mData.map({ (data) -> LixiViewModel in
                return LixiViewModel(data: data)
            })
        }
        listLixi = listLixi.reversed()
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doOpenLixi(index : Int){
        let mData = listLixi[index]
        if (mData.status ?? false){
            return
        }
        self.showLoading.value = true
        if let mContent = mData.content {
            if let mTransfer = mContent.toObject(value: TransferDataModel.self){
                Utils.logMessage(object: mTransfer)
                CommonService.handleTransactionsLogs(transferData: mTransfer, completion: { (mResponseTransactions) in
                    if mResponseTransactions.handleAction == EnumTransactionsAction.INSERT_TRANSACTION_SUCCESS.rawValue {
                                CommonService.handCashLogs(transferData: mResponseTransactions.transferData!, completion: { (mResponseCashLogs) in
                                    if mResponseCashLogs.handleAction == EnumTransactionsAction.INSERT_CASH_LOGS_COMPLETED.rawValue{
                                                   Utils.logMessage(message: "Insert cash completed....")
                                        self.receiveLixiOptionsData.value = ReceiveLixiOptionsData(id: mTransfer.id ?? "", noted: mTransfer.content,templateCode: mTransfer.templateCode ?? "01")
                                        self.showLoading.value = false
                                        CommonService.bindingData()
                                        SQLHelper.updateeCashTemp(data: CashTempEntityModel(transactionSignature: mTransfer.id ?? ""))
                                        CommonService.eventPushActionToView(data: EnumResponseToView.UPDATE_HOME_TO_LIXI)
                                }
                                })
                        }
                })
            }else{
                self.showLoading.value = false
            }
        }else{
             self.showLoading.value = false
        }
    }
    
}
