//
//  ShareApplicationSingleton.swift
//  ecash
//
//  Created by ECAPP on 2/1/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class ShareApplicationSingleton{
    static let shared = ShareApplicationSingleton()
    private var myMapData: Dictionary<String, Any> = Dictionary()
    
    func set<T>(key : String, value : T){
        self.myMapData[key] = value
    }
    
    func get(key: String) -> Any {
        print("-=-==-==-=-=-=-ShareApplicationSingleton=-==-==-=-=-=")
        dump(self.myMapData[key])
        return self.myMapData[key] as Any
    }
}
