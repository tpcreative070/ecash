//
//  TableViewCell+PayToInfo+ViewFactory.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupPayInfoSubView(){
        
        self.backGroundView.addSubview(self.viewRoot)
        NSLayoutConstraint.activate([
            self.viewRoot.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 0),
            self.viewRoot.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: 0),
            self.viewRoot.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.viewRoot.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: 0)
        ])
        
        self.viewRoot.addSubview(self.lbMoney)
        NSLayoutConstraint.activate([
            self.lbMoney.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 0),
            self.lbMoney.centerYAnchor.constraint(equalTo: self.viewRoot.centerYAnchor)
        ])
        
        self.viewRoot.addSubview(self.viewAction)
        NSLayoutConstraint.activate([
            self.viewAction.centerYAnchor.constraint(equalTo: self.viewRoot.centerYAnchor),
            self.viewAction.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor, constant: -10),
            self.viewAction.widthAnchor.constraint(equalToConstant: 36.0),
            self.viewAction.heightAnchor.constraint(equalToConstant: 36.0)
        ])
        
        self.viewAction.backgroundColor = AppColors.GRAY_LIGHT
        self.viewAction.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
        self.viewAction.addSubview(self.lbCount)
        NSLayoutConstraint.activate([
            self.lbCount.centerXAnchor.constraint(equalTo: self.viewAction.centerXAnchor),
            self.lbCount.centerYAnchor.constraint(equalTo: self.viewAction.centerYAnchor)
        ])
        self.lbCount.textAlignment = NSTextAlignment.center
        self.lbCount.textColor = AppColors.BLACK_COLOR
    }
}

