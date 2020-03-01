//
//  TableViewCell+ViewFactory.swift
//  vietlifetravel
//
//  Created by Mac10 on 7/3/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
extension TableViewCell {
    func setupView(){
        self.setupBackgroud()
        switch identifier {
        case .TransfereCashToeCash:
            setupSubView()
            break
        case .WithdrawMultipleeCash :
            setupWithdrawMultipleeCashSubView()
            break
        case .Contact:
            setupContactsSubView()
            break
        case .Transactions:
           setupTransactionsLogsSubView()
           break
        case .QRCodeHistory:
            setupQRCodeHistorySubView()
            break
        case .ScannerResult:
            setupScannerResultSubView()
            break
        case .ExchangeeCash :
            setupExchangeeCashSubView()
            break
        case .ExchangeeCashAvailable :
            setupExchangeeCashAvailableSubView()
            break
        case .ExpectationCash :
            setupExpectationCashSubView()
            break
        case .AddContact :
            setupAddContactsSubView()
            break
        case .TransactionsLogsDetail :
            setupTransactionsLogsDetailSubView()
            break
        case .NotificationHistory :
            setupNotificationHistorySubView()
            break
        case .ExchangeOverviewOptions :
            setupExchangeCashOverviewSubView()
            break
        case .ExpectationOverviewOptions :
            setupExpectationCashOverviewSubView()
            break
        case .Denomination :
            setupAddCashSubView()
            break
        case .SendLixi :
            setupSendLixiSubView()
            break
        case .Lixi :
            setupLixiSubView()
            break
        case .ReceiveLixiOptions :
            setupReceiveLixiOptionsSubView()
            break
        case .PayInfo:
            setupPayInfoSubView()
            break
        default :
            break
        }
    }
    
    func setupBackgroud(){
        self.addSubview(self.backGroundView)
        NSLayoutConstraint.activate([
            self.backGroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:10),
            self.backGroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.backGroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.backGroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            ])
        //add gesture to leftView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionCellViewTap))
        self.backGroundView.addGestureRecognizer(tapGesture)
    }
    
    func setupSubView(){
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
