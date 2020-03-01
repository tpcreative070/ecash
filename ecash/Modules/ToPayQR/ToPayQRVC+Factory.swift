//
//  ToPayQRVC+Factory.swift
//  ecash
//
//  Created by ECAPP on 1/15/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

extension ToPayQRVC {
    func initUI(){
        
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.CreatePaymentBill)?.uppercased()
        self.lbTitle.textAlignment = NSTextAlignment.center
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 2)
        self.lbTitle.textColor = AppColors.BLUE
        
        if let leftIcon =  UIImage(named: AppImages.IC_BACK) {
            addButtonCustom(image: leftIcon, isLeft: true)
        }
        
        self.lbCreateSuccess.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbCreateSuccess.text = LanguageHelper.getTranslationByKey(LanguageKey.CreatedSuccessQRCode)
        self.lbScanToPay.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbScanToPay.text = LanguageHelper.getTranslationByKey(LanguageKey.ScanQrCodeToPay)
        
        self.imgIconShare.image = UIImage(named: AppImages.IC_SHARE)
        self.lbShare.text = LanguageHelper.getTranslationByKey(LanguageKey.Share)
        
        self.btShare.addTarget(self, action: #selector(actionSharePressUp), for: .touchUpInside)
        self.btShare.addTarget(self, action: #selector(actionSharePress), for: .touchDown)
        self.btShare.addTarget(self, action: #selector(actionSharePressCancel(sender:)), for: .touchDragExit)
        self.btShare.addTarget(self, action: #selector(actionSharePressCancel(sender:)), for: .touchCancel)
        
        self.lbShare.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbShare.textColor = AppColors.BLUE
        
        self.imgIconDownload.image = UIImage(named: AppImages.IC_DOWNLOAD)
        self.lbDownload.text = LanguageHelper.getTranslationByKey(LanguageKey.DownToDevice)
        
        self.btDowload.addTarget(self, action: #selector(actionDownloadPressUp), for: .touchUpInside)
        self.btDowload.addTarget(self, action: #selector(actionDownloadPress), for: .touchDown)
        self.btDowload.addTarget(self, action: #selector(actionDownloadPressCancel), for: .touchDragExit)
        self.btDowload.addTarget(self, action: #selector(actionDownloadPressCancel), for: .touchCancel)
        
        self.lbDownload.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.SUB_TITLE_FONT_SIZE)
        self.lbDownload.textColor = AppColors.BLUE
    }
    
    func bindingViewModel() {
        self.viewModel.qrContent.bind { (value) in
            if let qrImage = QRCodeHelper.shared.generateDataQRCode(from: value){
                print("let seeeeeeeeeee: \(value)")
                self.imgQR.image = qrImage
            }
        }
    }
}
