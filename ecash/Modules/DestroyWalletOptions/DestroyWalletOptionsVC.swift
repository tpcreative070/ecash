//
//  DestroyWalletVC.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class DestroyWalletOptionsVC : BaseViewController {
    
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var viewPupup : UIView!
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var btneCashToeCash : ICButton!
    @IBOutlet weak var btnWithdraweCash : ICButton!
    @IBOutlet weak var btnExit : ICButton!
    
    let viewModel = DestroyWalletOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
    }
    
    @objc func actioneCashToeCash(_ sender : UIButton){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transfereCashMultiple, isNavigation: false, present: true)
        dismiss()
    }
    
    @objc func actionWithdraweCash(_ sender : UIButton){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.withdraweCashMultiple, isNavigation: false, present: true)
        dismiss()
    }
    
    @objc func actionExit(_ sender : UIButton){
        dismiss()
    }
    
}
