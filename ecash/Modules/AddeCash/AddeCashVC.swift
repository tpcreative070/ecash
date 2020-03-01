//
//  AddeCashVC.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class AddeCashVC : BaseViewController {
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
    @IBOutlet weak var lbeDongTotal : ICLabel!
    @IBOutlet weak var lbeDongTotalValue : ICLabel!
    @IBOutlet weak var viewDropDown : UIView!
    
    @IBOutlet weak var imgDropdowneDongSelect : UIImageView!
    @IBOutlet weak var lbeDongIdSelect : ICLabel!
    @IBOutlet weak var viewDropDownSelect : UIView!
    
    @IBOutlet weak var lbMoney : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var lbTotalMoney : ICLabel!
    @IBOutlet weak var lbTotalMoneyValue : ICLabel!
    @IBOutlet weak var constraintHeight : NSLayoutConstraint!
    let viewModel = AddeCashViewModelList()
    @IBOutlet weak var tableView : UITableView!
    var dataSource :TableViewDataSource<TableViewCell,AddCashViewModel,HeaderView>!
    lazy var dropdowneDong : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dropdowneDongSelect : DropDown  = {
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
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    
    override func closeButtonPress() {
        dismiss()
    }
    
    @objc func actionDropDown(sender : UITapGestureRecognizer){
        dropdowneDong.show()
    }
    
    @objc func actionDropDownSelect(sender : UITapGestureRecognizer){
        dropdowneDongSelect.show()
    }
    
    @objc func actionVerify(){
        btnVerify.disableTouch()
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^ Added Success ^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
            self.btnVerify.enableTouch()
            if (isVerifiedTransaction == true) {
                self.viewModel.doeDongToeCash()
            }
        }
    }
    
    override func requestUpdateeDong() {
        self.viewModel.doGeteDongInfo()
    }
    
    override func closeTransaction() {
        dismiss()
    }
    
    override func closeViewController() {
        log(message: "closeViewController")
    }
}
