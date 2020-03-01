//
//  View+Corner.swift
//  ecash
//
//  Created by phong070 on 8/28/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension UIView {
    func setRadius(corner: CGFloat? = nil, color : UIColor) {
        self.layer.cornerRadius = corner ?? self.frame.width / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
    
    func setShadow(color : UIColor,corner : CGFloat? = nil) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = corner ?? self.frame.width / 2
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
    
    func setCorner(corner: CGFloat? = nil, color : UIColor) {
        self.layer.cornerRadius = corner ?? self.frame.width / 2
        self.layer.masksToBounds = true
        self.layer.backgroundColor = color.cgColor
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}
