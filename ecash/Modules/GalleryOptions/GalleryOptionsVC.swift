//
//  GalleryOptionsVC.swift
//  ecash
//
//  Created by phong070 on 12/6/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class GalleryOptionsVC : BaseViewController {
    
    @IBOutlet weak var imgAvatar : UIImageView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var btnGallery : ICButton!
    @IBOutlet weak var btnTakePicture : ICButton!
    @IBOutlet weak var btnExit : ICButton!
    @IBOutlet weak var viewRoot : UIView!
    var close : GalleryOptionsVC?
    var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.close = self
    }
    
    @objc func actionGallery(){
        onTakePhotoFromGallery()
    }
    
    @objc func actionTakePicture(){
        onTakePicture()
    }
    
    @objc func actionExit(){
        dismiss()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}
