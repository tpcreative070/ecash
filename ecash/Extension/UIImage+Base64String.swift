//
//  UIImage+Base64String.swift
//  ecash
//
//  Created by phong070 on 12/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension UIImage {
    func doConvertImageToBase64String () -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
 
