//
//  QRCodeViewModel.swift
//  ecash
//
//  Created by phong070 on 10/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class QRCodeViewModel  : Codable , QRCodeViewModeDeletegate {
    
    var isCheckedView: Bool? {
        return isChecked ?? false
    }
    
    var valueView: String?{
        return value ?? ""
    }
    
    var nameView: String? {
        return name ?? ""
    }
    var createdDateView: String?{
        return createdDate ?? ""
    }
    
    var transactionIdView: String? {
        return transactionId ?? ""
    }
    
    var value : String?
    var name : String?
    var createdDate : String?
    var transactionId : String?
    var isChecked : Bool?
    var position : Int?
    var qrCode = QRCodeModel()
    var isDisplay : Bool?
    
    init(data  : TransactionQREntityModel, position : Int) {
        if let mQRModel = data.value?.toObject(value: QRCodeModel.self){
            self.createdDate = mQRModel.time
            self.isDisplay = mQRModel.isDisplay
            self.qrCode = mQRModel
        }
        self.value = data.value
        self.name = data.sequence?.description
        self.transactionId = data.transactionSignature
        self.isChecked = false
        self.position = position - 1
    }
}
