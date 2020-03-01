//
//  MyQRCodeVieModel.swift
//  ecash
//
//  Created by phong070 on 11/15/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class MyQRCodeViewModel : MyQRCodeViewModelDelegate {
    var avatarBinding: Bindable<UIImage> = Bindable(UIImage())
    var responseToView: ((String) -> ())?
    var fullNameBinding: Bindable<String> = Bindable("")
    var phoneNumberBinding: Bindable<String> = Bindable("")
    var codeBinding: Bindable<UIImage> = Bindable(UIImage())
    
    
    func doSetValue(){
        guard let mData = CommonService.getSignUpStoreData() else {
            return
        }
        fullNameBinding.value = "\(mData.personFirstName ?? "") \(mData.personMiddleName ?? "") \(mData.personLastName ?? "")"
        phoneNumberBinding.value = mData.personMobilePhone ?? ""
        
        
        let myQRCode = MyQRcodeModel()
        Utils.logMessage(object: myQRCode)
        let mJson = JSONSerializerHelper.toJson(myQRCode)
//        let mTransfer = TransferDataModel(content: mJson, type: EnumTransferType.MYQRCODE.rawValue)
        let mQRCode  = QRCodeModel(cycle: 1, total: 1, content: mJson, isDisplay: false)
        mQRCode.type = EnumTransferType.MYQRCODE.rawValue
        if let mCode = QRCodeHelper.shared.generateDataQRCode(from: JSONSerializerHelper.toJson(mQRCode)){
            codeBinding.value = mCode
        }
        
        if let mAvatar = CommonService.getLargeAvatar() {
            avatarBinding.value = mAvatar.doConvertBase64StringToImage()
        }
        responseToView!(EnumResponseToView.UPDATED_UI.rawValue)
    }
}
