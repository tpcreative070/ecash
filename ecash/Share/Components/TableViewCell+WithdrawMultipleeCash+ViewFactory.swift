//
//  TableViewCell+WithdrawMultipleeCash+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/31/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    
    func setupWithdrawMultipleeCashSubView(){
        self.backGroundView.addSubview(self.control)
        NSLayoutConstraint.activate([
            self.control.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant:-10),
            self.control.widthAnchor.constraint(equalToConstant: 100),
            self.control.heightAnchor.constraint(equalToConstant: 40),
            self.centerYAnchor.constraint(equalTo: self.backGroundView.centerYAnchor)
            ])
        
        self.backGroundView.addSubview(self.lbCount)
        NSLayoutConstraint.activate([
            self.lbCount.trailingAnchor.constraint(equalTo: self.control.leadingAnchor, constant:-50),
            self.lbCount.centerYAnchor.constraint(equalTo: self.control.centerYAnchor),
            self.lbCount.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        self.backGroundView.addSubview(self.lbMoney)
        NSLayoutConstraint.activate([
            self.lbMoney.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 0),
            self.lbMoney.trailingAnchor.constraint(equalTo: self.lbCount.leadingAnchor, constant:10),
            self.lbMoney.centerYAnchor.constraint(equalTo: self.lbCount.centerYAnchor)
            ])
    }
}
