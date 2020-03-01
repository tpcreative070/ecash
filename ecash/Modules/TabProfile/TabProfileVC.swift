//
//  TabProfileVC.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TabProfileVC : BaseViewController {
    @IBOutlet weak var imgAvatar : ICSwiftyAvatar!
    @IBOutlet weak var lbeCashId : ICLabel!
    @IBOutlet weak var lbeCashIdValue : ICLabel!
    @IBOutlet weak var lbFullName : ICLabel!
    @IBOutlet weak var lbFullNameValue : ICLabel!
    @IBOutlet weak var lbMyQRCode : ICLabel!
    @IBOutlet weak var lbChangePassword : ICLabel!
    @IBOutlet weak var lbChangePasswordValue : ICLabel!
    @IBOutlet weak var lbIdNumber : ICLabel!
    @IBOutlet weak var lbIdNumberValue : ICLabel!
    @IBOutlet weak var lbAvatar : ICLabel!
    @IBOutlet weak var viewChangePassword : UIView!
    @IBOutlet weak var lbLanguage : ICLabel!
    @IBOutlet weak var lbLanguageValue : ICLabel!
    @IBOutlet weak var lbPhone : ICLabel!
    @IBOutlet weak var lbPhoneValue : ICLabel!
    @IBOutlet weak var lbMail : ICLabel!
    @IBOutlet weak var lbMailValue : ICLabel!
    @IBOutlet weak var lbAddress : ICLabel!
    @IBOutlet weak var lbAddressValue : ICLabel!
    @IBOutlet weak var viewChangeLanguage : UIView!
    @IBOutlet weak var viewMyQRCode : UIView!
    @IBOutlet weak var viewFullName : UIView!
    @IBOutlet weak var viewIdnumber : UIView!
    @IBOutlet weak var viewMail : UIView!
    @IBOutlet weak var viewAddress : UIView!
    let viewModel = MyProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @objc func actionChangePassword(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.changePassword, isNavigation: false)
    }
    
    @objc func actionChangeLanguage(sender : UITapGestureRecognizer){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.multipleLanguages, isNavigation: false, isTransparent: true, present: true)
    }
    
    @objc func actionEditAvatar(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        CommonService.sendDataToGalleryOption(data: GalleryOptionsData(isAvatar: true), isResponse: false)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.editProfile, present: true)
    }
    
    @objc func actionMyQRCode(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.myQRCode, isNavigation: false, isTransparent: false, present: true)
    }
    
    @objc func actionFullname(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.editProfile, present: true)
    }
    
    @objc func actionIdNumber(sender : UITapGestureRecognizer){
        if !CommonService.isActiveAccount() {
            self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
            return
        }
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.editProfile, present: true)
    }
    
    @objc func actionMail(sender : UITapGestureRecognizer){
           if !CommonService.isActiveAccount() {
               self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
               return
           }
           Navigator.pushViewMainStoryboard(from: self, identifier: Controller.editProfile, present: true)
    }
    
    @objc func actionAddress(sender : UITapGestureRecognizer){
           if !CommonService.isActiveAccount() {
               self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.PleaseActiveAccountToUseThisFeature) ?? "")
               return
           }
           Navigator.pushViewMainStoryboard(from: self, identifier: Controller.editProfile, present: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.doBindingDataToView()
    }
    
    override func updateActionToView(data: String) {
        if data == EnumResponseToView.CHANGED_PASSWORD_SUCCESSFULLY.rawValue {
             Navigator.pushViewMainStoryboard(from: self, identifier: Controller.signin, isNavigation: false, isTransparent: false, present: true)
             tabBarController?.selectedIndex = 0
        }
    }
    
}
