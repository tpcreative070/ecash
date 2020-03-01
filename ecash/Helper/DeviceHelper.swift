//
//  DeviceHelper.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class DeviceHelper {
    /**
     This function check current device is Iphone SE, Iphone 5, Iphone 5s
     */
    static func isSmallScreen() -> Bool {
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone5C:
            return true
        default:
            return false
        }
    }
    
    /**
     This function check current device is Iphone SE, Iphone 5, Iphone 5s
     */
    static func isNormalScreen() -> Bool {
        switch UIDevice().type {
        case .iPhone6, .iPhone7, .iPhone8, .iPhone6S:
            return true
        default:
            return false
        }
    }
    
    /**
     This function check current device is Iphone 6 plus, Iphone 7 plus, Iphone 8 plus, Iphone XR, Iphone XS
     */
    static func isPlusScreen() -> Bool {
        switch UIDevice().type {
        case .iPhone6plus, .iPhone7plus, .iPhone8plus, .iPhone6Splus, .iPhoneX:
            return true
        default:
            return false
        }
    }
    
    /**
     This function check current device is Iphone XSMAX
     */
    static func isMaxScreen() -> Bool {
        switch UIDevice().type {
        case .iPhoneXSmax, .iPhoneXR, .iPhoneXS:
            return true
        default:
            return false
        }
    }
    
    static func isXSmax() -> Bool {
        switch UIDevice().type {
        case .iPhoneXSmax:
            return true
        default:
            return false
        }
    }
    
    /**
     This function check current device is IPad 2...4
     */
    static func isIpad() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        } else {
            return false
        }
    }
    
    /**
     Check hasNotch Xr
    */
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    /**
     Fetch device's info
    */
    static func getDeviceInfo() -> String{
        let device = UIDevice.current
        return device.type.rawValue
    }
    
    /**
     Fetch device's unique id
    */
    static func getUniqueId() ->String{
        let device = UIDevice.current
        return device.currentUUID()
    }
    
}

