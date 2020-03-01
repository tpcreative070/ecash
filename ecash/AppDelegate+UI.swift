//
//  AppDelegate+UI.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension AppDelegate {
    func initTabBarController(selectedIndex: Int?){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard : UIStoryboard = UIStoryboard(name: Storyboard.main, bundle: nil)
     
        let nav1 = UINavigationController()
        let home = storyboard.instantiateViewController(withIdentifier: Controller.home) as! HomeVC
        nav1.viewControllers = [home]
        nav1.tabBarItem = UITabBarItem(title: LanguageHelper.getTranslationByKey(LanguageKey.Home), image: UIImage(named:AppImages.IC_HOME), tag: 1)

        let nav2 = UINavigationController()
        let contact = storyboard.instantiateViewController(withIdentifier: Controller.contact) as! ContactVC
        nav2.viewControllers = [contact]
        nav2.tabBarItem = UITabBarItem(title: LanguageHelper.getTranslationByKey(LanguageKey.Contact), image: UIImage(named: AppImages.IC_CONTACT), tag: 1)

        let nav3 = UINavigationController()
        let scanner = storyboard.instantiateViewController(withIdentifier: Controller.scanner) as! ScannerVC
        nav3.viewControllers = [scanner]
        //let tab3 = UITabBarItem(title: nil, image: UIImage(named:AppImages.IC_SCANNER)?.resizeImage(targetSize: CGSize(width: 40, height: 40)), tag:1)
        //tab3.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        nav3.tabBarItem = UITabBarItem(title: LanguageHelper.getTranslationByKey(LanguageKey.Scanner), image: UIImage(named:AppImages.IC_SCAN), tag:1)
        
        let nav4 = UINavigationController()
        let transaction = storyboard.instantiateViewController(withIdentifier: Controller.transaction) as! TransactionLogVC
        nav4.viewControllers = [transaction]
        nav4.tabBarItem = UITabBarItem(title: LanguageHelper.getTranslationByKey(LanguageKey.Transaction), image: UIImage(named:AppImages.IC_TRANSACTION), tag:1)
        
        let nav5 = UINavigationController()
        let myWallet = storyboard.instantiateViewController(withIdentifier: Controller.myWallet) as! MyWalletVC
        nav5.viewControllers = [myWallet]
        nav5.tabBarItem = UITabBarItem(title: LanguageHelper.getTranslationByKey(LanguageKey.MyWallet), image: UIImage(named:AppImages.IC_WALLET), tag:1)
       
        let tabs = UITabBarController()
        tabs.viewControllers = [nav1, nav2, nav3,nav4,nav5]
        tabs.tabBar.unselectedItemTintColor = AppColors.GRAY
        tabs.selectedIndex = selectedIndex!
      
        UITabBar.appearance().tintColor = AppColors.BLUE
        UITabBar.appearance().barTintColor = AppColors.WHITE_COLOR
        UITabBar.appearance().unselectedItemTintColor = AppColors.GRAY
      
        self.window!.rootViewController = tabs;
        self.window?.makeKeyAndVisible();
    }
    
    func onDoAlert(value : String){
        let alertController = UIAlertController(title: LanguageHelper.getTranslationByKey(LanguageKey.SocketConnectError), message: value, preferredStyle: .alert)
        let okAction = UIAlertAction(title:  LanguageHelper.getTranslationByKey(LanguageKey.TryAgain), style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            WebSocketClientHelper.instance.connect()
        }
        let cancelAction = UIAlertAction(title: LanguageHelper.getTranslationByKey(LanguageKey.Cancel), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @objc func onPayToRequest(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            if let socketRequestPaytoModel: SocketRequestPaytoModel = data["obj"] as? SocketRequestPaytoModel {
//                let totalAmount = Int64(socketRequestPaytoModel.totalAmount)
                let appDelegate = UIApplication.shared.delegate  as! AppDelegate
                let appWindow = appDelegate.window
                var topViewController = appWindow?.rootViewController
                while topViewController?.presentedViewController != nil
                {
                    topViewController = topViewController?.presentedViewController
                }
//                if let eCashBalance = SQLHelper.getTotaleCash(){
//
//                    if (eCashBalance >= totalAmount ?? 0) {
                        // Handle Request Payto From Socket if balance is greater than amount
                        let popup: RequirePaymentOptionsVC = Navigator.getPopupViewControler(identifier: Controller.requirePaymentOptions)
                        popup.delegate = appDelegate
                        let userService = UserService()
                        userService.getWalletInfo(data: WalletInfoRequestModel(walletId: socketRequestPaytoModel.sender)) {
                            result in
                                switch result {
                                    case .success(let result) :
                                        if let response = result{
                                            if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                                                let data = response.responseData
                                                let personFirstName = data.personFirstName ?? ""
                                                let personMiddleName = data.personMiddleName ?? ""
                                                let personLastName = data.personLastName ?? ""
                                                let fullName = "\(personFirstName) \(personMiddleName) \(personLastName)"
                                                popup.viewModel.customerNameValue = fullName
                                                popup.viewModel.eCashIdSender = socketRequestPaytoModel.sender
                                                popup.viewModel.amountValue = Int(socketRequestPaytoModel.totalAmount)
                                                popup.viewModel.contentValue = socketRequestPaytoModel.content
                                                topViewController?.present(popup, animated: true, completion: nil)
                                                var model = socketRequestPaytoModel
                                                model.fullName = fullName
                                                popup.viewModel.socketRequestPaytoModel = model
                                            }
                                        }
                                        break
                                    case .failure( let error ):
                                        dump(error)
                                        
                                        break
                                }
                        }
//                    } else {
//                        // Handle Request Payto From Socket if balance is lesster than amount
//                        let popup: TransactionFailureOptionsVC = Navigator.getPopupViewControler(identifier: Controller.transactionFailureOptions)
//                        popup.delegate = appDelegate
//                        topViewController?.present(popup, animated: true, completion: nil)
//                    }
//                }
            }
        }
    }
    
    @objc func onToPayInfoPayment(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            let tranfer: TransferDataModel = data["obj"] as! TransferDataModel
            let totalAmount = Int64(tranfer.totalAmount ?? "0")
            if let eCashBalance = SQLHelper.getTotaleCash(){
                // Handle Request Payto From Socket if balance is greater than amount
                let appDelegate = UIApplication.shared.delegate  as! AppDelegate
                let appWindow = appDelegate.window
                var topViewController = appWindow?.rootViewController
                while topViewController?.presentedViewController != nil
                {
                    topViewController = topViewController?.presentedViewController
                }
                if (eCashBalance >= totalAmount ?? 0) {
                    var socketRequestPaytoModel: SocketRequestPaytoModel = SocketRequestPaytoModel(
                            sender: tranfer.sender ?? "",
                            receiver: tranfer.receiver ?? "",
                            time: tranfer.time ?? "",
                            type: tranfer.type ?? "",
                            content: tranfer.content ?? "",
                            senderPublicKey: tranfer.senderPublicKey ?? "",
                            totalAmount: tranfer.totalAmount ?? "",
                            channelSignature: tranfer.channelSignature ?? "",
                            fullName: tranfer.fullName ?? ""
                        )
//                    print("========================< onToPayInfoPayment socketRequestPaytoModel >========================")
//                    dump(socketRequestPaytoModel)
                    let popup: InfoTransactionOptionsVC = Navigator.getPopupViewControler(identifier: Controller.infoTransactionOptions)
                    popup.delegate = appDelegate
                    let userService = UserService()
                    userService.getWalletInfo(data: WalletInfoRequestModel(walletId: socketRequestPaytoModel.sender)) {
                        result in
                            switch result {
                                case .success(let result) :
                                    if let response = result{
                                        if response.responseCode == EnumResponseCode.EXISTING_VALUE.rawValue {
                                            let data = response.responseData
//                                            print("========================< delege data 1 >========================")
//                                            dump(data)
                                            let personFirstName = data.personFirstName ?? ""
                                            let personMiddleName = data.personMiddleName ?? ""
                                            let personLastName = data.personLastName ?? ""
                                            let fullName = "\(personFirstName) \(personMiddleName) \(personLastName)"
                                            socketRequestPaytoModel.fullName = fullName
                                            topViewController?.present(popup, animated: true, completion: nil)
                                            popup.viewModel.socketRequestPaytoModel = socketRequestPaytoModel
                                        }
                                    }
                                    break
                                case .failure( let error ):
                                    dump(error)
                                    
                                    break
                            }
                    }
                } else {
                    // Handle Request Payto From Socket if balance is lesster than amount
                    let popup: TransactionFailureOptionsVC = Navigator.getPopupViewControler(identifier: Controller.transactionFailureOptions)
                    popup.delegate = appDelegate
                    topViewController?.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
}

extension AppDelegate: RequirePaymentOptionsDelegate{
    func requirePaymentOptionsResult(_ socketRequestPaytoModel: SocketRequestPaytoModel?) {
//        print("========================< delegate popupRequirePaymentResult >========================")
//        dump(socketRequestPaytoModel)
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let appWindow = appDelegate.window
        var topViewController = appWindow?.rootViewController
        while topViewController?.presentedViewController != nil
        {
            topViewController = topViewController?.presentedViewController
        }
        if let eCashBalance = SQLHelper.getTotaleCash(){
            let totalAmount = Int64(socketRequestPaytoModel?.totalAmount ?? "0")
            if (eCashBalance >= totalAmount ?? 0) {
                let popup: InfoTransactionOptionsVC = Navigator.getPopupViewControler(identifier: Controller.infoTransactionOptions)
                popup.delegate = appDelegate
                topViewController?.present(popup, animated: true, completion: nil)
                popup.viewModel.socketRequestPaytoModel = socketRequestPaytoModel
           
            } else {
                // Handle Request Payto From Socket if balance is lesster than amount
                let popup: TransactionFailureOptionsVC = Navigator.getPopupViewControler(identifier: Controller.transactionFailureOptions)
                popup.delegate = appDelegate
                topViewController?.present(popup, animated: true, completion: nil)
            }
        }
    }
}

extension AppDelegate: TransactionFailureOptionsDelegate{
    func transactionFailureOptionsResult(_ isSuccess: Bool?) {
        print("delegate popupTransactionFailureOptionsResult ========================> \(String(describing: isSuccess))")
    }
}

extension AppDelegate: InfoTransactionOptionsDelegate{
    func infoTransactionOptionsResult(_ isSuccess: Bool?, account: String, amount: String) {
        print("========================< delegate InfoTransactionOptionsResult Done <========================")
        let status = isSuccess ?? false
        if(status){
            let appDelegate = UIApplication.shared.delegate  as! AppDelegate
            let appWindow = appDelegate.window
            var topViewController = appWindow?.rootViewController
            while topViewController?.presentedViewController != nil
            {
                topViewController = topViewController?.presentedViewController
            }
            let popup: TransactionSuccessOptionsVC = Navigator.getPopupViewControler(identifier: Controller.transactionSuccessOptions)
            popup.delegate = appDelegate
            topViewController?.present(popup, animated: true, completion: nil)
            popup.viewModel.account.value = account
            popup.viewModel.amount.value = amount
        }
    }
}

extension AppDelegate: TransactionSuccessOptionsDelegate{
    func transactionSuccessOptionsResult(_ isSuccess: Bool?) {
        print("delegate popupTransactionSuccessOptionsResult ========================> \(String(describing: isSuccess))")
    }
}
