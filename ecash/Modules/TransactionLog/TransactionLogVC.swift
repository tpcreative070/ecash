//
//  TransactionLogVC.swift
//  ecash
//
//  Created by Tuan Le Anh on 10/20/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TransactionLogVC : BaseViewController {
    @IBOutlet weak var viewSearchRoot : UIView!
    @IBOutlet weak var viewSearch : UIView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var imgSearch : UIImageView!
    @IBOutlet weak var imgClear : UIImageView!
    @IBOutlet weak var textFieldSearch : UITextField!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var imgFilter : UIImageView!
    var dataSource :TableViewDataSource<TableViewCell,TransactionsLogsViewModel,HeaderView>!
    var sections = [TableSection<String, TransactionsLogsViewModel>]()
    let viewModel = TransactionsLogsViewModelList()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sections = TableSection.group(rowItems: self.viewModel.listTransactionsLogs, by: { (headline) in
            var index = headline.transactionDate!.index(headline.transactionDate!.startIndex, offsetBy: 4)
            let year = String(headline.transactionDate![..<index])
            let monthdate = String(headline.transactionDate![index...])
            index = monthdate.index(monthdate.startIndex, offsetBy: 2)
            let month = String(monthdate[..<index])
            let headline = String("\(LanguageHelper.getTranslationByKey(LanguageKey.Months) ?? "") " + month + "/" + year)
            return headline
        })
        initUI()
        setupDelegate()
    }
    
    @objc func actionClear(sender : UITapGestureRecognizer){
        self.textFieldSearch.text = ""
        self.viewModel.search = ""
    }
    
    @objc func actionFilter(sender : UITapGestureRecognizer){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.transactionFilter, isNavigation: false, isTransparent: true, present: true)
    }
    
    @objc func inputFieldEditingDidChange(textField : TextField){
        self.viewModel.search = textField.text
    }
    
    override func dismissKeyboard() {
        doDismiss()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bindViewModel()
        checkSessionExpired()
    }
}
