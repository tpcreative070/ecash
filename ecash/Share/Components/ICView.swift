//
//  ICView.swift
//  vietlifetravel
//
//  Created by phong070 on 7/16/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
@IBDesignable
class ICView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
