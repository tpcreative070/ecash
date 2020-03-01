//
//  CustomThumbView.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
final class ICCustomThumbView: UIView {
    fileprivate(set) var thumbImageView = UIImageView(frame: CGRect.zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.thumbImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.thumbImageView)
    }
}

extension ICCustomThumbView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.thumbImageView.frame = CGRect(x: 0, y: 0, width: 20, height: self.frame.height)
        self.thumbImageView.layer.cornerRadius = self.layer.cornerRadius
        self.thumbImageView.clipsToBounds = self.clipsToBounds
    }
}
