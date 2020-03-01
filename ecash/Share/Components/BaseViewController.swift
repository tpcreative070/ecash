//
//  BaseViewController.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
import GoogleSignIn

extension Notification.Name {
    static let didRecieveUnauthorized = Notification.Name("didRecieveUnauthorized")
    static let didRequestApi = Notification.Name("didRequestApi")
}

class EventBusObjectData: NSObject {
    var data: Any
    var type: String
    var identify: EnumViewControllerNameIdentifier
    
    /**
        data: content value
        type: use to point out which type data is
        identify: The name of ViewController will observe event bus
     */
    init(data: Any, type: String, identify: EnumViewControllerNameIdentifier) {
        self.data = data
        self.type = type
        self.identify = identify
    }
}

class BaseViewController: UIViewController {
    var keyboardHelper: KeyboardHelper?
    var isAuto : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUnauthorized), name: .didRecieveUnauthorized, object: nil)
        registerEventBus()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func registerEventBus(){
        SwiftEventBusHelper.onMainThread(self, name:ConfigKey.RequestUpdateeDong) { result in
            self.requestUpdateeDong()
            self.log(message: "Request update eDong")
        }
        
        SwiftEventBusHelper.onMainThread(self, name:ConfigKey.RequestQRCodeResult) { result in
            let mResult : ReceiveQRCodeData = result?.object as! ReceiveQRCodeData
            self.scannerResult(data: mResult)
            self.log(message: "Request update qrscanner")
        }
        
        SwiftEventBusHelper.onMainThread(self, name:ConfigKey.DismissView) { result in
            self.closeTransaction()
        }
        
        SwiftEventBusHelper.onMainThread(self, name:ConfigKey.RequestCheckAvailableNotification) { result in
            self.requestCheckAvailableNotification()
        }
        
        SwiftEventBusHelper.onMainThread(self, name:ConfigKey.RequestNavigationNotificationHistory) { result in
            self.requestNavigationToNotificationHistory()
        }
        
        SwiftEventBusHelper.onMainThread(self, name: ConfigKey.RequestSaveToPhotos) { (result) in
            let mResult = result?.object as? String ?? ""
            if let mData = QRCodeHelper.shared.generateDataQRCode(from: mResult){
                self.requestSaveToPho(image: mData)
            }
        }
        
        SwiftEventBusHelper.onMainThread(self, name: ConfigKey.ActionToView) { (result) in
            let mResult = result?.object as? String ?? ""
            self.updateActionToView(data: mResult)
        }
        
        SwiftEventBusHelper.onMainThread(self, name: ConfigKey.ActionToObjectView) { (result) in
            let mResult = result?.object as! EventBusObjectData
            self.updateActionToObjectView(obj: mResult)
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
    }
    
    func doDismiss(){
        view.endEditing(true)
    }
    
    func scannerResult(data : ReceiveQRCodeData){
        
    }
    
    @objc func requestCheckAvailableNotification(){
        
    }
    
    @objc func requestNavigationToNotificationHistory(){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.notificationHistory, isNavigation: false)
    }
    
    @objc func dismissViewEventBus(){
        SwiftEventBusHelper.postToMainThread(ConfigKey.DismissView)
    }
    
    @objc func handleUnauthorized() {
        DispatchQueue.main.async {
            debugPrint("Need to re sigin in")
            //GlobalRequestApiHelper.shared.doReSignIn()
            // self.onDoAlertExpiredSession()
            let appDelegate = UIApplication.shared.delegate  as! AppDelegate
            let appWindow = appDelegate.window
            var topViewController = appWindow?.rootViewController
            while topViewController?.presentedViewController != nil
            {
                topViewController = topViewController?.presentedViewController
            }
            if(topViewController != nil){
                let className = NSStringFromClass(topViewController!.classForCoder)
                if (className != Controller.classNameSignInVC) {
                    debugPrint("xxxxxxxxxxxxxxxxxxxxxxxx Old Login xxxxxxxxxxxxxxxxxxxxxxxx")
                    CommonService.signOutGlobal()
                    Navigator.pushViewMainStoryboard(from: self, identifier: Controller.signin, isNavigation: false, isTransparent: false, present: true)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .didRecieveUnauthorized, object: nil)
        if isBeingDismissed{
            SwiftEventBusHelper.unregister(self)
            closeViewController()
        }
    }
    
    @objc func closeTransaction(){
        
    }
    
    @objc func requestUpdateeDong(){
        
    }
    
    @objc func updateActionToView(data : String){
        
    }
    
    // Function for Sub class to override
    @objc func updateActionToObjectView(obj: EventBusObjectData){
           
    }
    
    @objc func requestSaveToPho(image : UIImage){
        
    }
    
    @objc func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeViewController(){
    }

    @objc func log(message : String){
        Utils.logMessage(message: message)
    }
    
    @objc func log(object : Any){
        Utils.logMessage(object:object)
    }
    
    func addCloseRightBlackButton(){
        let navButton = Helper.addCloseBlackButton(self.view)
        self.view.bringSubviewToFront(navButton!)
        navButton?.addTarget(self, action: #selector(closeButtonPress), for: .touchUpInside)
    }
    
    func addCloseLeftBlackButton(){
        let navButton = Helper.addCloseLeftBlackButton(self.view)
        self.view.bringSubviewToFront(navButton!)
        navButton?.addTarget(self, action: #selector(closeButtonPress), for: .touchUpInside)
    }
    
    func addCloseLeftWhiteButton(){
        let navButton = Helper.addCloseLeftWhiteButton(self.view)
        self.view.bringSubviewToFront(navButton!)
        navButton?.addTarget(self, action: #selector(closeButtonPress), for: .touchUpInside)
    }
    
    func addLeftBackButton(){
        let navButton = Helper.addLeftBackButton(self.view)
        self.view.bringSubviewToFront(navButton!)
        navButton?.addTarget(self, action: #selector(closeButtonPress), for: .touchUpInside)
    }
    
    func addLeftBackGrayButton(){
        let navButton = Helper.addLeftBackGrayButton(self.view)
        self.view.bringSubviewToFront(navButton!)
        navButton?.addTarget(self, action: #selector(closeButtonPress), for: .touchUpInside)
    }
    
    func addButtonCustom(image : UIImage, isLeft : Bool){
        let navButton = Helper.addButtonCustom(self.view, isLeft: isLeft, image: image)
        self.view.bringSubviewToFront(navButton!)
        if isLeft {
            navButton?.addTarget(self, action: #selector(actionLeft), for: .touchUpInside)
        }else{
            navButton?.addTarget(self, action: #selector(actionRight), for: .touchUpInside)
        }
    }
    
    func addButtonSpecialCustom(image : UIImage, isLeft : Bool) -> UIButton?{
        let navButton = Helper.addButtonCustom(self.view, isLeft: isLeft, image: image)
        self.view.bringSubviewToFront(navButton!)
        if isLeft {
            navButton?.addTarget(self, action: #selector(actionLeft), for: .touchUpInside)
        }else{
            navButton?.addTarget(self, action: #selector(actionRight), for: .touchUpInside)
        }
        return navButton
    }
    
    func addButtonSpecialCustom(text : String, isLeft : Bool) -> UIButton?{
          let navButton = Helper.addButtonCustom(self.view, isLeft: isLeft, text: text)
          self.view.bringSubviewToFront(navButton!)
          if isLeft {
              navButton?.addTarget(self, action: #selector(actionLeft), for: .touchUpInside)
          }else{
              navButton?.addTarget(self, action: #selector(actionRight), for: .touchUpInside)
          }
          return navButton
    }
      
    
    @objc func actionLeft(){
        
    }
    
    @objc func actionRight(){
        
    }
    
    @objc func closeButtonPress(){
        
    }
    
    @objc func isSignInViewController() -> Bool {
        return false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    func addBackgroundStatusBar(){
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = AppColors.BLUE
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    func refreshToken(){
        guard let signIn = GIDSignIn.sharedInstance() else { fatalError() }
        signIn.scopes = [GoogleScopes.DRIVE_APPDATA, GoogleScopes.DRIVE_FILE]
        signIn.clientID = ConfigKey.GoogleClientId.infoForKey()
        signIn.delegate = self
        if signIn.hasAuthInKeychain() {
            DispatchQueue.main.async {
                signIn.signInSilently()
            }
        }
    }
    
    func onDoAlertExpiredSession(){
        let alertController = UIAlertController(title: LanguageHelper.getTranslationByKey(LanguageKey.Error), message: LanguageHelper.getTranslationByKey(LanguageKey.SessionExpried), preferredStyle: .alert)
        let okAction = UIAlertAction(title:  LanguageHelper.getTranslationByKey(LanguageKey.SignIn), style: UIAlertAction.Style.default) {
            UIAlertAction in
            CommonService.signOutGlobal()
            Navigator.pushViewMainStoryboard(from: self, identifier: Controller.signin, isNavigation: false, present: true)
            NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: LanguageHelper.getTranslationByKey(LanguageKey.Cancel), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func onAlertComingSoon(){
        let alertController = UIAlertController(title: LanguageHelper.getTranslationByKey(LanguageKey.Alert), message: LanguageHelper.getTranslationByKey(LanguageKey.ThisFeatureComingSoon), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Ok Pressed")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func onAlertMessage(value : String){
        let alertController = UIAlertController(title: LanguageHelper.getTranslationByKey(LanguageKey.Alert), message: value, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LanguageHelper.getTranslationByKey(LanguageKey.Ok), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Ok Pressed")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func shareFile(images : [UIImage]){
        let shareAll = images
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func doAlertMessage(permission : String){
        let message = String(format: LanguageHelper.getTranslationByKey(LanguageKey.AskPermissionAlert) ?? "", arguments: [permission])
        let alert = UIAlertController(title: LanguageHelper.getTranslationByKey(LanguageKey.AskPermission), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: LanguageHelper.getTranslationByKey(LanguageKey.Yes), style: UIAlertAction.Style.default, handler: { action in
            self.actionAlertYes()
        }))
        alert.addAction(UIAlertAction(title: LanguageKey.No, style: UIAlertAction.Style.cancel, handler: { action in
            self.actionAlertNo()
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func doAlertMessage(message : String){
        let alert = UIAlertController(title: LanguageHelper.getTranslationByKey(LanguageKey.Alert), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: LanguageHelper.getTranslationByKey(LanguageKey.Yes), style: UIAlertAction.Style.default, handler: { action in
            self.actionAlertYes()
        }))
        alert.addAction(UIAlertAction(title:  LanguageHelper.getTranslationByKey(LanguageKey.No), style: UIAlertAction.Style.cancel, handler: { action in
            self.actionAlertNo()
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionAlertYes(){
        
    }
    
    @objc func actionAlertNo(){
        
    }
    
    func checkSessionExpired(){
        GlobalRequestApiHelper.shared.checkSessionExpired { (isValidate) in }
    }
}
extension BaseViewController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            debugPrint("\(error.localizedDescription)")
        } else {
            debugPrint(user.authentication.accessToken ?? "")
            debugPrint(user.profile.email ?? "")
            if let email = signIn.currentUser.profile.email , let user = signIn.currentUser.authentication{
                let mSignIn = SignInStoreModel()
                CommonService.setSignInData(storeInfo: mSignIn)
            }
            if isSignInViewController(){
                print("dismiss")
                dismiss()
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        debugPrint("Disconnected with app")
    }
}
