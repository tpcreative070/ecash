//
//  ViewController.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import Starscream


class HistoryVC: BaseViewController {
    var viewModel : HomeViewModelList = HomeViewModelList()
    @IBOutlet weak var  tableView : UITableView!
    var dataSource :TableViewDataSource<TableViewCell,HomeViewModel,UITableViewHeaderFooterView>!
    let outputStream = OutputStream()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
        log(message: "RootUrl".infoForKey() ?? "")
        log(message: CommonService.getAccessToken())
        let document = DocumentModel(fileName: "image", type: ".jpg",url:"https://s3.amazonaws.com/uifaces/faces/twitter/russoedu/128.jpg")
        SyncDataService.shared.startDownload(document)
        SyncDataService.shared.downloadDelegate = self
        WebSocketClientHelper.instance.connect()
    }
    
    @objc func onSignOut(){
        CommonService.signOutGlobal()
        Navigator.pushViewMainStoryboard(from: self,identifier : Controller.signin,isNavigation: false)
    }
    
    @objc func onSync(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.checkSession()
        refreshToken()
    }
}
