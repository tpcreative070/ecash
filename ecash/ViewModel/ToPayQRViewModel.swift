//
//  ToPayQRViewModel.swift
//  ecash
//
//  Created by ECAPP on 1/15/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class ToPayQRViewModel: ToPayQRViewModelDelegate {
    var qrContent: Bindable<String> = Bindable("")
    
    func generateQRCode(){
        let data: ToPayQRModel = ShareApplicationSingleton.shared.get(key: StorageKey.ToPayQRModel) as! ToPayQRModel
        let mQRCode = QRCodeModel(cycle: 1, total: 1, content: data.toString(), isDisplay: false)
        mQRCode.type = EnumTransferType.QRCODE_TO_PAY.rawValue
        qrContent.value = JSONSerializerHelper.toJson(mQRCode)
    }
}
