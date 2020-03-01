//
//  ICLabel.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class ICLabel : UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    func setupView() {
        self.textAlignment = .left
        self.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.textColor = AppColors.BLACK_COLOR
    }
    
    var isBold : Bool! {
        didSet{
            if isBold {
                self.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
            }
        }
    }
}
