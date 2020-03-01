//
//  TableViewCell+AddContact.swift
//  ecash
//
//  Created by phong070 on 11/2/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupAddContactsSubView(){
        self.backGroundView.addSubview(self.viewRoot)
        NSLayoutConstraint.activate([
            self.viewRoot.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 0),
            self.viewRoot.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -0),
            self.viewRoot.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.viewRoot.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor,constant: -0)
            ])
        self.viewRoot.backgroundColor = AppColors.GRAY_LIGHT
        
        self.viewRoot.addSubview(imgAvatar)
        NSLayoutConstraint.activate([
            self.imgAvatar.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor,constant: 10),
            self.imgAvatar.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 10),
            self.imgAvatar.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -10),
            self.imgAvatar.widthAnchor.constraint(equalToConstant: 50),
            self.imgAvatar.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        self.viewRoot.addSubview(imgCode)
        NSLayoutConstraint.activate([
            self.imgCode.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor,constant: -30),
            self.imgCode.centerYAnchor.constraint(equalTo: self.viewRoot.centerYAnchor),
            self.imgCode.widthAnchor.constraint(equalToConstant: 8),
            self.imgCode.heightAnchor.constraint(equalToConstant: 30)
            ])
        self.imgCode.image = UIImage(named: AppImages.IC_MORE)
        self.imgCode.isUserInteractionEnabled = true
        self.imgCode.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCellViewTap))
        self.imgCode.addGestureRecognizer(tapGesture)
        
        self.viewRoot.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.imgAvatar.trailingAnchor,constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: self.imgCode.trailingAnchor,constant: -10),
            self.stackView.topAnchor.constraint(equalTo: self.viewRoot.topAnchor,constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor,constant: -10)
            ])
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = UIStackView.Distribution.fillEqually
        self.stackView.spacing = 5
        self.stackView.addArrangedSubview(lbName)
        self.stackView.addArrangedSubview(lbPhoneNumber)
        self.viewRoot.addSubview(self.viewUnderLine)
        
        NSLayoutConstraint.activate([
            self.viewUnderLine.leadingAnchor.constraint(equalTo: self.viewRoot.leadingAnchor),
            self.viewUnderLine.trailingAnchor.constraint(equalTo: self.viewRoot.trailingAnchor),
            self.viewUnderLine.bottomAnchor.constraint(equalTo: self.viewRoot.bottomAnchor),
            self.viewUnderLine.heightAnchor.constraint(equalToConstant: 1)
            ])
        self.viewUnderLine.backgroundColor = .white
    }
}
