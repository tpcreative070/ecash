//
//  UploadAvatarRequestModel.swift
//  ecash
//
//  Created by phong070 on 12/9/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class UploadAvatarRequestModel : Codable {
    var auditNumber : String?
    var channelCode : String?
    var functionCode : String?
    var userId : String?
    var large : String?
    var medium : String?
    var small : String?
    var username : String?
    var sessionId : String?
    var token : String?
    var channelSignature : String?
    
    init(data : GalleryOptionsData) {
        guard let mSignInData = CommonService.getSignInData() else {
            return
        }

        self.auditNumber = CommonService.getRandomAlphaNumericInt(length: 15).description
      
        self.channelCode = EnumChannelName.MB001.rawValue
        self.functionCode = EnumFunctionName.UPLOAD_AVATAR.rawValue
        self.large = data.bIconLarge ?? ""
        self.medium = ""
        self.sessionId = mSignInData.sessionId ?? ""
        self.small = ""
        self.token = mSignInData.token
        self.username = mSignInData.username ?? ""
       
        let alphobelCode =  "\(auditNumber!)\(channelCode!)\(functionCode!)\(large!)\(medium!)\(sessionId!)\(small!)\(token!)\(username!)"
              debugPrint(alphobelCode)
              self.channelSignature =  ELGamalHelper.instance.signatureChannel(data: alphobelCode.sha256Data()) ?? ""
    }
    
    
}
