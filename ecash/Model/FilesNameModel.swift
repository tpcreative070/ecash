//
//  FilesNameModel.swift
//  ecash
//
//  Created by phong070 on 10/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class FilesNameModel : Codable {
    var walletId : String?
    var transactionsId : String?
    var position : String?
    var createdDate : String?
    
    init(data : String) {
        let array = data.components(separatedBy: "_")
        if array.count>=4{
            self.walletId = array[0]
            self.transactionsId = array[1]
            self.position = array[2]
            self.createdDate = array[3]
        }
    }
}
