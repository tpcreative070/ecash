//
//  ReceiveLixiOptionsViewModelList.swift
//  ecash
//
//  Created by phong070 on 12/27/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import UIKit
class ReceiveLixiOptionsViewModelList  : ReceiveLixiOptionsViewModelListDelegate {
    var contentBinding: Bindable<String> = Bindable("")
    var responseToView: ((String) -> ())?
    var imgTemplateBinding: Bindable<UIImage> = Bindable(UIImage())
    var listeCash: [ReceiveLixiOptionsViewModel] = [ReceiveLixiOptionsViewModel]()
    
    var lixiBinding: Bindable<String> = Bindable("")
    
    var showLoading: Bindable<Bool> = Bindable(false)
    
    var onShowError: ((SingleButtonAlert) -> Void)?
    
    func getIntent(){
        guard let mData = CommonService.getShareReceivedLixiOptions() else {
            return
        }
        if let mList = SQLHelper.getListCashLogs(transactionsId: mData.id ?? "",isExchanged: false){
                 let result = mList.group(by: {$0.value})
                 var mMoney = 0
                 result.enumerated().forEach { (index, element) in
                     let mResult = (Int(element.key ?? 0) * element.value.count)
                     mMoney += mResult
                     listeCash.append(ReceiveLixiOptionsViewModel(money: element.key?.description ?? "" , data: element.value))
                     debugPrint(mMoney)
                 }
            listeCash = listeCash.sorted {$0.groupId > $1.groupId}
            if let  img = DocumentHelper.loadBundleString(fileName: "lixi_template_\(mData.templateCode ?? "01")", mExtension: "png")  {
                imgTemplateBinding.value = UIImage(contentsOfFile: img) ?? UIImage()
            }else{
                if let  img = DocumentHelper.loadBundleString(fileName: "lixi_template_01", mExtension: "png")  {
                     imgTemplateBinding.value = UIImage(contentsOfFile: img) ?? UIImage()
                }
            }
            self.lixiBinding.value = mMoney.description.toMoney()
            self.contentBinding.value = mData.noted ?? ""
            self.responseToView!(EnumResponseToView.UPDATE_DATA_SOURCE.rawValue)
        }
    }
}
