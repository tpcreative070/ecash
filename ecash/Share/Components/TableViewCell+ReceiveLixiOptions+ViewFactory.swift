//
//  TableViewCell+ReceiveLixiOptions+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//


import UIKit
extension TableViewCell {
    func setupReceiveLixiOptionsSubView(){
        self.backGroundView.addSubview(self.viewRoot)
        NSLayoutConstraint.activate([
            self.viewRoot.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 0),
            self.viewRoot.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -0),
            self.viewRoot.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.viewRoot.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
            ])
        self.viewRoot.backgroundColor = AppColors.WHITE_COLOR
        
        self.viewRoot.addSubview(viewAction)
        NSLayoutConstraint.activate([
            self.viewAction.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: -20),
            self.viewAction.widthAnchor.constraint(equalToConstant: 50),
            self.viewAction.heightAnchor.constraint(equalToConstant: 50),
            self.viewAction.centerYAnchor.constraint(equalTo: self.viewRoot.centerYAnchor)
            ])
        
        
        self.viewAction.addSubview(lbCount)
        NSLayoutConstraint.activate([
            self.lbCount.topAnchor.constraint(equalTo: self.viewAction.topAnchor,constant: 0),
            self.lbCount.bottomAnchor.constraint(equalTo: self.viewAction.bottomAnchor,constant: 0),
            self.lbCount.trailingAnchor.constraint(equalTo: self.viewAction.trailingAnchor,constant: 0),
            self.lbCount.leadingAnchor.constraint(equalTo: self.viewAction.leadingAnchor,constant: 0)
            ])
        
        self.viewRoot.addSubview(lbMoney)
        NSLayoutConstraint.activate([
            self.lbMoney.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 20),
            self.lbMoney.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -20),
            self.lbMoney.trailingAnchor.constraint(equalTo: self.viewAction.leadingAnchor,constant: -20),
            self.lbMoney.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 20)
            ])
    }
    
}
