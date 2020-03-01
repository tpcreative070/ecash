//
//  ICButtonCustom.swift
//  ecash
//
//  Created by phong070 on 10/17/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ICButtonCustom : UIButton {
    var width = AppConstants.IC_CLOSE_HEIGHT
    var height = AppConstants.IC_CLOSE_WIDTH
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView(image: nil)
    }
    
    init(image : UIImage,frame : CGRect) {
        super.init(frame: frame)
        self.setupView(image: image)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(image : UIImage?  = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: CGFloat(width)),
            self.widthAnchor.constraint(equalToConstant: CGFloat(height))
            ])
    }
}
