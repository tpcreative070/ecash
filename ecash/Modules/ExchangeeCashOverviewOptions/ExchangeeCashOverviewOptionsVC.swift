//
//  ExchangeeCashOverviewOptionsVC.swift
//  ecash
//
//  Created by phong070 on 11/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ExchangeeCashOverviewOptionVC : BaseViewController {
    
    @IBOutlet weak var lbExchangeCash : ICLabel!
    @IBOutlet weak var lbExpectationCash : ICLabel!
    @IBOutlet weak var lbTotalExchangeCash : ICLabel!
    @IBOutlet weak var lbTotalExchangeCashValue : ICLabel!
    @IBOutlet weak var lbTotalExpectationCash : ICLabel!
    @IBOutlet weak var lbTotalExpectationCashValue : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var exchangeTableView : UITableView!
    @IBOutlet weak var expectationTableView : UITableView!
    @IBOutlet weak var viewRoot : UIView!
    
    var exchangeCashDataSource : TableViewDataSource<TableViewCell,ListAvailableViewModel,HeaderView>!
    var expectationCashDataSource : TableViewDataSource<TableViewCell,ExpectationCashViewModel,HeaderView>!
    let viewModel = ExchangeeCashOverviewOptionsViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    @objc func actionVerify(){
        dismiss()
    }
}
