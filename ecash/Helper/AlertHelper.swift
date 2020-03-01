//
//  AlertHelperd.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
struct AlertAction {
  let buttonTitle: String
  let handler: (() -> Void)?
}

struct SingleButtonAlert {
  let title: String
  let message: String?
  let action: AlertAction
}

protocol SingleButtonDialogPresenter {
  func presentSingleButtonDialog(alert: SingleButtonAlert)
}

extension SingleButtonDialogPresenter where Self: UIViewController {
  func presentSingleButtonDialog(alert: SingleButtonAlert) {
    let alertController = UIAlertController(title: alert.title,
                                            message: alert.message,
                                            preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: alert.action.buttonTitle,
                                            style: .default,
                                            handler: { _ in alert.action.handler?() }))
    self.present(alertController, animated: true, completion: nil)
  }
}

class AlertHelper {
  static func presentSingleButtonDialog(vc: UIViewController, alert: SingleButtonAlert) {
    let alertController = UIAlertController(title: alert.title,
                                            message: alert.message,
                                            preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: alert.action.buttonTitle,
                                            style: .default,
                                            handler: { _ in alert.action.handler?() }))
    vc.present(alertController, animated: true, completion: nil)
  }
    
    static func showErrorAlert(message: String){
        let alert = SingleButtonAlert(
            title: LanguageHelper.getTranslationByKey(LanguageKey.Error) ?? "Error",
            message: message,
            action: AlertAction(buttonTitle: "Ok", handler: {})
        )
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        let appWindow = appDelegate.window
        var topViewController = appWindow?.rootViewController
        while topViewController?.presentedViewController != nil
        {
            topViewController = topViewController?.presentedViewController
        }
        if (topViewController != nil) {
            presentSingleButtonDialog(vc: topViewController!, alert: alert)
        }
    }
}
