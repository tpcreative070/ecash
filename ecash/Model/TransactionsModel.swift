//
//  TransactionsModel.swift
//  ecash
//
//  Created by phong070 on 9/21/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransactionsModel : Codable {
    var handleAction : String?
    var handleName : String?
    var cashLogs : CashLogsEntityModel?
    var cashLogsTemporary : CashLogsEntityModel?
    var transactionsLogs : TransactionsLogsEntityModel?
    var decisionsDiary : DecisionsDiaryEntityModel?
    var transferData : TransferDataModel?
    var publicKeySender : String?
    var message : String?
    init(handleName : String,handleAction : String,transactionsLogs : TransactionsLogsEntityModel? = nil, cashLogs : CashLogsEntityModel? = nil ,cashLogsTemporary :  CashLogsEntityModel? = nil,decisionsDiary : DecisionsDiaryEntityModel? = nil, transferData : TransferDataModel? = nil , publicKeySender : String? = nil,message : String? = nil) {
        self.handleAction = handleAction
        self.handleName = handleName
        self.cashLogs = cashLogs
        self.cashLogsTemporary = cashLogsTemporary
        self.transactionsLogs = transactionsLogs
        self.decisionsDiary = decisionsDiary
        self.transferData = transferData
        self.publicKeySender = publicKeySender
        self.message = message
    }
    
    init() {
        
    }
}
