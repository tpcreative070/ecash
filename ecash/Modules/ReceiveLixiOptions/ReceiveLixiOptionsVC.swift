//
//  ReceiveLixiOptionsVC.swift
//  ecash
//
//  Created by phong070 on 12/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ReceiveLixiOptionsVC : BaseViewController {
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lbTotalLixi : ICLabel!
    @IBOutlet weak var lbTotalLixiValue : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var viewRoot : UIView!
    @IBOutlet weak var viewOptions : UIView!
    @IBOutlet weak var lbNoAvailableMoney : ICLabel!
    @IBOutlet weak var lbLuckyMessage : ICLabel!
    @IBOutlet weak var lbLuckyMessageValue : ICLabel!
    @IBOutlet weak var imgTemplateCode : UIImageView!
    var dataSource :TableViewDataSource<TableViewCell,ReceiveLixiOptionsViewModel,HeaderView>!
    let viewModel = ReceiveLixiOptionsViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    @objc func actionVerify(){
        dismiss()
        CommonService.eventPushActionToView(data: EnumResponseToView.UPDATE_LIXI_UI)
        CommonService.eventPushActionToView(data: EnumResponseToView.UPDATE_HOME_TO_LIXI)
    }
}
