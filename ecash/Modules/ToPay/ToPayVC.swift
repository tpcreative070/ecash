//
//  ToPayVC.swift
//  ecash
//
//  Created by phong070 on 1/7/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
class ToPayVC : BaseViewController {
    
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
    
    @IBOutlet weak var textFieldAmount: ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldContent: ICTextFieldNoneIcon!
    
    @IBOutlet weak var btConfirm: ICButton!
    
    var viewModel = ToPayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
        checkSessionExpired()
    }
    @objc func actionVerify(sender: ICButton){
        self.view?.endEditing(true)
        btConfirm.showLoading()
        btConfirm.disableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DISBALE)
        GlobalRequestApiHelper.shared.checkSessionExpired(completed: { isSession in
            if (isSession) {
                self.viewModel.saveFormToSingleton(completion: {
                    self.btConfirm.hideLoading()
                    self.btConfirm.enableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DEFAULT)
                    Navigator.pushViewMainStoryboard(from: self, identifier: Controller.toPayQR, isNavigation: false, present: true)
                })
            } else {
                self.btConfirm.enableTouch(backgroudColor: AppColors.BLUE, alpha: AppConstants.ALPHA_DEFAULT)
                self.btConfirm.hideLoading()
                GlobalRequestApiHelper.shared.doApplicationSignOut()
            }
        })
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let st: String = textField.text ?? ""
        switch textField {
            case self.textFieldAmount:
                textField.text = st.withSeparator()
                let number = textField.text?.getAllNumber() ?? 0
                print("number text = \(String(describing: number))")
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
    
    override func actionLeft() {
        dismiss()
    }
    
    // This is a override menthod been declare in BaseViewController and will active on CommonService.eventPushActionToObjectView
    override func updateActionToObjectView(obj: EventBusObjectData){
        switch obj.type {
        case DataKeyType.StringOriginal:
            let data: String = obj.data as? String ?? ""
            if (obj.identify == EnumViewControllerNameIdentifier.GlobalUpdateEvent && (data == EnumPassdata.UserDataDidChange.rawValue || data == EnumPassdata.PayToToPayStatusPaidSuccessful.rawValue)) {
                print("Y ============================= Y")
                GlobalRequestApiHelper.shared.doGeteDongInfo(completion: { (result) -> () in
                    if result.success ?? false{
                        guard let mResponse = result.eDongInfoData else{
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
