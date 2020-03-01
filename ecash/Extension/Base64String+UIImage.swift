//
//  Base64String+UIImage.swift
//  ecash
//
//  Created by phong070 on 12/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension String {
    func doConvertBase64StringToImage () -> UIImage {
        let imageData = Data.init(base64Encoded: self, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
}
