//
//  ChangePasswordVC.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ChangePasswordVC : BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var textFieldOldPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldNewPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldConfirmPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var btnVerify : ICButton!
    let viewModel = ChangePasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupDelegate()
        bindingViewModel()
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
        log(message: "viewWillDisappear======>")
    }
    
    @objc func actionVerify(){
       defineValue()
       viewModel.doChangePassword()
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldOldPassword {
            viewModel.oldPassword = textField.text ?? ""
        }
        else if textField == textFieldNewPassword {
            viewModel.newPassword = textField.text ?? ""
        }
        else if textField == textFieldConfirmPassword {
            viewModel.confirmPassword = textField.text ?? ""
        }
    }
}
