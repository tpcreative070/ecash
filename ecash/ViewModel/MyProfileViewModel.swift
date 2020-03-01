//
//  MyProfileViewModel.swift
//  ecash
//
//  Created by phong070 on 9/26/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class MyProfileViewModel : MyProfileViewModelDelegate {
    var phoneBinding: Bindable<String> = Bindable("")
    var emailBinding: Bindable<String> = Bindable("")
    var addressBinding: Bindable<String> = Bindable("")
    var avatarBinding: Bindable<UIImage> = Bindable(UIImage())
    var idNumberBinding: Bindable<String> = Bindable("")
    var eCashPhoneNumber: Bindable<String> = Bindable("")
    var fullNameBinding: Bindable<String> = Bindable("")
    
    var eCashIdBinding: Bindable<String> = Bindable("")
    
    var eCashBalanceBinding: Bindable<String> = Bindable("")
    
    var eDongIdBinding: Bindable<String> = Bindable("")
    
    var eDongBalanceBinding: Bindable<String> = Bindable("")
    
    var eDongAccountListBinding: Bindable<[String]> = Bindable([])
    
    var userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
    
    var navigate: (() -> ())?
    
    var responseToView: ((String) -> ())?
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    private let userService : UserService
    private let productService : ProductService
    init(productService: ProductService = ProductService(),userService : UserService = UserService()) {
        self.productService = productService
        self.userService = userService
    }
    
    
    func doBindingDataToView(data : eDongInfoData? = nil){
        guard let mData = data else {
            doBindingUpdate()
            return
        }
        
        guard let mAccountList = mData.listAcc else{
            doBindingUpdate()
            return
        }
        userProfile.value = UserProfileViewModel(data: mAccountList)
        doBindingUpdate()
    }
    
    func doBindingUpdate(){
        let userProfile: Bindable<UserProfileViewModel> = Bindable(UserProfileViewModel())
        let profile = userProfile.value
        fullNameBinding.value = profile.fullNameView ?? ""
        eCashIdBinding.value = profile.eCashIdView ?? ""
        eCashBalanceBinding.value = profile.eCashBalanceView ?? ""
        eDongIdBinding.value = profile.eDongIdView ?? ""
        eDongBalanceBinding.value = profile.eDongBalanceView ?? ""
        eCashPhoneNumber.value = profile.eCashPhoneNumberView ?? ""
        eDongAccountListBinding.value = profile.listeDong
        idNumberBinding.value = profile.idNumberView ?? ""
        phoneBinding.value = profile.phoneNumberView ?? ""
        emailBinding.value = profile.emailView ?? ""
        addressBinding.value = profile.addressView ?? ""
        if let mAvatar = CommonService.getLargeAvatar() {
            avatarBinding.value = mAvatar.doConvertBase64StringToImage()
        }
    }
    
}
