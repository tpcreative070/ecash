//
//  SignInStoreModel.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/26/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

class SignInStoreModel  : Codable {
    var channelCode : String?
    var functionCode : String?
    var terminalId : String?
    var token : String?
    var customerId : Int?
    var transactionId : String?
    var username : String?
    var userId : String?
    var uuid : String?
    var channelSignature : String?
    var functionId : String?
    var channelId : String?
    var sessionId : String?
    var result : Bool?
    var medium : String?
    var large : String?
    var small : String?
    var channelFunction = [ChannelFunctionStoreModel]()
    
    init(data : SignInInfoModel) {
        self.channelCode = data.channelCode
        self.functionCode = data.functionCode
        self.terminalId = data.terminalId
        self.token = data.token
        self.customerId = data.customerId
        self.transactionId = data.transactionId
        self.username = data.username
        self.uuid = data.uuid
        self.userId = data.userId
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.sessionId = data.sessionId
        self.result = data.result
        self.small = data.small
        self.medium = data.medium
        self.large = data.large
//        for (key, value) in data.ChannelFunction! {
//            channelFunction.append(ChannelFunctionStoreModel(key: key, data: value))
//        }
    }
    init() {
        if let mSignInData = CommonService.getSignInData(){
            self.small = mSignInData.small
            self.medium = mSignInData.medium
            self.large = mSignInData.large
        }
    }
    
    init(data : SignInStoreModel) {
        self.userId = data.userId
        self.channelCode = data.channelCode
        self.functionCode = data.functionCode
        self.terminalId = data.terminalId
        self.token = data.token
        self.customerId = data.customerId
        self.transactionId = data.transactionId
        self.username = data.username
        self.uuid = data.uuid
        self.channelSignature = data.channelSignature
        self.functionId = data.functionId
        self.channelId = data.channelId
        self.sessionId = data.sessionId
        self.result = data.result
        self.small = data.small
        self.medium = data.medium
        self.large = data.large
    }
}

class ChannelFunctionStoreModel : Codable {
    var functionId : Int?
    var functionCode : String?
    var functionName : String?
    var functionPath : String?
    var functionVisible : String?
    var functionAllias : String?
    var functionUri : String?
    var index : String?

    init(key : String ,data : ChannelFunction) {
        self.functionId = data.functionId
        self.functionCode = data.functionCode
        self.functionName = data.functionName
        self.functionPath = data.functionPath
        self.functionVisible = data.functionVisible
        self.functionAllias = data.functionAllias
        self.functionUri = data.functionUri
        self.index = key
    }
}

