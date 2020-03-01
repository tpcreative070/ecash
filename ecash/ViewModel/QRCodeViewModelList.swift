//
//  QRCodeViewModelList.swift
//  ecash
//
//  Created by phong070 on 10/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
import UIKit
class QRCodeViewModelList : QRCodeViewModelListDelegate {
    var isSelected: Bindable<Bool> = Bindable(false)
    var isVisible: Bindable<Bool> = Bindable(false)
    var listQRCode: [QRCodeViewModel] = [QRCodeViewModel]()
    var responseToView: ((String) -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var deleteList: Bindable<[String]> = Bindable([])
    var shareIntent: Bindable<[UIImage]> = Bindable([UIImage]())
    func doGetListQRCode(){
        isVisible.value = false
        if let mValue = SQLHelper.getTransactionQR(){
            var position = 0
            listQRCode = mValue.map({ (result) -> QRCodeViewModel in
                position = position + 1
                return QRCodeViewModel(data: result,position: position)
            })
            self.listQRCode  = self.listQRCode.filter { $0.isDisplay == true }
        }
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doSelectedAll(isValue : Bool){
        for index in listQRCode {
            index.isChecked = isValue
        }
        checkedList()
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func  getObject (codable : Codable){
        if let data = JSONHelper.get(value: QRCodeViewModel.self,anyObject: codable){
            data.isChecked = !(data.isChecked ?? false)
            listQRCode[data.position ?? 0] = data
        }
        checkedList()
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func shareFiles(){
        var mListImages = [UIImage]()
        for index in listQRCode {
            if index.isChecked ?? false {
                if let mData = QRCodeHelper.shared.generateDataQRCode(from: index.value ?? ""){
                    mListImages.append(mData)
                }
            }
        }
        shareIntent.value = mListImages
    }
    
    func doDelete(){
        for index in listQRCode {
            if index.isChecked ?? false {
                let mData = QRCodeModel(data: index.qrCode,isDisplay: false)
                  SQLHelper.updateTransactionQR(data: TransactionQREntityModel(data: mData, transactionSignature: index.transactionId ?? ""))
            }
        }
        doGetListQRCode()
    }
    
    func checkedList(){
        var count = 0
        for index in listQRCode{
            if index.isChecked ?? false {
                count += 1
            }
        }
        if count > 0 {
            isVisible.value = true
        }else{
            isVisible.value = false
        }
    }
}
