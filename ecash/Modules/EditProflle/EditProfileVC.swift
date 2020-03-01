//
//  EditProfileVC.swift
//  ecash
//
//  Created by phong070 on 12/5/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class EditProfileVC : BaseViewController {
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var lbTitle : ICLabel!
    @IBOutlet weak var textFieldFullName : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldAddress : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldIdNumber : ICTextFieldNoneIcon!
    @IBOutlet weak var textFieldEmail : ICTextFieldNoneIcon!
    @IBOutlet weak var btnVerify : ICButton!
    @IBOutlet weak var imgAvatar : ICSwiftyAvatar!
    let viewModel = EditProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupDelegate()
        bindingViewModel()
    }
    
    @objc func actionVerify(){
        defineValue()
        self.viewModel.doEditProfile()
    }
      
    @objc func inputFieldEditingDidEnd(textField: UITextField){
        if textField == textFieldFullName {
            viewModel.fullName = textField.text ?? ""
        }
        else if textField == textFieldAddress {
            viewModel.address = textField.text ?? ""
        }
        else if textField == textFieldIdNumber {
            viewModel.idNumber = textField.text ?? ""
        }else if textField == textFieldEmail {
            viewModel.email = textField.text ?? ""
        }
    }
    
    @objc func actionEditAvatar(sender : UITapGestureRecognizer){
        Navigator.pushViewMainStoryboard(from: self, identifier: Controller.galleryOptions, isTransparent: true, present: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onRegisterSingleton()
        keyboardHelper?.registerKeyboardNotification()
    }
      
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          keyboardHelper?.deregisterKeyboardNotification()
          log(message: "viewWillDisappear======>")
    }
    
    override func actionLeft() {
        CommonService.sendDataToGalleryOption(data: GalleryOptionsData(), isResponse: false)
        dismiss()
    }
}
