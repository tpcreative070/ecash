//
//  ExchangeeCashOptions.swift
//  ecash
//
//  Created by phong070 on 10/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ExchangeeCashOptionsVC: BaseViewController {
    
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbExchangeMoney : ICLabel!
    @IBOutlet weak var lbExchangeMoneyValue : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var viewOptions : UIView!
    @IBOutlet weak var lbNoAvailableMoney : ICLabel!
    var dataSource :TableViewDataSource<TableViewCell,ListAvailableViewModel,HeaderView>!
    var expectationCashDataSource :TableViewDataSource<TableViewCell,ExpectationCashViewModel,HeaderView>!
    let viewModel = ExchangeeCashOptionsListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    @objc func actionVerify(_ sender : UIButton){
        dismiss()
        viewModel.sendRequest(isResponse: true)
    }
}
