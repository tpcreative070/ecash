//
//  RecoverPasswordVC.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class RecoverPasswordVC  : BaseViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var lbTitle: ICLabel!
    @IBOutlet weak var textFieldNewPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldConfirmPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldOTP : ICTextFieldNoneIcon!
    @IBOutlet weak var btnResend : ICButton!
    @IBOutlet weak var btnVerify : ICButton!
    
    let viewModel = ForgotPasswordViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupDelegate()
        bindingViewModel()
        viewModel.isForgorPassword = false
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
        self.viewModel.doUpdatedForgotPassword()
    }
    
    @objc func actionResend(){
        self.viewModel.doSendOTP()
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldOTP {
            viewModel.otpCode = textField.text
        }
        else if textField == textFieldNewPassword {
            viewModel.newPassword = textField.text ?? ""
        }
        else if textField == textFieldConfirmPassword {
            viewModel.confirmPassword = textField.text ?? ""
        }
    }
    
}
