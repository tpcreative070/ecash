//
//  Utils.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class Utils : NSObject{
    /*We can creare func here. where the func was called many times*/
    static func logMessage(message : String){
        #if DEBUG
        print(message)
        #endif
    }
    
    static func logMessage(object : Any){
        #if DEBUG
        print(JSONSerializerHelper.toJson(object))
        #endif
    }
    
    static func getDeviceId() -> String{
        return UIDevice.current.identifierForVendor?.uuidString ?? "ldman12345679"
    }
}

