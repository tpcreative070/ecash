//
//  TabWalletVC.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TabWalletVC : BaseViewController {
    @IBOutlet weak var imgAvatar : ICSwiftyAvatar!
    @IBOutlet weak var lbFullname : ICLabel!
    @IBOutlet weak var lbeCashId : ICLabel!
    @IBOutlet weak var lbBalance : ICLabel!
    @IBOutlet weak var imgHelp : UIImageView!
    @IBOutlet weak var lbHelp : ICLabel!
    @IBOutlet weak var imgNextHelp : UIImageView!
    
    @IBOutlet weak var imgCloseAccount : UIImageView!
    @IBOutlet weak var lbCloseAccount : ICLabel!
    @IBOutlet weak var imgNextCloseAccount : UIImageView!
    
    @IBOutlet weak var imgExitAccount : UIImageView!
    @IBOutlet weak var lbExitAccount : ICLabel!
    @IBOutlet weak var imgNextExitAccount : UIImageView!
    @IBOutlet weak var viewHelp : UIView!
    @IBOutlet weak var viewDelete : UIView!
    @IBOutlet weak var viewSignOut : UIView!
    
    let viewModel = MyWalletViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @objc func actionChangePassword(sender : UITapGestureRecognizer){
       onAlertComingSoon()
    }
    
    @objc func actionHelp(sender : UITapGestureRecognizer ){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.helpSupport, isNavigation: false, present: true)
    }
    
    @objc func actionDelete(sender : UITapGestureRecognizer){
       if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
       }
       self.viewModel.doCheckeCashBalance()
    }
    
    @objc func actionSignOut(sender: UITapGestureRecognizer){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.signOutOptions, isNavigation: false, isTransparent: true, present: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        log(message: "TabWallet ViewDidDisappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        log(message: "TabWallet viewDidAppear")
        viewModel.userProfile = Bindable(UserProfileViewModel())
        viewModel.doBindingDataToView(data: nil)
    }
    
    override func actionAlertYes() {
        viewModel.doDeleteAccount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       doCheckSignOut()
       self.viewModel.doBindingDataToView()
    }
}
