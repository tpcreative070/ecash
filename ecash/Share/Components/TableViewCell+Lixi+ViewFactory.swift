//
//  TableViewCell+Lixi+ViewFactory.swift
//  ecash
//
//  Created by phong070 on 12/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupLixiSubView(){
        
        self.backGroundView.addSubview(self.viewRoot)
        NSLayoutConstraint.activate([
            self.viewRoot.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 0),
            self.viewRoot.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -0),
            self.viewRoot.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.viewRoot.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
            ])
        
        self.viewRoot.backgroundColor = AppColors.GRAY_LIGHT
    
        self.viewRoot.addSubview(imgIcon)
        NSLayoutConstraint.activate([
            self.imgIcon.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 20),
            self.imgIcon.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -20),
            self.imgIcon.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 20),
            self.imgIcon.widthAnchor.constraint(equalToConstant: 30),
            self.imgIcon.heightAnchor.constraint(equalToConstant: 40),
            self.imgIcon.centerYAnchor.constraint(equalTo: self.viewRoot.centerYAnchor)
            ])
        
        self.viewRoot.addSubview(self.viewSub)
                   NSLayoutConstraint.activate([
                self.viewSub.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor, constant: -30),
                self.viewSub.widthAnchor.constraint(equalToConstant: 30),
                self.viewSub.topAnchor.constraint(equalTo: self.viewRoot.topAnchor),
                self.viewSub.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor)
        ])
        
        self.viewSub.addSubview(self.imgCode)
                  NSLayoutConstraint.activate([
                      self.imgCode.trailingAnchor.constraint(equalTo: self.viewSub.trailingAnchor, constant: 0),
                      self.imgCode.widthAnchor.constraint(equalToConstant: 30),
                      self.imgCode.heightAnchor.constraint(equalToConstant: 30),
                      self.imgCode.topAnchor.constraint(equalTo: self.viewSub.topAnchor,constant: 10)
             ])
        
        self.viewRoot.addSubview(self.lbTitle)
        NSLayoutConstraint.activate([
            self.lbTitle.leadingAnchor.constraint(equalTo: self.imgIcon.trailingAnchor,constant: 20),
            self.lbTitle.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: -20),
            self.lbTitle.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 15),
        ])
        
        self.viewRoot.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.imgIcon.trailingAnchor,constant: 20),
            self.stackView.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: -20),
            self.stackView.topAnchor.constraint(equalTo: self.lbTitle.topAnchor,constant: 25),
            self.stackView.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -10)
            ])
        
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        self.stackView.distribution = UIStackView.Distribution.fillEqually
        self.stackView.spacing = 0
        self.stackView.addArrangedSubview(lbDetail)
        self.stackView.addArrangedSubview(lbCreatedDate)
        self.lbCreatedDate.textAlignment = .right
        self.viewRoot.addSubview(self.viewUnderLine)
        NSLayoutConstraint.activate([
            self.viewUnderLine.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor),
            self.viewUnderLine.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor),
            self.viewUnderLine.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor),
            self.viewUnderLine.heightAnchor.constraint(equalToConstant: 1)
            ])
        self.viewUnderLine.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCellViewAction))
        imgCode.addGestureRecognizer(tapGesture)
        imgCode.isUserInteractionEnabled  = true
    }
}

