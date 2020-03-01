//
//  NotificationHistoryVC.swift
//  ecash
//
//  Created by phong070 on 11/22/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class NotificationHistoryVC : BaseViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbTitle : ICLabel!
    var dataSource :TableViewDataSource<TableViewCell,NotificationHistoryViewModel,HeaderView>!
    let viewModel = NotificationHistoryViewModelList()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
    }
    
    override func actionLeft() {
        dismiss()
    }
}
