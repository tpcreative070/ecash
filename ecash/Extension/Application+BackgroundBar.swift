//
//  Application+BackgroundBar.swift
//  ecash
//
//  Created by phong070 on 9/4/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
