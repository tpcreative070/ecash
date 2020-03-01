//
//  ToPayQRVC.swift
//  ecash
//
//  Created by ECAPP on 1/15/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

class ToPayQRVC : BaseViewController {
    
    
    @IBOutlet weak var lbTitle: ICLabel!
    @IBOutlet weak var lbCreateSuccess: ICLabel!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var lbScanToPay: ICLabel!
    @IBOutlet weak var btShare: UIButton!
    @IBOutlet weak var btDowload: UIButton!
    @IBOutlet weak var imgIconShare: UIImageView!
    @IBOutlet weak var lbShare: ICLabel!
    @IBOutlet weak var imgIconDownload: UIImageView!
    @IBOutlet weak var lbDownload: ICLabel!
    
    var viewModel = ToPayQRViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
        viewModel.generateQRCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardHelper?.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardHelper?.deregisterKeyboardNotification()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    @objc func actionSharePress(sender: UIButton){
        self.imgIconShare.image = self.imgIconShare.image?.maskWithColor(color: AppColors.GRAY_LIGHT) ?? UIImage()
        self.lbShare.textColor = AppColors.GRAY_LIGHT
    }
    
    @objc func actionSharePressUp(sender: UIButton){
        self.imgIconShare.image = UIImage(named: AppImages.IC_SHARE)
        self.lbShare.textColor = AppColors.BLUE
        if let image = imgQR.image {
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    
    @objc func actionSharePressCancel(sender: UIButton){
        self.imgIconShare.image = UIImage(named: AppImages.IC_SHARE)
        self.lbShare.textColor = AppColors.BLUE
    }
    
    @objc func actionDownloadPress(sender: UIButton){
        self.imgIconDownload.image = self.imgIconDownload.image?.maskWithColor(color: AppColors.GRAY_LIGHT) ?? UIImage()
        self.lbDownload.textColor = AppColors.GRAY_LIGHT
    }
    
    @objc func actionDownloadPressUp(sender: UIButton){
        self.imgIconDownload.image = UIImage(named: AppImages.IC_DOWNLOAD)
        self.lbDownload.textColor = AppColors.BLUE
        if let mData = imgQR.image {
            UIImageWriteToSavedPhotosAlbum(mData, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.YourImagesSaveToPhotos) ?? "")
        }
    }
    
    @objc func actionDownloadPressCancel(sender: UIButton){
        self.imgIconDownload.image = UIImage(named: AppImages.IC_DOWNLOAD)
        self.lbDownload.textColor = AppColors.BLUE
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
}

