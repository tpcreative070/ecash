//
//  QRCodeHistoryVC.swift
//  ecash
//
//  Created by phong070 on 10/15/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit
class QRCodeHistoryVC : BaseViewController {
    @IBOutlet weak var lbTitle : ICLabel!
    var dataSource :TableViewDataSource<TableViewCell,QRCodeViewModel,HeaderView>!
    var sections = [TableSection<String, QRCodeViewModel>]()
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var btnSend : ICButton!
    @IBOutlet weak var btnDelete : ICButton!
    let viewModel = QRCodeViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sections = TableSection.group(rowItems: self.viewModel.listQRCode, by: { (headline) in
            return headline.transactionIdView ?? ""
        })
        initUI()
        bindViewModel()
        
        if let mData = SQLHelper.getTransactionQR(){
            log(message: "Show data...")
            log(object: mData)
        }
        
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    override func actionRight() {
        self.viewModel.isSelected.value = !self.viewModel.isSelected.value
    }
    
    @objc func actionSend(_ sender : UIButton){
        viewModel.shareFiles()
    }
    
    @objc func actionDelete(_ sennder : UIButton){
        self.viewModel.doDelete()
    }
    
}
