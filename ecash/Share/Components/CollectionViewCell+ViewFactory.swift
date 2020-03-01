//
//  CollectionViewCell+ViewFactory.swift
//  vietlifetravel
//
//  Created by phong070 on 7/12/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension CollectionViewCell {
    
    func setupView(){
        self.setupBackgroud()
        switch CollectionViewCell.identifier {
        case .PaymentServices:
            setupSubView()
            break
        case .Intro :
            setupIntroSubView()
            break
        case .SendLixi:
            setupSendLixiSubView()
            break
        default :
            break
        }
    }
    
    func setupBackgroud(){
        self.addSubview(self.backGroundView)
        NSLayoutConstraint.activate([
            self.backGroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:0),
            self.backGroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.backGroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.backGroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            ])
        backGroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (IndexTapped(sender:))))
    }

    func setupSubView(){
        self.backGroundView.addSubview(self.imgIcon)
        NSLayoutConstraint.activate([
            self.imgIcon.widthAnchor.constraint(equalToConstant: 25),
            self.imgIcon.heightAnchor.constraint(equalToConstant: 25),
            self.imgIcon.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 10),
            self.imgIcon.centerXAnchor.constraint(equalTo: self.backGroundView.centerXAnchor)
            ])
        self.backGroundView.addSubview(self.lbName)
        NSLayoutConstraint.activate([
              self.lbName.topAnchor.constraint(equalTo: self.imgIcon.bottomAnchor,constant: 10),
              self.lbName.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 5),
              self.lbName.trailingAnchor.constraint(lessThanOrEqualTo: self.backGroundView.trailingAnchor,constant: -5),
              self.lbName.bottomAnchor.constraint(lessThanOrEqualTo: self.backGroundView.bottomAnchor,constant: -5),
              self.lbName.centerXAnchor.constraint(equalTo: self.backGroundView.centerXAnchor)
            ])
    }
    
    func setupIntroSubView(){
        self.backGroundView.addSubview(lbTitle)
        NSLayoutConstraint.activate([
            self.lbTitle.topAnchor.constraint(equalTo: self.backGroundView.topAnchor,constant: 0),
            self.lbTitle.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor,constant: 20),
            self.lbTitle.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor,constant: -20)
        ])
        self.backGroundView.addSubview(lbDetail)
              NSLayoutConstraint.activate([
                  self.lbDetail.topAnchor.constraint(equalTo: self.lbTitle.bottomAnchor,constant: 0),
                  self.lbDetail.leadingAnchor.constraint(equalTo: self.lbTitle.leadingAnchor,constant: 0),
                  self.lbDetail.trailingAnchor.constraint(equalTo: self.lbTitle.trailingAnchor,constant: 0)
              ])
        self.backGroundView.addSubview(self.imgIcon)
        NSLayoutConstraint.activate([
            self.imgIcon.topAnchor.constraint(equalTo: self.lbDetail.bottomAnchor,constant: 50),
            self.imgIcon.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor),
            self.imgIcon.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor),
            self.imgIcon.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor)
        ])
        debugPrint("Call show image")
    }
    
    func setupSendLixiSubView(){
        self.backGroundView.addSubview(imgIcon)
         NSLayoutConstraint.activate([
            self.imgIcon.widthAnchor.constraint(equalToConstant: 70),
            self.imgIcon.heightAnchor.constraint(equalToConstant: 70),
            self.imgIcon.centerXAnchor.constraint(equalTo: self.backGroundView.centerXAnchor),
            self.imgIcon.centerYAnchor.constraint(equalTo: self.backGroundView.centerYAnchor)
         ])
     }
    
}
