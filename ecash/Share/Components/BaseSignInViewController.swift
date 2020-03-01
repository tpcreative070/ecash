//
//  BaseLoginViewController.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
import GoogleSignIn
class BaseSignInViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func closeButtonPress() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func signInWithGoogle(){
        GIDSignIn.sharedInstance()?.scopes  = [GoogleScopes.DRIVE_FILE,GoogleScopes.DRIVE_APPDATA]
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signOutWithGoogle(){
        GIDSignIn.sharedInstance()?.signOut()
    }
    
    func hashAuthor(callback : @escaping (String,Bool) ->()){
        if GIDSignIn.sharedInstance()?.hasAuthInKeychain() ?? false{
            log(message: "Sign out")
            callback(LanguageHelper.getTranslationByKey(LanguageKey.SignOut) ?? "",true)
        }else{
            log(message: "Sign in")
            callback(LanguageHelper.getTranslationByKey(LanguageKey.SignInButton) ?? "",false)
        }
    }
}

extension BaseSignInViewController : GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
        log(message: "present view")
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
        log(message: "dismiss sign in")
    }
}
