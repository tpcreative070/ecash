//
//  GalleryOptionsVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import Photos
extension GalleryOptionsVC {
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.viewRoot.setCorner(corner: 3, color: .white)
        self.lbTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.ChangeAvatar)
        self.lbTitle.textColor = AppColors.BLACK_COLOR
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE + 5)
        self.lbTitle.textAlignment = .center
        self.imgAvatar.image = UIImage(named: AppImages.IC_AVATAR)
          
        btnGallery.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.ChooseFromGallery), for: .normal)
        btnGallery.addTarget(self, action: #selector(actionGallery), for: .touchUpInside)
        btnGallery.setTitleColor(.white, for: .normal)
        btnGallery.cornerButton(corner: 5, color: AppColors.BLUE)
        
        btnTakePicture.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.TakePicture), for: .normal)
        btnTakePicture.addTarget(self, action: #selector(actionTakePicture), for: .touchUpInside)
        btnTakePicture.setTitleColor(.white, for: .normal)
        btnTakePicture.cornerButton(corner: 5, color: AppColors.BLUE)
        
        btnExit.setTitle(LanguageHelper.getTranslationByKey(LanguageKey.Exit), for: .normal)
        btnExit.addTarget(self, action: #selector(actionExit), for: .touchUpInside)
        btnExit.setTitleColor(AppColors.BLUE, for: .normal)
        btnExit.setRadius(corner: 3, color: AppColors.BLUE)
    }
    
    func onTakePicture(){
        let camera = DKCamera()
        camera.didCancel = { () in
                print("didCancel")
            self.dismiss(animated: true, completion: nil)
        }
        camera.didFinishCapturingImage = { (image: UIImage?, metadata: [AnyHashable : Any]?) in
            print("didFinishCapturingImage")
            self.dismiss(animated: true, completion: nil)
            if let mData = image {
                self.pickedImage = mData
                self.showImageTrimmer()
            }
        }
        self.present(camera, animated: true, completion: nil)
    }
    
    func onTakePhotoFromGallery(){
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 1
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// Display KRImageTrimmerController
    func showImageTrimmer() {
          // Customize settings
          // If not specified, the default value is applied
          let options = KRImageTrimmerController.Options()
          options.zoomingMultiplier = 2.0
          options.cancelButtonTitle = LanguageHelper.getTranslationByKey(LanguageKey.Cancel) ?? ""
          options.cancelButtonTitleColor = UIColor.red
          options.confirmButtonTitle = LanguageHelper.getTranslationByKey(LanguageKey.Ok) ?? ""
          options.confirmButtonTitleColor = UIColor.blue
          options.frameWidth = 4.0
          options.frameColor = UIColor.white
          options.frameDashPattern = [8.0, 4.0, 4.0, 4.0]
          let vc = KRImageTrimmerController(options: options)
          vc.delegate = self
          self.present(vc, animated: true)
      }
}

extension GalleryOptionsVC : OpalImagePickerControllerDelegate {
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        if images.count>0{
            let mData = images[0]
            self.pickedImage = mData
            self.showImageTrimmer()
        }
    }
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        
    }
}

extension GalleryOptionsVC: KRImageTrimmerControllerDelegate {
    /// Pass the image to be edited
    func imageForTrimming() -> UIImage {
        return pickedImage!
    }

    /// Called when image editing is canceled
    func imageTrimmerControllerDidCancel(_ imageTrimmer: KRImageTrimmerController) {
        self.dismiss()
        self.close?.dismiss()
    }

    /// When image editing is completed, the image after editing will be returned
    func imageTrimmerController(_ imageTrimmer: KRImageTrimmerController, didFinishTrimmingImage image: UIImage?) {
        guard let image = image else {
            return
        }
        let mShareData = GalleryOptionsData(data: image)
        CommonService.sendDataToGalleryOption(data: mShareData, isResponse: true)
        self.dismiss()
        self.close?.dismiss()
    }
}

