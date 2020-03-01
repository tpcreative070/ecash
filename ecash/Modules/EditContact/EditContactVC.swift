//
//  EditContactCV.swift
//  ecash
//
//  Created by phong070 on 10/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class EditContactVC : BaseViewController {
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var textFieldWalletId : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldFullName : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldPhoneNumber : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldPhoneInfo : ICTextFieldNoneIcon!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var scrollView : UIScrollView!
    let viewModel = EditContactViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
        setupDelegate()
    }
    
    @objc func actionVerify(_ sender: UIButton){
       viewModel.fullName = textFieldFullName.text ?? ""
       viewModel.doSaveContact()
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldFullName {
            viewModel.fullName = textField.text ?? ""
        }
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
