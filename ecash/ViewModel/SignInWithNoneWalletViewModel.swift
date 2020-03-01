//
//  SignInWithNoneWalletViewModel.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class SignInWithNoneWalletViewModel : Codable {
    var walletId : String?
    var lastAccessTime : String?
    var masterKey : String?
    var channelSignature : String?
    var transactionCode : String?
    var userId : String?
    var channelId : String?
    var channelCode : String?
    
    init(data : SignInWithNonWalletData) {
        self.walletId = data.walletId
        self.lastAccessTime = data.lastAccessTime
        self.masterKey = data.masterKey
        self.channelSignature = data.channelSignature
        self.transactionCode = data.transactionCode
        self.userId = data.userId
        self.channelId = data.channelId
        self.channelCode = data.channelCode
    }
    
    init() {
    }
    
}
