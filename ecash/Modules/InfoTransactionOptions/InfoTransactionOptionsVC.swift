//
//  InfoTransactionOptionsVC.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

class InfoTransactionOptionsVC: BaseViewController {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var lbTitleInfo: ICLabel!
    @IBOutlet weak var lbYouArePayment: ICLabel!
    
    @IBOutlet weak var lbTotal: ICLabel!
    @IBOutlet weak var lbTotalAmount: ICLabel!
    @IBOutlet weak var lbTitleContent: ICLabel!
    @IBOutlet weak var lbContent: ICLabel!
    
    @IBOutlet weak var tbListCash: UITableView!
    
    @IBOutlet weak var btConfirm: ICButton!
    
    weak var delegate: InfoTransactionOptionsDelegate?
    var viewModel = InfoTransactionOptionsViewModel()
    var dataSource: TableViewDataSource<TableViewCell, InfoTransactionOptionsViewModelList, HeaderView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
        self.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
    }
    
    @objc func actionConfirm(sender: ICButton){
        self.viewModel.btStatusBinding.value = ButtonStatus.DISABLE
        
        GlobalRequestApiHelper.shared.checkSessionExpired(completed: { isSession in
            if (isSession) {
                self.viewModel.confirmPayToAction()
                self.btConfirm.showLoading()
            } else {
                self.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
            }
        })
    }
    
    override func updateActionToObjectView(obj: EventBusObjectData){
        switch obj.type {
        case DataKeyType.StringOriginal:
            let data: String = obj.data as? String ?? ""
            if (obj.identify == EnumViewControllerNameIdentifier.GlobalUpdateEvent) {
                var status = false
                switch data {
                case EnumPassdata.PayToToPayStatusPaidSuccessful.rawValue:
                    status = true
                    break
                case EnumPassdata.PayToToPayStatusPaidFailure.rawValue:
                    status = false
                    break
                default:
                    break
                }
                dismiss(animated: true) {
                    self.delegate?.infoTransactionOptionsResult(status, account: self.viewModel.accountBinding.value, amount: self.viewModel.totalAmountBinding.value)
                }
            }
            break
        default:
            break
        }
    }
}
