//
//  String+Attribute.swift
//  vietlifetravel
//
//  Created by phong070 on 7/13/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import UIKit
extension String {
    func toColorAttribute(value : String, value2 : String? = nil, color : UIColor)-> NSAttributedString {
        let string_to_color = value
        let mFont = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        let boldFontAttribute = [NSAttributedString.Key.font:mFont]
        let range = (self as NSString).range(of: string_to_color)
        let attribute = NSMutableAttributedString.init(string: self)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        if let mValue2 = value2 {
             let range2 = (self as NSString).range(of: mValue2)
             attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range2)
        }
        return attribute
    }
}
