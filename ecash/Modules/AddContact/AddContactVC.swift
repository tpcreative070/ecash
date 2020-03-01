//
//  AddContactVC.swift
//  ecash
//
//  Created by phong070 on 10/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class AddContactVC : BaseViewController {
    @IBOutlet weak var viewSearchRoot : UIView!
    @IBOutlet weak var viewSearch : UIView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var imgSearch : UIImageView!
    @IBOutlet weak var imgClear : UIImageView!
    @IBOutlet weak var textFieldSearch : ICNumericTextField!
    @IBOutlet weak var lbTitle : ICLabel!
    var addButton : UIButton?
    var doneButton : UIButton?
    let viewModel = AddContactViewModel()
    var dataSource :TableViewDataSource<TableViewCell,ContactsViewModel,HeaderView>!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupDelegate()
        bindViewModel()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    @objc func actionClear(sender : UITapGestureRecognizer){
        self.textFieldSearch.text = ""
        self.viewModel.search = ""
    }
    
    @objc func inputFieldEditingDidEnd(textField : TextField){
        if textFieldSearch == textField {
            self.viewModel.search = textField.text
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func actionRight() {
           log(message: "action right")
          
           //Navigator.pushViewMainStoryboard(from: self, identifier: Controller.scanner, isNavigation: false,isTransparent: false, present: true)
           
           let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
           appDelegate?.initTabBarController(selectedIndex: 2)
           //Navigator.pushViewMainStoryboard(from: self, identifier: Controller.scanner, isNavigation: false, isTransparent: false, present: true)
           
          //let nav3 = UINavigationController()
          // let scanner = storyboard!.instantiateViewController(withIdentifier: Controller.scanner) as! ScannerVC
          //nav3.viewControllers = [scanner]
           
           //let HomeViewController = ViewController(nibName: Controller.scanner, bundle: Bundle.main)
          // self.presentViewController(HomeViewController, animated: true, completion: nil)
       }

    
    lazy var viewTest : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
