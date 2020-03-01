//
//  TextField.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
@IBDesignable
class TextField: UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  func setupView() {
    self.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
  }
}
