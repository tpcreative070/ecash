//
//  ICViewHalfColor.swift
//  ecash
//
//  Created by phong070 on 9/4/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
@IBDesignable
class ICViewHalf : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.BLUE
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let topRect = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: rect.size.width, height: rect.size.height / 2)
        )
        UIColor.init(cgColor: AppColors.BLUE.cgColor).set()
        UIRectFill(topRect)
        
        let bottomRect = CGRect(
            origin: CGPoint(x: rect.origin.x, y: rect.height / 2),
            size: CGSize(width: rect.size.width, height: rect.size.height / 2)
        )
        UIColor.init(cgColor: AppColors.WHITE_COLOR.cgColor).set()
        UIRectFill(bottomRect)
    }
}
