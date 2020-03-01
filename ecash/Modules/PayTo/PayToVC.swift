//
//  PayToVC.swift
//  ecash
//
//  Created by phong070 on 1/7/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
class PayToVC : BaseViewController {
    
    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var scrollviewMain: UIScrollView!
    @IBOutlet weak var lbTitle: ICLabel!
    
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var lbAccountName: UILabel!
    @IBOutlet weak var lbAcountNameValue: UILabel!
    @IBOutlet weak var lbECashId: UILabel!
    @IBOutlet weak var lbECashIdValue: UILabel!
    @IBOutlet weak var lbECashBalance: UILabel!
    @IBOutlet weak var lbECashBalanceValue: UILabel!
    
    @IBOutlet weak var lbTitleContent: UILabel!
    @IBOutlet weak var lbTitleGetQRCode: UILabel!
    
    @IBOutlet weak var textFieldECashAccountNumber: ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldAmount: ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldContent: ICTextFieldNoneIcon!
    
    @IBOutlet weak var imgContacts: UIImageView!
    @IBOutlet weak var imgContactQR: UIImageView!
    
    @IBOutlet weak var btSelectContact: UIButton!
    @IBOutlet weak var btConfirm: ICButton!
    
    var viewModel = PayToViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
        viewModel.doBindingDataToView()
        self.viewModel.btStatusBinding.value = ButtonStatus.DISABLE
        self.viewModel.initTmpState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSessionExpired()
    }
    
    override func actionLeft() {
        self.viewModel.resetTmpState()
        dismiss()
    }
    
    @objc func actionVerify(sender: ICButton){
        self.view?.endEditing(true)
        self.viewModel.btStatusBinding.value = ButtonStatus.DISABLE
        GlobalRequestApiHelper.shared.checkSessionExpired(completed: { isSession in
            if (isSession) {
                self.btConfirm.showLoading()
                self.viewModel.sentRequest()
            } else {
                self.viewModel.btStatusBinding.value = ButtonStatus.ENABLE
                GlobalRequestApiHelper.shared.doApplicationSignOut()
            }
        })
    }
    
    @objc func actionSelectContact(img: UIImage){
        self.imgContacts.image = self.imgContacts.image?.maskWithColor(color: AppColors.GRAY_LIGHT) ?? UIImage()
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.1), execute: {
           self.imgContacts.image = UIImage(named: AppImages.IC_CONTACT_ACTIVE)
        })
        
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.contact, isNavigation: false, present: true)
    }
    
    /**
     Evenbus flow
     - PayToVc -> dismiss -> Home lísten  with func updateActionToObjectView
     - Home -> Open Tab QR Scan -> In ScannerViewModel -> func mergeData() will handle base on TransferDataModel.type in this case type equal "MC"
    */
    @objc func handleTapImageQR(img: UIImage){
        // This will delay use for effect blink 0.2 second
        self.imgContactQR.image = self.imgContactQR.image?.maskWithColor(color: AppColors.GRAY_LIGHT) ?? UIImage()
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 0.1), execute: {
           self.imgContactQR.image = UIImage(named: AppImages.IC_QRCODE)
        })
        
        let obj = EventBusObjectData(data: "", type: DataKeyType.StringOriginal, identify: EnumViewControllerNameIdentifier.PayToVC)
        print("Let Check Do Pay To iterfear")
        CommonService.eventPushActionToObjectView(obj: obj)
        ShareApplicationSingleton.shared.set(key: StorageKey.IsWaittingForPayToQR, value: true)
        viewModel.saveTmpState()
        self.dismiss()
    }
    
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldECashAccountNumber {
            viewModel.eCashAccountNumberBinding.value = textField.text ?? ""
        }
        else if textField == textFieldAmount {
            viewModel.amountBinding.value = textField.text ?? ""
            let number = textField.text?.getAllNumber()
            viewModel.amountInt = number ?? 0
        }
        else if textField == textFieldContent {
            viewModel.contentBinding.value = textField.text ?? ""
            viewModel.contentString = textField.text ?? ""
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let st: String = textField.text ?? ""
        switch textField {
            case self.textFieldAmount:
                textField.text = st.withSeparator()
                let number = textField.text?.getAllNumber() ?? 0
                if (number <= LimitationValues.MAXIMUM_AMOUNT_TRANSACTION) {
                    viewModel.amountInt = number
                } else {
                    textField.text = "\(st.dropLast())"
                    self.onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.AmountMustLesser20Million) ?? "")
                }
                break
            case self.textFieldContent:
                print("content text = \(st)")
                viewModel.contentString = st
                break
        default:
            break
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
    }
    
    // This is a override menthod been declare in BaseViewController and will active on CommonService.eventPushActionToObjectView
    override func updateActionToObjectView(obj: EventBusObjectData){
        switch obj.type {
        case DataKeyType.ArrayString:
            let data: [String] = obj.data as! [String]
            if (obj.identify == EnumViewControllerNameIdentifier.ContactVC) {
                if(data.count <= 10){
                    self.viewModel.listCashIds = data
                } else {
                    self.viewModel.doAlertConnection(value: LanguageHelper.getTranslationByKey(LanguageKey.Maximum10WalletCheckout) ?? "Error")
                }
            }
            break
        case DataKeyType.StringOriginal:
            let data: String = obj.data as? String ?? ""
            if (obj.identify == EnumViewControllerNameIdentifier.ScannerVC) {
                self.viewModel.listCashIds = [data]
            }
            if (obj.identify == EnumViewControllerNameIdentifier.GlobalUpdateEvent && (data == EnumPassdata.UserDataDidChange.rawValue || data == EnumPassdata.PayToToPayStatusPaidSuccessful.rawValue)) {
                GlobalRequestApiHelper.shared.doGeteDongInfo(completion: { (result) -> () in
                    if result.success ?? false{
                        guard let mResponse = result.eDongInfoData else{
//                            debugPrint("Debug")
                            return
                        }
                        self.viewModel.doBindingDataToView(data:mResponse)
                    }
                })
            }
            break
        default:
            break
        }
    }
}
