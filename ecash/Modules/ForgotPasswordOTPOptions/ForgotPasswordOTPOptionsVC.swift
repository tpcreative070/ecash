//
//  ForgotPasswordOTPOptionsVC.swift
//  ecash
//
//  Created by phong070 on 11/11/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ForgotPasswordOTPOptionsVC : BaseViewController {
    
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var textFieldOTP : TextField!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var btnResend : ICButton!
    @IBOutlet weak var viewOTP : UIView!
    
    let viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupDelegate()
        bindingViewModel()
    }
    
    @objc func actionVerify(_ sender : UIButton){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.recoverPassword, isNavigation: false, isTransparent: false, present: true)
    }
    
    @objc func actionResend(_ sender : UIButton){

    }
    
    @objc func inputFieldEditingChanged(textField: UITextField){
        if textField == textFieldOTP {
            viewModel.otpCode = textField.text ?? ""
        }
    }
    
}
