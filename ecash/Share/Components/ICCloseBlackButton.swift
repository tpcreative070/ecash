//
//  ICCloseBlackButton.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
import UIKit
class ICCloseBlackButton : UIButton{
    
    var width = AppConstants.IC_CLOSE_HEIGHT
    var height = AppConstants.IC_CLOSE_WIDTH
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.setImage(#imageLiteral(resourceName: "ic_close_black").withRenderingMode(.alwaysOriginal), for: .normal)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: CGFloat(width)),
            self.widthAnchor.constraint(equalToConstant: CGFloat(height))
            ])
    }
}
