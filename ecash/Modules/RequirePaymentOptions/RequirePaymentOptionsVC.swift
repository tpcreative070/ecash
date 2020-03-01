//
//  RequirePaymentOptionsVC.swift
//  ecash
//
//  Created by ECAPP on 1/13/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
class RequirePaymentOptionsVC: BaseViewController {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: ICLabel!
    @IBOutlet weak var lbTitleAccountECash: ICLabel!
    @IBOutlet weak var lbTitleName: ICLabel!
    @IBOutlet weak var lbTitleRequire: ICLabel!
    @IBOutlet weak var lbTitleAmount: ICLabel!
    @IBOutlet weak var lbTitleWith: ICLabel!
    @IBOutlet weak var lbTitleContent: ICLabel!
    
    @IBOutlet weak var btConfirm: ICButton!
    
    weak var delegate: RequirePaymentOptionsDelegate?
    var viewModel = RequirePaymentOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    @objc func actionConfirm(sender: ICButton){
        dismiss(animated: true) {
            self.delegate?.requirePaymentOptionsResult(self.viewModel.socketRequestPaytoModel)
        }
    }
}
