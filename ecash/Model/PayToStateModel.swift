//
//  PayToStateModel.swift
//  ecash
//
//  Created by ECAPP on 2/12/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
struct PayToStateModel {
    var receiverECashWalletIds: [String] = []
    var amount = 0
    var content = ""
    init(receiverECashWalletIds: [String] = [], amount: Int = 0, content: String = "") {
        self.receiverECashWalletIds = receiverECashWalletIds
        self.amount = amount
        self.content = content
    }
}
