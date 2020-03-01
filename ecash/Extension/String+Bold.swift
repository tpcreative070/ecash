//
//  String+Bold.swift
//  ecash
//
//  Created by phong070 on 10/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension  UIFont {
    func toBoldFont() -> UIFont {
         let mValue  = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        return mValue
    }
}
