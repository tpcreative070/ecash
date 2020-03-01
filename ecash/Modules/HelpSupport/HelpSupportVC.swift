//
//  HelpSupportVC.swift
//  ecash
//
//  Created by phong070 on 12/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import WebKit

enum CustomScreenHelper {
  case FromLogin
  case FromMenu
  case FromRegister
}

class HelpSupportVC : BaseViewController {
    
    var fromScreen: CustomScreenHelper?
    let defaultUrl = "http://ecpay.vn/"
    fileprivate var spinner: UIView?
    @IBOutlet weak var viewLoading : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
        addCloseRightBlackButton()
    }
    
    override func closeButtonPress() {
        dismiss()
    }
          
}
