//
//  ForgotPasswordVC.swift
//  ecash
//
//  Created by phong070 on 11/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ForgotPasswordVC : BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var textFieldUsername : ICTextFieldNoneIcon!
    @IBOutlet weak var btnVerify : ICButton!
    let viewModel = ForgotPasswordViewModel()
    
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
        self.viewModel.doReadOnlyUsername()
        if let _ = CommonService.getShareUpdatedForgotPasswordCompleted(){
            CommonService.sendDataToUpdatedForgotPasswordCompleted(data: ForgotPasswordShareData(), isResponse: false)
            dismiss()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
        log(message: "viewWillDisappear======>")
    }
    
    @objc func actionVerify(){
        defineValue()
        self.viewModel.doSendOTP()
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldUsername {
            viewModel.username = textField.text ?? ""
        }
    }
}
