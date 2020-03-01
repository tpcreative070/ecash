//
//  WithdraweCashMultipleVC.swift
//  ecash
//
//  Created by phong070 on 9/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class WithdraweCashMultipleVC : BaseViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var viewProfileInfo : UIView!
    @IBOutlet weak var lbFullname : ICLabel!
    @IBOutlet weak var lbFullnameValue : ICLabel!
    @IBOutlet weak var lbeCashId : ICLabel!
    @IBOutlet weak var lbeCashIdValue : ICLabel!
    @IBOutlet weak var lbeCashTotal : ICLabel!
    @IBOutlet weak var lbeCashTotalValue : ICLabel!
    @IBOutlet weak var lbeDongId : ICLabel!
    @IBOutlet weak var lbeDongIdValue : ICLabel!
    @IBOutlet weak var imgDropdown : UIImageView!
    @IBOutlet weak var viewDropDown : UIView!
    @IBOutlet weak var lbeDongTotal : ICLabel!
    @IBOutlet weak var lbeDongTotalValue : ICLabel!
 
    @IBOutlet weak var lbTransferTitle : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var lbWithdrawDropDown : ICLabel!
    @IBOutlet weak var imgWithdrawDropDown : UIImageView!
    @IBOutlet weak var viewWithdrawDropDown : UIView!
    
    @IBOutlet weak var lbTotalMoney : ICLabel!
    @IBOutlet weak var lbTotalMoneyValue : ICLabel!
    var dataSource :TableViewDataSource<TableViewCell,ListAvailableViewModel,HeaderView>!
    @IBOutlet weak var lbNoAvailableMoney : ICLabel!
    @IBOutlet weak var viewListAvailable : UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView : UITableView!
    
    let viewModel = WithdraweCashViewModel()
    lazy var dropdowneDong : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dropdowneToeDong : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBackButton()
        initUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
    }
    
    override func closeButtonPress() {
        dismiss()
    }
    
    @objc func actionDropDown(sender : UITapGestureRecognizer){
        dropdowneDong.show()
    }
    
    @objc func actionWithdrawDropDown(sender : UITapGestureRecognizer){
        dropdowneToeDong.show()
    }
    
    @objc func actionVerify(){
        //viewModel.doPreparingData()
        
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^ Withdraw Success ^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        btnVerify.disableTouch()
        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
            self.btnVerify.enableTouch()
            if (isVerifiedTransaction) {
                self.viewModel.doGetKeyOrganizeRelease()
            }
        }
    }
    
    override func requestUpdateeDong() {
        self.viewModel.doGeteDongInfo()
        self.viewModel.getListAvailable()
    }
    
    override func closeTransaction() {
        dismiss()
    }
}
