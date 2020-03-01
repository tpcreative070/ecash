//
//  AppDelegate+Config.swift
//  ecast
//
//  Created by phong070 on 7/25/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
extension AppDelegate {
    func initConfig(){
        initSQLine()
        let config = CommonService.getConfigurationData()
        guard let data = config else {
            let configurationData = ConfigurationStoreModel(isAutoLogin: true, isUseDefault: true, serverUrl: ApiEndPointUrl.BaseUrl.infoForKey() ?? "")
            CommonService.setConfigurationData(configuration: configurationData)
            return
        }
        if ApiEndPointUrl.BaseUrl.infoForKey() ?? "" != data.serverUrl{
            let configurationData = ConfigurationStoreModel(isAutoLogin: true, isUseDefault: true, serverUrl: ApiEndPointUrl.BaseUrl.infoForKey() ?? "")
            CommonService.setConfigurationData(configuration: configurationData)
        }
        if CommonService.getIsAlreadyStore() ?? false{
            debugPrint("Already saved")
            return
        }else{
            CommonService.setIsAlreadyStore(value: true)
        }
    }
    
    func initSQLine(){
        if !SQLHelper.getPathFile(){
            CommonService.setMasterKey(data: CipherKey.Key)
        }
        
        if let _ = CommonService.getMultipleLanguages(){
        }else{
            CommonService.setMultipleLanguages(value: LanguageCode.Vietnamese)
        }
        
        SQLHelper.initCipher()
        SQLHelper.createNotificationHistory()
        SQLHelper.createdIssuersDiary()
        SQLHelper.createCashLogs()
        SQLHelper.createTransactionsLogs()
        SQLHelper.createCashLogsTemporary()
        SQLHelper.createContacts()
        SQLHelper.createDecisionsDiary()
        SQLHelper.createSocketReply()
    }
    
}
