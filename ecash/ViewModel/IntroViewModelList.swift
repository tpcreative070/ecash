//
//  IntroViewModelList.swift
//  ecash
//
//  Created by phong070 on 11/19/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class IntroViewModelList : IntroViewModelListDelegate {
    var responseToView: ((String) -> ())?
    var showLoading: Bindable<Bool> = Bindable(false)
    var onShowError: ((SingleButtonAlert) -> Void)?
    var list: [IntroViewModel] = [IntroViewModel]()
    
    func doIntro(){
          list.append(IntroViewModel(data: IntroModel(title: "Nhận nhiều phần Lì xì may mắn trong dịp Tết Nguyên Đán 2020, cùng tận, cùng tận hưởng những giây phút đầm ấm bên gia đình và người thân",detail: "", image: AppImages.IC_INTRO_LIXI_1)))
        list.append(IntroViewModel(data: IntroModel(title: "Lì xì may mắn",detail: "Tài lộc dồi dào", image: AppImages.IC_INTRO_LIXI_2)))
        list.append(IntroViewModel(data: IntroModel(title: "Lì xì may mắn",detail: "An Khang Thịnh Vượng", image: AppImages.IC_INTRO_LIXI_3)))
        list.append(IntroViewModel(data: IntroModel(title: "Lì xì may mắn",detail: "Vạn sự Như Ý", image: AppImages.IC_INTRO_LIXI_4)))
      
        responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
    }
    
    func doPaging(index : Int){
        if list.count - 1 == index{
          responseToView!(EnumResponseToView.START.rawValue)
        }else{
          responseToView!(EnumResponseToView.SKIP.rawValue)
        }
    }
    
}
