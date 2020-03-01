//
//  RequirePaymentOptionsViewModel.swift
//  ecash
//
//  Created by ECAPP on 1/13/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import Foundation
class RequirePaymentOptionsViewModel: RequirePaymentOptionsViewModelDelegate{
    var customerNameBinding: Bindable<String> = Bindable("")
    var amountBinding: Bindable<String> = Bindable("0")
    var contentBinding: Bindable<String> = Bindable("")
    
    var eCashIdSender: String?
    var customerNameValue: String?
    var amountValue: Int?
    var contentValue: String?
    var socketRequestPaytoModel:SocketRequestPaytoModel?
    
    func doBindingUpdate(){
        customerNameBinding.value = "\(customerNameValue ?? "") - \(eCashIdSender ?? "")"
        amountBinding.value = "\(amountValue ?? 0)".toMoney()
        contentBinding.value = contentValue ?? ""
    }
}
