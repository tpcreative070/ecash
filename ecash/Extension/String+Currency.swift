//
//  String+Currency.swift
//  vietlifetravel
//
//  Created by phong070 on 7/6/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension String {
    func toCurrency()->String{
        if let myCurrency = Int(self){
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            // localize to your grouping and decimal separator
            currencyFormatter.locale = Locale.current
            return currencyFormatter.string(from: NSNumber(value: myCurrency)) ?? ""
        }
        return "0.0"
    }
    
    /*
    func toMoney() -> String {
        if let myCurrency = Int(self){
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            // localize to your grouping and decimal separator
            currencyFormatter.locale =  Locale(identifier: "en_VN")
            debugPrint("curent curency \(Locale.current)")
            return currencyFormatter.string(from: NSNumber(value: myCurrency)) ?? ""
        }
        return "0.0"
    }
    */
    
    func toMoney() -> String {
        if let myCurrency = Int(self){
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale =  Locale(identifier: "en_VN")
            let result: String = currencyFormatter.string(from: NSNumber(value: myCurrency)) ?? ""
            return "\(result.filter("0123456789,.".contains)) VNĐ"
        }
        return "0 VNĐ"
    }
    
    func toFlightCode()->String{
        if self == "Vietnam Airlines"{
            return "VN"
        }
        else if self == "Jetstar Pacific"{
            return "BL"
        }
        else if self == "Vietjet Air" {
            return "VJ"
        }
        return self
    }
    
    func withSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        switch Locale.current.languageCode {
        case "vi":
            let input = self.filter("0123456789".contains)
            if let myCurrency = Int(input){
                return formatter.string(for: NSNumber(value: myCurrency)) ?? ""
            }
            break
        default:
            let input = self.filter("0123456789.".contains)
            if let myCurrency = Double(input){
                return formatter.string(for: NSNumber(value: myCurrency)) ?? ""
            }
        }
        return ""
    }
    
    func getAllNumber() -> Int {
        return Int(self.filter("0123456789".contains)) ?? 0
    }
}
