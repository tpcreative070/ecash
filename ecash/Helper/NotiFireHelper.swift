//
//  NotiFireHelper.swift
//  vietlifetravel
//
//  Created by phong070 on 7/17/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class NotiFireHelper {
    class func showMessageBar(message : String){
        ICNotifire.shared.title.font =  AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        ICNotifire.shared.title.textAlignment = .center
        ICNotifire.shared.show(type: .error, message: message)
    }
}
