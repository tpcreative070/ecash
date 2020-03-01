//
//  SignOutVC.swift
//  ecash
//
//  Created by phong070 on 11/8/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class SignOutOptionsVC : BaseViewController {
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var viewPupup : UIView!
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var btnYes : ICButton!
    @IBOutlet weak var btnNo : ICButton!
    let viewModel = SignOutOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
    }
    
    @objc func actionYes(_ sender : UIButton){
        self.viewModel.doSignOut()
    }
    
    @objc func actionNo(_ sender : UIButton){
        dismiss()
    }
}
