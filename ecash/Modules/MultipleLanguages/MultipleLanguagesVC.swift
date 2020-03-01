//
//  MultipleLanguagesVC.swift
//  ecash
//
//  Created by phong070 on 11/12/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class MultipleLanguagesVC : BaseViewController {
    
    @IBOutlet weak var imgIcon : UIImageView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var viewPupup : UIView!
    @IBOutlet weak var btnVietnamese : ICButton!
    @IBOutlet weak var btnEnglish : ICButton!
    
    var dataSource :TableViewDataSource<TableViewCell,ListAvailableViewModel,HeaderView>!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        let value = String(describing: MultipleLanguagesVC.self)
        log(message: value)
    }
    
    @objc func actionVietnamese(_ sender : UIButton){
        CommonService.setMultipleLanguages(value: LanguageCode.Vietnamese)
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.initTabBarController(selectedIndex: 0)
        dismiss()
    }
    
    @objc func actionEnglish(_ sender : UIButton){
        CommonService.setMultipleLanguages(value: LanguageCode.English)
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.initTabBarController(selectedIndex: 0)
        dismiss()
    }
    
    override func closeViewController() {
        log(message: "closeViewController")
    }
}
