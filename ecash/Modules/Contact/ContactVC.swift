//
//  ContactVC.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//
import UIKit
class ContactVC : BaseViewController {
    
    @IBOutlet weak var viewSearchRoot : UIView!
    @IBOutlet weak var viewSearch : UIView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var imgSearch : UIImageView!
    @IBOutlet weak var imgClear : UIImageView!
    @IBOutlet weak var textFieldSearch : UITextField!
    @IBOutlet weak var lbTitle : ICLabel!
    var addButton : UIButton?
    var doneButton : UIButton?
    var dataSource :TableViewDataSource<TableViewCell,ContactsViewModel,HeaderView>!
    var sections = [TableSection<String, ContactsViewModel>]()
    let viewModel = ContactsViewModelList()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sections = TableSection.group(rowItems: self.viewModel.listContacts, by: { (headline) in
            return headline.firstCharacterView
        })
        initUI()
        setupDelegate()
        bindViewModel()
    }
    
    @objc func actionClear(sender : UITapGestureRecognizer){
        self.textFieldSearch.text = ""
        self.viewModel.search = ""
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
    
    override func actionRight() {
        log(message: "action right")
        if viewModel.isSelected.value {
            self.viewModel.doDone()
        }else{
            Navigator.pushViewMainStoryboard(from: self, identifier: Controller.addContact, isNavigation: false, present: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.checkContactPermission()
        self.viewModel.doGetListContacts()
        self.viewModel.isSelected.value = false
        checkSessionExpired()
    }
    
    override func actionAlertYes() {
        viewModel.openAppSetting()
    }
}

