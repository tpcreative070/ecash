//
//  DestroyWalletSuccessfulOptions.swift
//  ecash
//
//  Created by phong070 on 11/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class DestroyWalletSuccessfulOptionsVC : BaseViewController {
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var viewPupup : UIView!
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var btnDone : ICButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @objc func actionDone(_ sender : UIButton){
        if let mData = CommonService.getShareUpdatedForgotPasswordCompleted() {
           CommonService.sendDataToUpdatedForgotPasswordCompleted(data:mData, isResponse: true)
        }else{
            Navigator.pushViewMainStoryboard(from: self, identifier: Controller.signin, isNavigation: false, present: true)
        }
        dismiss()
    }
    
}
