//
//  TableViewCell+TransactionHistory+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 10/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupTransactionsLogsSubView(){
        self.backGroundView.addSubview(self.viewRoot)
        NSLayoutConstraint.activate([
            self.viewRoot.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 0),
            self.viewRoot.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -0),
            self.viewRoot.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.viewRoot.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
            ])
       
        self.viewRoot.addSubview(imgAvatar)
        NSLayoutConstraint.activate([
            self.imgAvatar.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 10),
            self.imgAvatar.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 15),
            self.imgAvatar.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -15),
            self.imgAvatar.widthAnchor.constraint(equalToConstant: 60),
            self.imgAvatar.heightAnchor.constraint(equalToConstant: 60)
            ])
        
        self.viewRoot.addSubview(self.stackViewRoot)
        NSLayoutConstraint.activate([
            self.stackViewRoot.leadingAnchor.constraint(equalTo: self.imgAvatar.trailingAnchor,constant: 10),
            self.stackViewRoot.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: -30),
            self.stackViewRoot.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 10),
            self.stackViewRoot.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -10),
            ])
        
        self.stackViewRoot.axis = .horizontal
        self.stackViewRoot.alignment = .fill
        self.stackViewRoot.distribution = UIStackView.Distribution.fillEqually
        self.stackViewRoot.spacing = 5
        
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = UIStackView.Distribution.fillEqually
        self.stackView.spacing = 5
        self.stackView.addArrangedSubview(lbfullNameView)
        self.stackView.addArrangedSubview(lbtransactionType)
        self.stackView.addArrangedSubview(lbtransactionStatus)
        
        self.stackView1.axis = .vertical
        self.stackView1.alignment = .fill
        self.stackView1.distribution = UIStackView.Distribution.fillEqually
        self.stackView1.spacing = 5
        self.stackView1.addArrangedSubview(lbtransactionAmount)
        self.stackView1.addArrangedSubview(lbtransactionDate)
        
        self.stackViewRoot.addArrangedSubview(self.stackView)
        self.stackViewRoot.addArrangedSubview(self.stackView1)
        self.viewRoot.addSubview(self.viewUnderLine)
        
        NSLayoutConstraint.activate([
            self.viewUnderLine.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 20),
            self.viewUnderLine.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor),
            self.viewUnderLine.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor),
            self.viewUnderLine.heightAnchor.constraint(equalToConstant: 1)
            ])
        self.viewUnderLine.backgroundColor = AppColors.GRAY
    }
}
