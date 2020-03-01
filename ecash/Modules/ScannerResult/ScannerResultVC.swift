//
//  ScannerResultVC.swift
//  ecash
//
//  Created by phong070 on 10/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ScannerResultVC : BaseViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var tableConstraints: NSLayoutConstraint!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var lbReceiveeCash : ICLabel!
    @IBOutlet weak var lbMoney : ICLabel!
    @IBOutlet weak var lbStatus : ICLabel!
    @IBOutlet weak var lbTransactionsInfo : ICLabel!
    @IBOutlet weak var lbSender : ICLabel!
    @IBOutlet weak var lbSenderValue : ICLabel!
    @IBOutlet weak var lbPhoneNumber : ICLabel!
    @IBOutlet weak var lbPhoneNumberValue : ICLabel!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var lbContentValue : ICLabel!
    @IBOutlet weak var lbeCashAmount : ICLabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var viewCash : UIView!
    @IBOutlet weak var viewTransactions : UIView!
    @IBOutlet weak var viewTransactionTitle : UIView!
    @IBOutlet weak var viewQualityTitle : UIView!
    var dataSource :TableViewDataSource<TableViewCell,CashListViewModel,HeaderView>!
    let viewModel = ScannerResultViewModelList()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
    }
      
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
    }
}
