//
//  TransactionSuccessOptionsVC.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

class TransactionSuccessOptionsVC: BaseViewController {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var imgIcon: UIImageView!

    @IBOutlet weak var lbTitle: ICLabel!
    @IBOutlet weak var lbTitleAmount: ICLabel!
    @IBOutlet weak var lbAmount: ICLabel!
    @IBOutlet weak var lbTitleAccount: ICLabel!
    @IBOutlet weak var lbAccount: ICLabel!
    @IBOutlet weak var btHome: ICButton!
    
    weak var delegate: TransactionSuccessOptionsDelegate?
    var viewModel = TransactionSuccessOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    @objc func actionHome(sender: ICButton){
        dismiss(animated: true) {
            self.delegate?.transactionSuccessOptionsResult(true)
        }
    }
}

