//
//  TransactionFailureOptionsVC.swift
//  ecash
//
//  Created by ECAPP on 1/13/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

class TransactionFailureOptionsVC: BaseViewController {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: ICLabel!
    @IBOutlet weak var lbText1: ICLabel!
    @IBOutlet weak var lbContent: ICLabel!
    @IBOutlet weak var lbText2: ICLabel!
    @IBOutlet weak var btClose: ICButton!
    
    weak var delegate: TransactionFailureOptionsDelegate?
    var viewModel = TransactionFailureOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    @objc func actionClose(sender: ICButton){
        dismiss(animated: true) {
            self.delegate?.transactionFailureOptionsResult(true)
        }
    }
}
