//
//  UIImage+CGImage.swift
//  ecash
//
//  Created by phong070 on 11/30/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
extension UIImage {
   func toCGImage() -> CGImage? {
      if let mCiImage = CIImage(image: self){
        return mCiImage.cgImage
      }
      return nil
   }
}
