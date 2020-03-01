//
//  EditProfileResponseModel.swift
//  ecash
//
//  Created by phong070 on 12/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class EditProfileResponseModel : BaseResponseModel {
    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
