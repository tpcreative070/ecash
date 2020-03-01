//
//  AlertVC.swift
//  ecash
//
//  Created by phong070 on 9/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class AlertVC : BaseViewController {
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var imgError : UIImageView!
    @IBOutlet weak var lbMessage : ICLabel!
    @IBOutlet weak var btnClose : ICButton!
    @IBOutlet weak var btnContinue : ICButton!
    var data : PassDataViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @objc func actionClose(){
        debugPrint("Close")
        if data.identifier == EnumPassdata.ALERT.rawValue {
            let alert = data.alert
            if alert.codeAction == EnumResponseAction.ERROR_USERNAME.rawValue || alert.codeAction == EnumResponseAction.ERROR_IDNUMBER_PHONENUMBER.rawValue {
                ShareSignUpSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.SIGNUP_RESPONSE, response: SignUpResponse(navigation: "")))
                ShareSignUpSingleton.shared.bindData()
                debugPrint("EnumResponseAction.ERROR_USERNAME")
            }
            else if alert.codeAction == EnumResponseAction.EXISTING_USERNAME.rawValue {
                ShareSignUpSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.SIGNUP_RESPONSE, response: SignUpResponse(navigation: EnumResponseAction.EXISTING_USERNAME.rawValue)))
                ShareSignUpSingleton.shared.bindData()
                debugPrint("EnumResponseAction.EXISTING_USERNAME")
            }
            else if alert.codeAction == EnumResponseAction.CREATED_SUCCESSFULLY.rawValue{
                    ShareSignUpSingleton.shared.set(value: PassDataViewModel(identifier: EnumPassdata.SIGNUP_RESPONSE, response: SignUpResponse(navigation: EnumResponseAction.CREATED_SUCCESSFULLY.rawValue)))
                    ShareSignUpSingleton.shared.bindData()
            }
        }
        else if data.identifier == EnumPassdata.ECASH_TO_ECASH.rawValue{
            dismissViewEventBus()
            debugPrint("Action here..")
        }
        else if data.identifier == EnumPassdata.ECASH_TO_EDONG.rawValue {
            dismissViewEventBus()
            debugPrint("Action here...")
        }
        else if data.identifier == EnumPassdata.EDONG_TO_ECASH.rawValue {
             dismissViewEventBus()
        }else if data.identifier == EnumPassdata.EXCHANGE_CASH.rawValue {
             dismissViewEventBus()
        }
        dismiss()
    }
    
    @objc func actionContinue(){
        debugPrint("actionContinue")
        dismiss()
    }
}
