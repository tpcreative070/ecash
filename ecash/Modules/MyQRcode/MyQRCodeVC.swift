//
//  MyQRCodeVC.swift
//  ecash
//
//  Created by phong070 on 11/14/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class MyQRCodeVC : BaseViewController {
    
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var imgAvatar : ICSwiftyAvatar!
    @IBOutlet weak var lbFullname: ICLabel!
    @IBOutlet weak var lbPhonenumber : ICLabel!
    @IBOutlet weak var imgCode : UIImageView!
    @IBOutlet weak var lbContent : ICLabel!
    @IBOutlet weak var viewSaved : UIView!
    @IBOutlet weak var lbSaved : ICLabel!
    @IBOutlet weak var imgSaved : UIImageView!
    let viewModel = MyQRCodeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindingViewModel()
    }
    
    override func actionLeft() {
        dismiss()
    }
    
    @objc func actionSaved(sender : UITapGestureRecognizer){
        if let mData = imgCode.image {
            UIImageWriteToSavedPhotosAlbum(mData, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            onAlertMessage(value: LanguageHelper.getTranslationByKey(LanguageKey.YourImagesSaveToPhotos) ?? "")
        }
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
