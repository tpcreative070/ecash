//
//  SignInVC.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit
class SignInVC: BaseSignInViewController {
   
    @IBOutlet weak var constraintUsername: NSLayoutConstraint!
    @IBOutlet weak var constraintView: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var onSignInAction: ICButton!
    @IBOutlet weak var textFieldPassword: ICTextFieldWithIcon!
    @IBOutlet weak var textFieldEmail: ICTextFieldWithIcon!
    @IBOutlet weak var lbNoAccount : ICLabel!
    @IBOutlet weak var lbSignUpNow : ICLabel!
    @IBOutlet weak var lbCouldNotSignIn : ICLabel!
    @IBOutlet weak var imgLogo : UIImageView!
    @IBOutlet weak var viewSignUp : UIView!
    @IBOutlet weak var viewAlreadyExisted : UIView!
    @IBOutlet weak var imgAvatar : ICSwiftyAvatar!
    @IBOutlet weak var lbFullname : ICLabel!
    @IBOutlet weak var lbPhoneNumber : ICLabel!
    
    var viewModel : UserViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserViewModel()
        self.setupDelegate()
        initUI()
        bindingViewModel()
        CommonService.initSQLine()
        //CommonService.UpdateBlockChains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
        viewModel?.doReadOnlyUsername()
        log(message: "viewWillAppear======>")
        
        if let mData = CommonService.getSignUpStoreData() {
            log(object: mData)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
        log(message: "viewWillDisappear======?>")
    }
    
    @objc func loginTapped(_ sender: UIButton) {
        defineValue()
        viewModel?.doLogin()
    }
    
    @objc func actionSignUp(sender : UITapGestureRecognizer){
        debugPrint("SignUp")
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.signup, isNavigation: false, present: true)
    }
    
    @objc func actionCouldNotSignIn(sender : UITapGestureRecognizer){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.forgotPassword, isNavigation: false, isTransparent: false, present: true)
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldEmail {
            viewModel?.username = textField.text ?? ""
        }
        else if textField == textFieldPassword {
            viewModel?.password = textField.text ?? ""
        }
    }
    
    override func isSignInViewController() -> Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        log(message: "viewDidDisappear======>")
    }
    
    override func actionAlertYes() {
        self.viewModel?.doResendOTP()
    }
    
}
