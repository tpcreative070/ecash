//
//  ScannerVC+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import ZXingObjC
import Photos
extension ScannerVC {
    func initUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.viewFlash.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionFlash(sender:))))
        self.viewGallery.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionGallery(sender:))))
        self.lbFlash.text = LanguageHelper.getTranslationByKey(LanguageKey.Flash)
        self.lbGallery.text = LanguageHelper.getTranslationByKey(LanguageKey.Gallery)
        self.viewPanelHeader.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.imgFlash.image = UIImage(named: AppImages.IC_FLASH)
        self.imgGallery.image = UIImage(named: AppImages.IC_GALLERY)
        self.lbFlash.textColor = .white
        self.lbGallery.textColor = .white
        
        
        self.viewScanQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionScanQR(sender:))))
        self.viewCreatedQR.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (actionCreatedQR(sender:))))
        self.lbScanQR.text = LanguageHelper.getTranslationByKey(LanguageKey.ScanQR)
        self.lbCreatedQR.text = LanguageHelper.getTranslationByKey(LanguageKey.CreatedQR)
        self.viewPanelFooter.backgroundColor = .black
        self.imgScanQR.image = UIImage(named: AppImages.IC_SCANNER_BLUE)
        self.imgCreatedQR.image = UIImage(named: AppImages.IC_SCAN)
        self.lbScanQR.textColor = AppColors.BLUE
        self.lbCreatedQR.textColor = .white
        self.lbQRTitle.textAlignment = .center
        self.lbQRTitle.textColor = .white
        self.lbQRStatus.textAlignment = .center
        self.lbQRStatus.textColor = .white
        self.lbQRTitle.text = LanguageHelper.getTranslationByKey(LanguageKey.QRTitle)
        self.lbQRStatus.text = String(format: LanguageHelper.getTranslationByKey(LanguageKey.QRStatus) ?? "", arguments: ["0/0"])
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
        
        self.viewModel.transactionIdBinding.bind { value in
            let scannerData = ReceiveQRCodeData(transactionsId: value)
            CommonService.sendIntentToScannerResult(data: scannerData)
            Navigator.pushViewMainStoryboard(from: self, identifier: Controller.scannerResult, isNavigation: false, isTransparent: false, present: true)
            
            debugPrint("............Call QRCode result...")
            CommonService.bindingData()
        }
        
        self.viewModel.resultScan.bind { value in
            self.lbQRStatus.text = value
            self.log(message: "Update value...")
        }
        
        viewModel.cameraBinding.bind {[weak self] value in
            DispatchQueue.main.async {
                if !value {
                    self?.doAlertMessage(permission: "Camera")
                }
            }
        }
    }
    
    
    func barcodeFormatToString(format: ZXBarcodeFormat) -> String {
        switch (format) {
        case kBarcodeFormatAztec:
            return "Aztec"
            
        case kBarcodeFormatCodabar:
            return "CODABAR"
            
        case kBarcodeFormatCode39:
            return "Code 39"
            
        case kBarcodeFormatCode93:
            return "Code 93"
            
        case kBarcodeFormatCode128:
            return "Code 128"
            
        case kBarcodeFormatDataMatrix:
            return "Data Matrix"
            
        case kBarcodeFormatEan8:
            return "EAN-8"
            
        case kBarcodeFormatEan13:
            return "EAN-13"
            
        case kBarcodeFormatITF:
            return "ITF"
            
        case kBarcodeFormatPDF417:
            return "PDF417"
            
        case kBarcodeFormatQRCode:
            return "QR Code"
            
        case kBarcodeFormatRSS14:
            return "RSS 14"
            
        case kBarcodeFormatRSSExpanded:
            return "RSS Expanded"
            
        case kBarcodeFormatUPCA:
            return "UPCA"
            
        case kBarcodeFormatUPCE:
            return "UPCE"
            
        case kBarcodeFormatUPCEANExtension:
            return "UPC/EAN extension"
            
        default:
            return "Unknown"
        }
    }
    
    func applyOrientation() {
        let orientation = UIApplication.shared.statusBarOrientation
        var captureRotation: Double
        var scanRectRotation: Double
        
        switch orientation {
        case .portrait:
            captureRotation = 0
            scanRectRotation = 90
            break
            
        case .landscapeLeft:
            captureRotation = 90
            scanRectRotation = 180
            break
            
        case .landscapeRight:
            captureRotation = 270
            scanRectRotation = 0
            break
            
        case .portraitUpsideDown:
            captureRotation = 180
            scanRectRotation = 270
            break
            
        default:
            captureRotation = 0
            scanRectRotation = 90
            break
        }
        
        applyRectOfInterest(orientation: orientation)
        
        let angleRadius = captureRotation / 180.0 * Double.pi
        let captureTranform = CGAffineTransform(rotationAngle: CGFloat(angleRadius))
        
        capture?.transform = captureTranform
        capture?.rotation = CGFloat(scanRectRotation)
        capture?.layer.frame = view.frame
    }
    
    func applyRectOfInterest(orientation: UIInterfaceOrientation) {
        guard var transformedVideoRect = scanView?.frame,
            let cameraSessionPreset = capture?.sessionPreset
            else { return }
        var scaleVideoX, scaleVideoY: CGFloat
        var videoHeight, videoWidth: CGFloat
        
        // Currently support only for 1920x1080 || 1280x720
        if cameraSessionPreset == AVCaptureSession.Preset.hd1920x1080.rawValue {
            videoHeight = 1080.0
            videoWidth = 1920.0
        } else {
            videoHeight = 720.0
            videoWidth = 1280.0
        }
        
        if orientation == UIInterfaceOrientation.portrait {
            scaleVideoX = self.view.frame.width / videoHeight
            scaleVideoY = self.view.frame.height / videoWidth
            
            // Convert CGPoint under portrait mode to map with orientation of image
            // because the image will be cropped before rotate
            // reference: https://github.com/TheLevelUp/ZXingObjC/issues/222
            let realX = transformedVideoRect.origin.y;
            let realY = self.view.frame.size.width - transformedVideoRect.size.width - transformedVideoRect.origin.x;
            let realWidth = transformedVideoRect.size.height;
            let realHeight = transformedVideoRect.size.width;
            transformedVideoRect = CGRect(x: realX, y: realY, width: realWidth, height: realHeight);
            
        } else {
            scaleVideoX = self.view.frame.width / videoWidth
            scaleVideoY = self.view.frame.height / videoHeight
        }
        
        captureSizeTransform = CGAffineTransform(scaleX: 1.0/scaleVideoX, y: 1.0/scaleVideoY)
        guard let _captureSizeTransform = captureSizeTransform else { return }
        let transformRect = transformedVideoRect.applying(_captureSizeTransform)
        capture?.scanRect = transformRect
    }
    
    func onTakeGallery(){
       let imagePicker = OpalImagePickerController()
       imagePicker.imagePickerDelegate = self
       present(imagePicker, animated: true, completion: nil)
    }
}

extension ScannerVC : SingleButtonDialogPresenter {
    
}

extension ScannerVC : OpalImagePickerControllerDelegate {
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        self.viewModel.doAsync(list: images)
    }
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
    }
}

extension ScannerVC : ZXCaptureDelegate {
    func captureCameraIsReady(_ capture: ZXCapture!) {
        isScanning = true
    }
    
    func captureResult(_ capture: ZXCapture!, result: ZXResult!) {
        guard let _result = result, isScanning == true else { return }
        capture?.stop()
        isScanning = false
        let text = _result.text ?? "Unknow"
        viewModel.scannerResult(mValue: text)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.isScanning = true
            weakSelf.capture?.start()
        }
    }
}
