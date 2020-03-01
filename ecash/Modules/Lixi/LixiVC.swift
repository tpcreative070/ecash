//
//  LixiVC.swift
//  ecash
//
//  Created by phong070 on 12/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class LixiVC : BaseViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var viewProfileInfo : UIView!
    @IBOutlet weak var lbFullname : ICLabel!
    @IBOutlet weak var lbFullnameValue : ICLabel!
    @IBOutlet weak var lbeCashId : ICLabel!
    @IBOutlet weak var lbeCashIdValue : ICLabel!
    @IBOutlet weak var lbeCashTotal : ICLabel!
    @IBOutlet weak var lbeCashTotalValue : ICLabel!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var textFieldeCashId : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldContent : ICTextFieldNoneIcon!
    @IBOutlet weak var lbTotalMoney : ICLabel!
    @IBOutlet weak var lbTotalMoneyValue : ICLabel!
    @IBOutlet weak var lbTransferTitle : ICLabel!
      
    @IBOutlet weak var lbNoAvailableMoney : ICLabel!
    @IBOutlet weak var viewListAvailable : UIView!
    @IBOutlet weak var switchButton : ICSwitchButton!
    @IBOutlet weak var lbUseQRCode : ICLabel!
     
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgContact : UIImageView!
    lazy var dropdowneDong : DropDown  = {
          let view  = DropDown()
          view.shadowColor = .clear
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
    }()
      
    @IBOutlet weak var tableView : UITableView!

    var dataSource :TableViewDataSource<TableViewCell,LixiViewModel,HeaderView>!
    let viewModel = LixiViewModelList()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
        if let mData = SQLHelper.getCashTempList() {
            log(object: mData)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    override func actionRight() {
        CommonService.sendDataToeCashToeCash(data: eCashToeCashPassData(total: nil, eCash: nil), isResponse: false)
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.sendLixi, isNavigation: false, isTransparent: false, present: true)
    }
    
    override func updateActionToView(data: String) {
        if EnumResponseToView.UPDATE_LIXI_UI.rawValue == data {
            self.viewModel.getLixi()
        }
    }
}
