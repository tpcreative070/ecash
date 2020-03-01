//
//  ExchangeeCashVC.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ExchangeeCashVC : BaseViewController{
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var viewProfileInfo : UIView!
    @IBOutlet weak var lbeCashId : ICLabel!
    @IBOutlet weak var lbeCashIdValue : ICLabel!
    @IBOutlet weak var lbeCashTotal : ICLabel!
    @IBOutlet weak var lbeCashTotalValue : ICLabel!
    @IBOutlet weak var lbCashListAvailable : ICLabel!
    @IBOutlet weak var viewCashExchange : UIView!
    @IBOutlet weak var viewCashReceive : UIView!
    @IBOutlet weak var btnCashExchange : ICButton!
    @IBOutlet weak var btnCashReceive : ICButton!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var lbNoAvailableMoney : ICLabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var lbTotalExchangeCash : ICLabel!
    @IBOutlet weak var lbTotalExchangeCashValue : ICLabel!
    @IBOutlet weak var lbTotalExpectationCash : ICLabel!
    @IBOutlet weak var lbTotalExpectationCashValue : ICLabel!
    let viewModel = ExchangeeCashListViewModel()
    var dataSource :TableViewDataSource<TableViewCell,ExchangeeCashViewModel,HeaderView>!
    
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBackGrayButton()
        initUI()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    
    override func closeButtonPress() {
        CommonService.clearExchangeCashData()
        dismiss()
    }
    
    @objc func actionCashExchange(_ sender: UIButton){
        log(message: "exchange")
        viewModel.sendRequest(isExchangeCash: true, isResponse: false)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.exchangeeCashOptions, isNavigation: false, isTransparent: true, present:true)
    }
    
    @objc func actionCashReceive(_ sender: UIButton){
        viewModel.sendRequest(isExchangeCash: false, isResponse: false)
        log(message: "receive")
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.exchangeeCashOptions, isNavigation: false, isTransparent: true, present:true)
    }
    
    @objc func actionVerify(_ sender: UIButton){
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^ Exchange Success ^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        btnVerify.disableTouch()
        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
            self.btnVerify.enableTouch()
            if (isVerifiedTransaction) {
                self.viewModel.doGetKeyOrganizeRelease()
            }
        }
    }
    
    override func closeTransaction() {
        dismiss()
    }
}
