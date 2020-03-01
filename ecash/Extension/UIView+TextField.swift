//
//  UIView+TextField.swift
//  vietlifetravel
//
//  Created by phong070 on 7/17/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension UIView {
    var textFieldsInView: [UITextField] {
        return subviews
            .filter ({ !($0 is UITextField) })
            .reduce (( subviews.compactMap { $0 as? UITextField }), { summ, current in
                return summ + current.textFieldsInView
            })
    }
    var selectedTextField: UITextField? {
        return textFieldsInView.filter { $0.isFirstResponder }.first
    }
}
