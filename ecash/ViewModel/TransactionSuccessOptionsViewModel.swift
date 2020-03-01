//
//  TransactionSuccessOptionsViewModel.swift
//  ecash
//
//  Created by ECAPP on 1/14/20.
//  Copyright © 2020 thanhphong070. All rights reserved.
//

import UIKit

class TransactionSuccessOptionsViewModel: TransactionSuccessOptionsViewModelDelegate {
    var amount: Bindable<String> = Bindable("")
    var account: Bindable<String> = Bindable("")
    
}
