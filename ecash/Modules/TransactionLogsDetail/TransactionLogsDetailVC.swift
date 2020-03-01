//
//  TransactionLogsDetailVC.swift
//  ecash
//
//  Created by phong070 on 11/3/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TransactionLogsDetailVC : BaseViewController {
    
    @IBOutlet weak var viewShareIntent: UIView!
    @IBOutlet weak var viewQRCodeConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewQRCodeTitle: UIView!
    @IBOutlet weak var tableConstraints: NSLayoutConstraint!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var lbType : ICLabel!
    @IBOutlet weak var lbMoney : ICLabel!
    @IBOutlet weak var lbStatus : ICLabel!
    @IBOutlet weak var lbTransactionInfoTitle : ICLabel!
    @IBOutlet weak var lbAmountCashTitle : ICLabel!
    
    @IBOutlet weak var lbReceiverNumber : ICLabel!
    @IBOutlet weak var lbReceiverNumberValue : ICLabel!
    @IBOutlet weak var lbFullName : ICLabel!
    @IBOutlet weak var lbFullNameValue : ICLabel!
    @IBOutlet weak var lbPhoneNumber : ICLabel!
    @IBOutlet weak var lbPhoneNumberValue : ICLabel!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var lbContentValue : ICLabel!
    @IBOutlet weak var lbCreatedDate : ICLabel!
    @IBOutlet weak var lbCreatedDateValue : ICLabel!
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var imgShare : UIImageView!
    @IBOutlet weak var lbShare : ICLabel!
    @IBOutlet weak var imgSaveToDevice : UIImageView!
    @IBOutlet weak var lbSaveToDevice : ICLabel!
    
    @IBOutlet weak var imgQRCode : UIImageView!
    @IBOutlet weak var lbQRCodeInfo : ICLabel!
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var viewShare : UIView!
    @IBOutlet weak var viewSave : UIView!
    @IBOutlet weak var viewStatus : UIView!
    @IBOutlet weak var viewQRCode : UIView!
    @IBOutlet weak var lbIssuer : ICLabel!
    @IBOutlet weak var lbIssuerValue : ICLabel!
    var dataSource :TableViewDataSource<TableViewCell,CashListTransactionsLogsDetailViewModel,HeaderView>!
    let viewModel = TransactionsLogsDetailListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    @objc func actionShare(sender : UITapGestureRecognizer){
        self.viewModel.doShareFiles()
    }
    
    @objc func actionSave(sender : UITapGestureRecognizer){
        self.viewModel.doSaveToDevice()
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                // we got back an error!
              log(message: "Save error  \(error.localizedDescription)")
            } else {
               log(message: "Your image has been saved to your photos.")
            }
    }
    
}
