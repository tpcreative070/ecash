//
//  TransactionsLogsViewModelList.swift
//  ecash
//
//  Created by Tuan Le Anh on 10/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class TransactionsLogsViewModelList : TransactionsLogsViewModelListDeletegate {
    var currentCell: TransactionsLogsViewModel?
    var onShowError: ((SingleButtonAlert) -> Void)?
    var showLoading: Bindable<Bool> = Bindable(false)
    var search: String? {
        didSet{
            doSearch()
        }
    }
    var responseToView: ((String) -> ())?
    var listTransactionsLogs: [TransactionsLogsViewModel] = [TransactionsLogsViewModel]()
    var navigate: (() -> ())?
    private let userService : UserService
   
    init(userService : UserService = UserService()) {
        self.userService = userService
    }
    
    func doGetListTransactionsLogs(){
        self.listTransactionsLogs.removeAll()
        if let mList = SQLHelper.getListTransactionsLogsView(){
            self.listTransactionsLogs = mList.map({ (data) -> TransactionsLogsViewModel in
                return TransactionsLogsViewModel(data:  data)
            })
            listTransactionsLogs = listTransactionsLogs.sorted {$0.sortId > $1.sortId}
        }
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doSearch(){
        guard let result = search else {
            debugPrint("Search nil")
            return
        }
        debugPrint("key \(result)")
        if let value = SQLHelper.searchTransactionsLogsView(key: result){
            listTransactionsLogs = value.map({ (event) -> TransactionsLogsViewModel in
                return TransactionsLogsViewModel(data: event)
            })
            listTransactionsLogs = listTransactionsLogs.sorted {$0.sortId > $1.sortId}
            Utils.logMessage(object: value)
        }
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doFilter(filter : FilterData){
        guard let mResult =   SQLHelper.filterTransactionLogsHistory(transType: filter.type ?? "", transDate: filter.time ?? "", transStatus: filter.status ?? "")else {
            listTransactionsLogs = [TransactionsLogsViewModel]()
            responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
            return
        }
        listTransactionsLogs = mResult.map({ (event) -> TransactionsLogsViewModel in
            return TransactionsLogsViewModel(data: event)
        })
        listTransactionsLogs = listTransactionsLogs.sorted {$0.sortId > $1.sortId}
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
        
    }
}
