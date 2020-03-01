//
//  ECashSigner.swift
//  eWalletTests
//
//  Created by FPT Mac on 7/20/18.
//  Copyright © 2018 Hung Vu. All rights reserved.
//

import UIKit
@testable import ecash

class ECashSigner: NSObject {
    
    private var mCountryCode = String()
    private var mIssuerCode = String()
    private var mDecisionNo = String()
    private var mSerialNo = String()
    private var mValue : Int = 0
    private var mActiveDate = String()
    private var mExpireDate = String()
    private var mStatus : Int = 0
    
    private var treSign = String()
    private var accSign = String()
    
    init(countryCode: String, issuerCode: String, decisionNo: String, serialNo: String, value: Int, activeDate: String, expireDate: String, status: Int) {
        let strSign = countryCode + issuerCode + decisionNo + serialNo + String(value) + activeDate + expireDate + String(status)
        mCountryCode = countryCode
        mIssuerCode = issuerCode
        mDecisionNo = decisionNo
        mSerialNo = serialNo
        mValue = value
        mActiveDate = activeDate
        mExpireDate = expireDate
        mStatus = status
    
        treSign = ECSecp256k1.signData(strMessage: strSign, strPrivateKey: "Qagd5iXMLEusSS9J2IiNvEKg64HQ48Ibg533ZK0R6kI=")!
        accSign = ECSecp256k1.signData(strMessage: strSign, strPrivateKey: "ANNTHN4ulPyIxq61K8nogTSm/oLbDrkStfIhqKQnegMY")!
    }
    
    func generateECash() -> String {
        let string = String(format: "ECECash(countryCode: \"%@\", issuerCode: \"%@\", decisionNo: \"%@\", serialNo: \"%@\", value: \"%u\", activeDate: \"%@\", expireDate: \"%@\", status: \"%u\", treSign: \"%@\", accSign: \"%@\")", mCountryCode, mIssuerCode, mDecisionNo, mSerialNo, mValue, mActiveDate, mExpireDate, mStatus, treSign, accSign)
        return string
    }
    
    func genEcash() -> ECECash {
        return ECECash(_countryCode: mCountryCode, _issuerCode: mIssuerCode, _decisionNo: mDecisionNo, _serialNo: mSerialNo, _value: mValue, _activeDate: mActiveDate, _expireDate: mExpireDate, _status: mStatus, _treSign: treSign, _accSign: accSign)
    }
    
}
