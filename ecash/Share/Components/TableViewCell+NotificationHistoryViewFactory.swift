//
//  TableViewCell+NotificationHistoryViewFactory.swift
//  ecash
//
//  Created by phong070 on 11/23/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupNotificationHistorySubView(){
        self.backGroundView.addSubview(self.viewRoot)
        self.backGroundView.backgroundColor = AppColors.GRAY_LIGHT_90
        NSLayoutConstraint.activate([
            self.viewRoot.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 20),
            self.viewRoot.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -20),
            self.viewRoot.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.viewRoot.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
        ])
        self.viewRoot.addSubview(lbMessage)
        NSLayoutConstraint.activate([
            self.lbMessage.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 20),
            self.lbMessage.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: 0),
            self.lbMessage.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 0)
        ])
        
        self.viewRoot.addSubview(self.lbCreatedDate)
        NSLayoutConstraint.activate([
            self.lbCreatedDate.topAnchor.constraint(equalTo: self.lbMessage.bottomAnchor,constant: 10),
            self.lbCreatedDate.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -20),
            self.lbCreatedDate.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: -10),
            self.lbCreatedDate.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 0)
        ])
        self.lbCreatedDate.textAlignment = .right
        
        self.lbMessage.lineBreakMode = .byWordWrapping
        self.lbMessage.numberOfLines = 0
        
        self.viewRoot.addSubview(self.viewUnderLine)
        NSLayoutConstraint.activate([
            self.viewUnderLine.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor),
            self.viewUnderLine.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor),
            self.viewUnderLine.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor),
            self.viewUnderLine.heightAnchor.constraint(equalToConstant: 1)])
        self.viewUnderLine.backgroundColor = .white
    }
}
