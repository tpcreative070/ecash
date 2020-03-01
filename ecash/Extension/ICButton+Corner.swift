//
//  ICButton+Corner.swift
//  vietlifetravel
//
//  Created by phong070 on 7/16/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension ICButton {
    func cornerButton(corner : Int,color : UIColor){
        self.cornerRadius = CGFloat(corner)
        self.bottomGradientColor = color
        self.topGradientColor = color
    }
}
