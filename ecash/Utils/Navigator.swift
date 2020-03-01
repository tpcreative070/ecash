//
//  Navigator.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import UIKit
class Navigator {

    static func getViewController() ->Dictionary<String,NavigationModel>{
        var dic = Dictionary<String,NavigationModel>()
        dic[Controller.signin] = NavigationModel(storyBoard: UIStoryboard.author, identifier: Controller.signin)
        dic[Controller.signup] = NavigationModel(storyBoard: UIStoryboard.author, identifier: Controller.signup)
        dic[Controller.alert] = NavigationModel(storyBoard: UIStoryboard.author, identifier: Controller.alert)
        
        dic[Controller.addeCash] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.addeCash)
        dic[Controller.withdraweCash] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.withdraweCash)
        dic[Controller.exchangeeCash] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.exchangeeCash)
        dic[Controller.transfereCash] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.transfereCash)
        dic[Controller.withdraweCashMultiple] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.withdraweCashMultiple)
        dic[Controller.transfereCashMultiple] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.transfereCashMultiple)
        dic[Controller.scannerResult] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.scannerResult)
        dic[Controller.scanner] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.scanner)
        dic[Controller.contact] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.contact)
        dic[Controller.qrCodeHistory] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.qrCodeHistory)
        dic[Controller.exchangeeCashOptions] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.exchangeeCashOptions)
        dic[Controller.addContact] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.addContact)
        dic[Controller.editContact] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.editContact)
        dic[Controller.transactionFilter] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.transactionFilter)
        dic[Controller.transactionLogsDetail] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.transactionLogsDetail)
        dic[Controller.payTo] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.payTo)
        dic[Controller.toPay] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.toPay)
        dic[Controller.toPayQR] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.toPayQR)
        dic[Controller.requirePaymentOptions] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.requirePaymentOptions)
        dic[Controller.transactionFailureOptions] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.transactionFailureOptions)
        dic[Controller.transactionSuccessOptions] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.transactionSuccessOptions)
        dic[Controller.infoTransactionOptions] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.infoTransactionOptions)
        
        dic[Controller.signOutOptions] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.signOutOptions)
        dic[Controller.destroyWalletOptions] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.destroyWalletOptions)
        dic[Controller.destroyWalletSuccessfulOptions] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.destroyWalletSuccessfulOptions)
        dic[Controller.changePassword] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.changePassword)
        dic[Controller.forgotPassword] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.forgotPassword)
        dic[Controller.forgotPasswordOTPOptions] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.forgotPasswordOTPOptions)
        dic[Controller.recoverPassword] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.recoverPassword)
        dic[Controller.multipleLanguages] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.multipleLanguages)
        dic[Controller.myQRCode] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.myQRCode)
        dic[Controller.intro] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.intro)
        dic[Controller.notificationHistory] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.notificationHistory)
        dic[Controller.exchangeeCashOverviewOptions] = NavigationModel(storyBoard: UIStoryboard.main, identifier: Controller.exchangeeCashOverviewOptions)
        dic[Controller.helpSupport] = NavigationModel(storyBoard: UIStoryboard.settings, identifier: Controller.helpSupport)
        
        dic[Controller.editProfile] = NavigationModel(storyBoard: UIStoryboard.author, identifier: Controller.editProfile)
        dic[Controller.galleryOptions] = NavigationModel(storyBoard: UIStoryboard.author, identifier: Controller.galleryOptions)
        
        dic[Controller.lixi] = NavigationModel(storyBoard: UIStoryboard.lixi, identifier: Controller.lixi)
        dic[Controller.sendLixi] = NavigationModel(storyBoard: UIStoryboard.lixi, identifier: Controller.sendLixi)
        dic[Controller.receiveLixiOptions] = NavigationModel(storyBoard: UIStoryboard.lixi, identifier: Controller.receiveLixiOptions)
        return dic
    }
    
    static func pushViewMainStoryboard<T : UIViewController>(from : T,identifier : String, isNavigation : Bool = false, isTransparent : Bool = false, present : Bool = false){
        if let value = getViewController()[identifier]{
            let storyboard = value.storyBoard
            let viewController = storyboard.instantiateViewController(withIdentifier: value.identifier)
            viewController.modalPresentationStyle = .fullScreen
            if isTransparent{
                 viewController.modalPresentationStyle = .overCurrentContext
            }
            present ? ( isNavigation ? from.navigationController?.pushViewController(viewController, animated: true) : from.present(viewController, animated: true,completion: nil)) :  (isNavigation ? from.navigationController?.pushViewController(viewController, animated: true) : from.navigationController?.present(viewController, animated: true,completion: nil))
        }
    }
    
    // Make sure setup get call pushPopupPresent
    static func getPopupViewControler<T: BaseViewController>(identifier : String) -> T {
        if let value = getViewController()[identifier]{
            let storyboard = value.storyBoard
            let popup = storyboard.instantiateViewController(withIdentifier: value.identifier) as! T
            popup.modalPresentationStyle = .overCurrentContext
            return popup
        }
        return T()
    }
    
    static func pushPopupPresent<F: BaseViewController, T: BaseViewController>(viewController: F, popupController: inout T){
        viewController.present(popupController, animated: true)
    }
}
