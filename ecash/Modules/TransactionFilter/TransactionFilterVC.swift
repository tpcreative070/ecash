//
//  TransactionFilterVC.swift
//  ecash
//
//  Created by phong070 on 10/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class TransactionFilterVC : BaseViewController {
    @IBOutlet weak var lbTime : ICLabel!
    @IBOutlet weak var lbTimeValue : ICLabel!
    @IBOutlet weak var imgTime : UIImageView!
    @IBOutlet weak var viewTime : UIView!
    
    @IBOutlet weak var lbType : ICLabel!
    @IBOutlet weak var lbTypeValue : ICLabel!
    @IBOutlet weak var imgType : UIImageView!
    @IBOutlet weak var viewType : UIView!
    
    @IBOutlet weak var lbStatus : ICLabel!
    @IBOutlet weak var lbStatusValue : ICLabel!
    @IBOutlet weak var imgStatus : UIImageView!
    @IBOutlet weak var viewStatus : UIView!
    
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var btnClear : ICButton!
    @IBOutlet weak var monthYearPicker : ICMonthYearPickerView!
    @IBOutlet weak var viewMonthYearPicker : UIView!
    
    let viewModel = TransactionFilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindViewModel()
    }
    
    lazy var dropdownType : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    @IBOutlet weak var btnDone: ICButton!
    
    lazy var dropdownStatus : DropDown  = {
        let view  = DropDown()
        view.shadowColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func actionVerify(_ sender : UIButton){
        viewModel.doSendData()
        dismiss()
    }
    
    @objc func actionClear(_sender : UIButton){
        viewModel.doInitData()
    }
    
    @objc func actionDone(_ sender : UIButton){
        self.viewMonthYearPicker.isHidden = true
    }
    
    @objc func actionTime(sender : UITapGestureRecognizer){
       self.viewMonthYearPicker.isHidden = false
       self.viewModel.doBindingTime()
    }
    
    @objc func actionType(sender : UITapGestureRecognizer){
       dropdownType.show()
    }
    
    @objc func actionStatus(sender : UITapGestureRecognizer){
        dropdownStatus.show()
    }
    
    @objc func dateChanged(_ picker: ICMonthYearPickerView) {
        print("date changed: \(picker.date)")
        self.viewModel.timeBinding.value = TimeHelper.getString(time: picker.date, dateFormat: TimeHelper.StandardFilterMonthYear)
        self.viewModel.getTimeValue(time: picker.date)
    }
    
}

