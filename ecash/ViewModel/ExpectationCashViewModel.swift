//
//  ExchangeeCashOptionsViewModel.swift
//  ecash
//
//  Created by phong070 on 10/24/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ExpectationCashViewModel  : ExpectationCashViewModelDeletegate , Codable{
    
    var countSelectedView: String {
        return countSelected.description
    }
    
    var quantitiesView: String {
        return quantities?.description ?? "0"
    }
    var valueView: String {
        return value?.description.toMoney() ?? "0".toMoney()
    }
    
    var groupId: Int {
        return value ?? 0
    }
    
    var quantities : Int?
    var value : Int?
    var countSelected: Int = 0
    
    init(quantities : Int, value : Int) {
        self.quantities = quantities
        self.value = value
    }
}
