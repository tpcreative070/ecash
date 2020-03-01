//
//  TransactionFilter+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TransactionFilterVC {
    
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.btnVerify.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Verify), for: .normal)
        self.btnVerify.addTarget(self, action: #selector(actionVerify), for: .touchUpInside)
        self.btnVerify.setTitleColor(.white, for: .normal)
        self.btnVerify.cornerButton(corner: 5, color: AppColors.BLUE)
        
        self.btnClear.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Clear), for: .normal)
        self.btnClear.addTarget(self, action: #selector(actionClear), for: .touchUpInside)
        self.btnClear.setTitleColor(.white, for: .normal)
        self.btnClear.cornerButton(corner: 5, color: AppColors.BLUE)
        
        self.btnDone.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Done), for: .normal)
        self.btnDone.addTarget(self, action: #selector(actionDone), for: .touchUpInside)
        self.btnDone.setTitleColor(AppColors.BLUE, for: .normal)
      
        self.lbTime.text = LanguageHelper.getTranslationByKey(LanguageKey.Time)
        self.lbTime.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbTime.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbType.text = LanguageHelper.getTranslationByKey(LanguageKey.TransactionType)
        self.lbType.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbType.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
        self.lbStatus.text = LanguageHelper.getTranslationByKey(LanguageKey.Status)
        self.lbStatus.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbStatus.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        
      
        self.lbTimeValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbTimeValue.textAlignment = .right
        self.imgTime.image = UIImage(named: AppImages.IC_DROPDOWN)
        
    
        self.lbTypeValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbTypeValue.textAlignment = .right
        self.imgType.image = UIImage(named: AppImages.IC_DROPDOWN)
        
   
        self.lbStatusValue.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 2)
        self.lbStatusValue.textAlignment = .right
        self.imgStatus.image = UIImage(named: AppImages.IC_DROPDOWN)
        
        self.viewTime.isUserInteractionEnabled = true
        self.viewTime.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionTime(sender:))))
        
        self.viewType.isUserInteractionEnabled = true
        self.viewType.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionType(sender:))))
        
        self.viewStatus.isUserInteractionEnabled = true
        self.viewStatus.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionStatus(sender:))))
        
        
        dropdownType.anchorView = viewType
        dropdownType.bottomOffset = CGPoint(x: 0, y: dropdownType.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
       
        // Action triggered on selection
        dropdownType.selectionAction = { [weak self] (index, item) in
            self?.lbTypeValue.text = item
            self?.viewModel.type = self?.viewModel.hashType[index]
        }
        
        dropdownStatus.anchorView = viewStatus
        dropdownStatus.bottomOffset = CGPoint(x: 0, y: dropdownStatus.bounds.height)
        // You can also use localizationKeysDataSource instead. Check the docs.
        // Action triggered on selection
        dropdownStatus.selectionAction = { [weak self] (index, item) in
            self?.lbStatusValue.text = item
            self?.viewModel.status = self?.viewModel.hashStatus[index]
        }

        self.viewMonthYearPicker.isHidden = true
        monthYearPicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
    }
    
    func bindViewModel() {
        self.viewModel.showLoading.bind { visible in
            visible ? ProgressHUD.show(): ProgressHUD.dismiss()
        }
        self.viewModel.onShowError = { [weak self] alert in
            self?.presentSingleButtonDialog(alert: alert)
        }
        self.viewModel.responseToView = {[weak self] value in
          
        }
        self.viewModel.timeBinding.bind { (value) in
            self.lbTimeValue.text = value
        }
        self.viewModel.typeBinding.bind { (value) in
            self.lbTypeValue.text = value
        }
        self.viewModel.statusBinding.bind { (value) in
            self.lbStatusValue.text = value
        }
        self.viewModel.listType.bind { (value) in
            self.dropdownType.dataSource = value
        }
        self.viewModel.listStaus.bind { (value) in
            self.dropdownStatus.dataSource = value
        }
        viewModel.doInitData()
    }
}

extension TransactionFilterVC : SingleButtonDialogPresenter {
    
}
