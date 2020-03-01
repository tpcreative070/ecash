//
//  SignUpVC.swift
//  ecash
//
//  Created by phong070 on 8/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class SignUpVC : BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var textFieldUsername : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldFullName : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldId : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldPhoneNumber : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldConfirmPassword : ICTextFieldNoneIcon!
    @IBOutlet weak var btnSignUp : ICButton!
    var viewModel : UserViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel()
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
    
    @objc func actionSignUp(){
        defineValue()
        viewModel.doSignUp()
    }
    
    func defineValue(){
        self.viewModel?.username = textFieldUsername.text
        self.viewModel?.fullName = textFieldFullName.text
        self.viewModel.id = textFieldId.text
        self.viewModel.phoneNumber = textFieldPhoneNumber.text
        self.viewModel.password = textFieldPassword.text
        self.viewModel.confirm = textFieldConfirmPassword.text
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        self.viewModel.focusTextField = textField
        if textField == textFieldUsername {
            viewModel?.username = textField.text ?? ""
            viewModel.doCheckingUsername()
        }
        else if textField == textFieldFullName {
            viewModel?.fullName = textField.text ?? ""
        }
        else if textField == textFieldId {
            viewModel.id = textField.text ?? ""
        }
        else if textField == textFieldPhoneNumber {
           viewModel.phoneNumber = textField.text ?? ""
           viewModel.doCheckingIdNumberAndPhoneNumber()
        }
        else if textField == textFieldPassword {
            viewModel.password = textField.text ?? ""
        }
        else{
            viewModel.confirm = textField.text ?? ""
        }
    }
}
