//
//  TableViewCell+ExchangeeCash+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupExchangeeCashSubView(){
          
        self.backGroundView.addSubview(self.lbMoney)
        NSLayoutConstraint.activate([
            self.lbMoney.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 20),
            self.lbMoney.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -20),
            self.lbMoney.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 0)
            ])
        
        self.backGroundView.addSubview(viewAction)
        NSLayoutConstraint.activate([
            self.viewAction.leadingAnchor.constraint(equalTo: self.lbMoney.trailingAnchor),
            self.viewAction.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -10),
            self.viewAction.widthAnchor.constraint(equalToConstant: 50),
            self.viewAction.heightAnchor.constraint(equalToConstant: 50),
            self.viewAction.centerYAnchor.constraint(equalTo: self.lbMoney.centerYAnchor)
            ])
      
        
        self.viewAction.addSubview(lbCount)
        NSLayoutConstraint.activate([
            self.lbCount.topAnchor.constraint(equalTo: self.viewAction.topAnchor,constant: 5),
            self.lbCount.bottomAnchor.constraint(equalTo: self.viewAction.bottomAnchor,constant: -5),
            self.lbCount.trailingAnchor.constraint(equalTo: self.viewAction.trailingAnchor,constant: -5),
            self.lbCount.leadingAnchor.constraint(equalTo: self.viewAction.leadingAnchor,constant: 5)
            ])
    }
}
