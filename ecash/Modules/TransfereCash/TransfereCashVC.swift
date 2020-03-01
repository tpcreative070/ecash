//
//  TransfereCashVC.swift
//  ecash
//
//  Created by phong070 on 8/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TransfereCashVC : BaseViewController {
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
    @IBOutlet weak var lbeDongTotal : ICLabel!
    @IBOutlet weak var lbeDongTotalValue : ICLabel!
    @IBOutlet weak var viewDropDown : UIView!
    @IBOutlet weak var lbWithdrawMoneyToeDong : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var textFieldeCashId : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldMoney : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldContent : ICTextFieldNoneIcon!
    lazy var dropdowneDong : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewModel = TransfereCashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBackButton()
        initUI()
        bindingViewModel()
        self.setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
    }
    
    override func closeButtonPress() {
        dismiss()
    }
    
    @objc func actionVerify(){
        debugPrint("Action")
        viewModel.isTypeMoney = true
        viewModel.doGetPublicKey()
    }
    
    @objc func actionDropDown(sender : UITapGestureRecognizer){
        dropdowneDong.show()
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldeCashId {
            viewModel.eCashId = textField.text ?? ""
        }
        else if textField == textFieldMoney {
            viewModel.moneyInput = textField.text ?? ""
        }
        else if textField == textFieldContent {
            viewModel.content = textField.text ?? ""
        }
    }
    
    override func requestUpdateeDong() {
        self.viewModel.doGeteDongInfo()
    }
}
