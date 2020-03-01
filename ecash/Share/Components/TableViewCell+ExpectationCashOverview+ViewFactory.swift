//
//  TableViewCell+ExpectationCashOverview+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit

extension TableViewCell {
    func setupExpectationCashOverviewSubView(){
          self.backGroundView.addSubview(self.lbCount)
          NSLayoutConstraint.activate([
              self.lbCount.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant:-10),
              self.lbCount.widthAnchor.constraint(equalToConstant: 40),
              self.lbCount.heightAnchor.constraint(equalToConstant: 40),
              self.centerYAnchor.constraint(equalTo: self.backGroundView.centerYAnchor)
              ])
          
          self.backGroundView.addSubview(self.lbMoney)
          NSLayoutConstraint.activate([
              self.lbMoney.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 0),
              self.lbMoney.trailingAnchor.constraint(equalTo: self.lbCount.leadingAnchor, constant:10),
              self.lbMoney.centerYAnchor.constraint(equalTo: self.lbCount.centerYAnchor)
              ])
      }
}
