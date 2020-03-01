//
//  HeaderView+ViewFactory.swift
//  vietlifetravel
//
//  Created by phong070 on 7/6/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension HeaderView{
    func setupView(){
        self.setupBackgroud()
        switch identifier {
        case .Contact:
           self.setupSubView()
           break
        case .Transactions:
           self.setupSubView()
            break
        case .QRCodeHistory:
           self.setupQrcodeHistorySubView()
           break
        default:
           break
        }
    }
    
    fileprivate func setupBackgroud(){
        self.addSubview(self.backGroundView)
        NSLayoutConstraint.activate([
            self.backGroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.backGroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.backGroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.backGroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0)
            ])
    }
    
    fileprivate func setupSubView(){
        self.backGroundView.addSubview(self.lbGroupName)
        NSLayoutConstraint.activate([
            self.lbGroupName.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 10),
            self.lbGroupName.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: -10),
            self.lbGroupName.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.lbGroupName.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
            ])
    }
    
    fileprivate func setupQrcodeHistorySubView(){
        self.backGroundView.addSubview(self.lbGroupName)
        NSLayoutConstraint.activate([
            self.lbGroupName.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 10),
            self.lbGroupName.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: -10),
            self.lbGroupName.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.lbGroupName.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
            ])
    }
}
