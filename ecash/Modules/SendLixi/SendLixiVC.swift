//
//  SendLixiVC.swift
//  ecash
//
//  Created by phong070 on 12/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class SendLixiVC : BaseViewController {
    
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
    var dataSource :TableViewDataSource<TableViewCell,SendLixiViewModel,HeaderView>!
      
    @IBOutlet weak var lbNoAvailableMoney : ICLabel!
    @IBOutlet weak var viewListAvailable : UIView!
    @IBOutlet weak var switchButton : ICSwitchButton!
    @IBOutlet weak var lbUseQRCode : ICLabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgContact : UIImageView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var lbChooseLixi : ICLabel!
    var collectionViewDataSource :CollectionViewDataSource<CollectionViewCell,TemplateViewModel>!
    lazy var dropdowneDong : DropDown  = {
          let view  = DropDown()
          view.shadowColor = .clear
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
    }()
      
    @IBOutlet weak var tableView : UITableView!
    let viewModel = SendLixiViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBackButton()
        initUI()
        self.setupDelegate()
        bindingViewModel()
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
        registerTransactionResponse()
        CollectionViewCell.identifier = EnumIdentifier.SendLixi
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
    }
       
    override func closeButtonPress() {
        dismiss()
    }
       
    @objc func actionVerify(){
        debugPrint("Action")
//        viewModel.doFinalMultiCalculator()
        self.btnVerify.disableTouch()
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^ Lixi Success ^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        GlobalRequestApiHelper.shared.checkingMasterKeyAndLastAccessTime { (isVerifiedTransaction) in
            self.btnVerify.enableTouch()
            if (isVerifiedTransaction) {
                self.viewModel.doFinalMultiCalculator()
            }
        }
    }
       
    @objc func actionDropDown(sender : UITapGestureRecognizer){
        dropdowneDong.show()
    }
       
    @objc func inputFieldEditingDidEnd(textField: UITextField){
           if textField == textFieldeCashId {
               if viewModel.isAllowInsert(walletId: textField.text ?? ""){
                   viewModel.eCashId = textField.text ?? ""
               }else{
                   self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.CouldNotTransferToItself) ?? "")
               }
           }
           else if textField == textFieldContent {
               viewModel.content = textField.text ?? ""
           }
    }
       
    override func requestUpdateeDong() {
           self.viewModel.doGeteDongInfo()
           self.viewModel.getListAvailable()
    }
       
    @objc func switchDidChange (_ : ICSwitchButton){
           print(switchButton.isOn)
           self.viewModel.isQRCode =  switchButton.isOn
    }
       
    @objc func actionContact(sender : UITapGestureRecognizer){
        log(message: "actionContact")
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.contact, isNavigation: false, present: true)
    }
       
    override func closeTransaction() {
        dismiss()
    }
       
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
                 // we got back an error!
            log(message: "Save error  \(error.localizedDescription)")
        } else {
            log(message: "Your image has been saved to your photos.")
        }
    }
       
    override func requestSaveToPho(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}
