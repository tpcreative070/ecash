//
//  GalleryHelper.swift
//  ecash
//
//  Created by phong070 on 7/29/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
import AVFoundation
class GalleryHelper {
    class open func showGallery() -> FDTakeController{
        let fdTakeController = FDTakeController()
        fdTakeController.allowsPhoto = true
        fdTakeController.allowsVideo = true
        fdTakeController.allowsTake = true
        fdTakeController.allowsSelectFromLibrary = true
        fdTakeController.allowsEditing = true
        fdTakeController.defaultsToFrontCamera = true
        fdTakeController.iPadUsesFullScreenCamera = true
        fdTakeController.didGetPhoto = {
            (photo: UIImage, info: [AnyHashable : Any]) -> Void in
            let alert = UIAlertController(title: "Got photo", message: "User selected photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            // http://stackoverflow.com/a/34487871/300224
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        fdTakeController.didGetVideo = {
            (video: URL, info: [AnyHashable : Any]) in
            let alert = UIAlertController(title: "Got photo", message: "User selected photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            // http://stackoverflow.com/a/34487871/300224
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
        return fdTakeController
    }
    
    class open func flashlight(isOff : Bool? = nil) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else{
            return
        }
        
        if let mOff = isOff{
            if mOff {
                if (device.hasTorch) {
                    do {
                        try device.lockForConfiguration()
                        if (device.torchMode == .on) {
                            device.torchMode = .off
                        }
                        device.unlockForConfiguration()
                    } catch {
                        print("Torch could not be used")
                        print(error)
                    }
                }
                else{
                    print("Torch is not available")
                }
                return
            }
        }
        
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == .on) {
                    device.torchMode = .off
                } else {
                    device.torchMode = .on
                }
                device.unlockForConfiguration()
            } catch {
                
                print("Torch could not be used")
                print(error)
            }
        }
        else{
            print("Torch is not available")
        }
    }
}
