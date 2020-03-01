//
//  ExchangeCashSingleton.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ShareExchangeCashSingleton {
    static let shared = ShareExchangeCashSingleton()
    private var any : Any?
    typealias Listener = (() -> Void)
    private var listener: Listener?
    
    private init() {
    }
    
    func set<T : Codable>(value : T){
        self.any = value
    }
    
    func bindData(){
        self.listener!()
    }
    
    func get<T : Codable>(value : T.Type) ->T?{
        do{
            if let anyObject = self.any{  let jsonData = JSONSerializerHelper.toJson(anyObject).data(using: .utf8)
                if let jsonDataValue = jsonData{
                    return try JSONDecoder().decode(value.self, from: jsonDataValue)
                }
            }
        }catch{
            Utils.logMessage(message: "Could not cast data")
        }
        return value as? T
    }
    
    /**
     bind event for uitexfield or custom event
     */
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
