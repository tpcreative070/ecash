//
//  ScannerVC.swift
//  ecash
//
//  Created by phong070 on 8/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import ZXingObjC
class ScannerVC : BaseViewController {
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var lbFlash : ICLabel!
    @IBOutlet weak var lbGallery : ICLabel!
    @IBOutlet weak var imgFlash : UIImageView!
    @IBOutlet weak var imgGallery : UIImageView!
    @IBOutlet weak var viewFlash : UIView!
    @IBOutlet weak var viewGallery : UIView!
    @IBOutlet weak var viewPanelHeader : UIView!
    @IBOutlet weak var lbScannerRectangle: UILabel!
    @IBOutlet weak var cornerView: ViewRectangleArea!
    private let regionCornerRadius = CGFloat(10.0)
    @IBOutlet weak var lbScanQR : ICLabel!
    @IBOutlet weak var lbCreatedQR : ICLabel!
    @IBOutlet weak var imgScanQR : UIImageView!
    @IBOutlet weak var imgCreatedQR : UIImageView!
    @IBOutlet weak var viewScanQR : UIView!
    @IBOutlet weak var viewCreatedQR : UIView!
    @IBOutlet weak var viewPanelFooter : UIView!
    let viewModel =  ScannerViewModel()
    var capture: ZXCapture?
    @IBOutlet weak var lbQRTitle : ICLabel!
    @IBOutlet weak var lbQRStatus : ICLabel!
    
    var isScanning: Bool?
    var isFirstApplyOrientation: Bool?
    var captureSizeTransform: CGAffineTransform?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setup()
        bindViewModel()
    }
    
    func setup() {
        isScanning = false
        isFirstApplyOrientation = false
        capture = ZXCapture()
        guard let _capture = capture else { return }
        _capture.camera = _capture.back()
        _capture.focusMode =  .continuousAutoFocus
        _capture.delegate = self
        self.scanView.layer.addSublayer(_capture.layer)
        
        self.scanView.bringSubviewToFront(viewPanelHeader)
        self.scanView.bringSubviewToFront(viewPanelFooter)
       
        lbScannerRectangle.layer.masksToBounds = true
        lbScannerRectangle.layer.cornerRadius = self.regionCornerRadius
        lbScannerRectangle.layer.borderColor = UIColor.white.cgColor
        lbScannerRectangle.layer.borderWidth = 2.0
        cornerView.setFrameSize(roi: lbScannerRectangle)
        cornerView.drawCorners()
        self.cornerView.isHidden = true
        
        self.scanView.bringSubviewToFront(cornerView)
        self.scanView.bringSubviewToFront(lbScannerRectangle)
        self.scanView.bringSubviewToFront(lbQRTitle)
        self.scanView.bringSubviewToFront(lbQRStatus)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstApplyOrientation == true { return }
        isFirstApplyOrientation = true
        applyOrientation()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            // do nothing
        }) { [weak self] (context) in
            guard let weakSelf = self else { return }
            weakSelf.applyOrientation()
        }
    }
    
    @objc func actionFlash(sender : UITapGestureRecognizer){
        log(message: "actionFlash")
        GalleryHelper.flashlight()
    }
    
    @objc func actionGallery(sender : UITapGestureRecognizer){
       log(message: "actionGallery")
       onTakeGallery()
    }
    
    @objc func actionScanQR(sender : UITapGestureRecognizer){
        log(message: "actionScanQR")
    }
    
    @objc func actionCreatedQR(sender : UITapGestureRecognizer){
        log(message: "actionCreatedQR")
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.qrCodeHistory, isNavigation: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        log(message: "viewDidAppear")
        self.viewModel.defaultValue()
        registerEventBus()
        self.viewModel.askCameraPermission()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.cornerView.layer.borderColor = AppColors.BLUE.cgColor
    }
    
    override func scannerResult(data: ReceiveQRCodeData) {
        log(message: "scanner result.....")
        log(object: data)
    }
    
    override func actionAlertYes() {
        viewModel.openAppSetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        GalleryHelper.flashlight(isOff: true)
    }
    
    override func updateActionToObjectView(obj: EventBusObjectData) {
        switch obj.type {
            case DataKeyType.QRResultData:
                let data: QRResultData = obj.data as! QRResultData
                // this case a little bit complex because This VC will observe from it's viewModel so the identify is ScannerVC
                // but after observe it need nav to PayToVC and bus event to PayToVC at this time PayToVC will observe will wait
                // for event with identify is ScannerVC
                if (obj.identify == EnumViewControllerNameIdentifier.ScannerVC) {
                    tabBarController?.selectedIndex = 0
                    if(data.target == EnumViewControllerNameIdentifier.PayToVC.rawValue){
                        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.payTo, isNavigation: false, present: true)
                        let obj = EventBusObjectData(data: data.valueObject, type: DataKeyType.StringOriginal, identify: EnumViewControllerNameIdentifier.ScannerVC)
                        CommonService.eventPushActionToObjectView(obj: obj)
                    } else if (data.target == EnumViewControllerNameIdentifier.InfoTransactionOptionsVC.rawValue && data.valueObjectType == DataKeyType.TransferDataModel) {
                        // Popup payment
                        tabBarController?.selectedIndex = 0
                    }
                    
                }
                break
            default:
                break
            }
    }
}

