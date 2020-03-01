//
//  HeaderView.swift
//  vietlifetravel
//
//  Created by Mac10 on 7/5/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class HeaderView : UITableViewHeaderFooterView{
    var identifier  = EnumIdentifier.None
    var delegate : HeaderSectionDelegate?
    var codable : Codable?
    
    let backGroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lbGroupName : ICLabel = {
        let label = ICLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == EnumIdentifier.Contact.rawValue{
            identifier = EnumIdentifier.Contact
        }else if reuseIdentifier == EnumIdentifier.Transactions.rawValue{
            identifier = EnumIdentifier.Transactions
        }
        else if reuseIdentifier == EnumIdentifier.QRCodeHistory.rawValue{
              identifier = EnumIdentifier.QRCodeHistory
        }
        setupView()
    }
    
    // config view with Confirm
    func configView(view : ContactsViewModelDeletegate){
        self.lbGroupName.text = view.firstCharacterView
        self.lbGroupName.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
    }
    
    func configView(view : TransactionsLogsViewModelDeletegate){
         var index = view.transactionDateView.index(view.transactionDateView.startIndex, offsetBy: 4)
         let year = String(view.transactionDateView[..<index])
         let monthdate = String(view.transactionDateView[index...])
         index = monthdate.index(monthdate.startIndex, offsetBy: 2)
         let month = String(monthdate[..<index])
         let headline = String("\(LanguageHelper.getTranslationByKey(LanguageKey.Months) ?? "") " + month + "/" + year)
         self.lbGroupName.text = headline//view.transactionDateView
         self.lbGroupName.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
         self.backGroundView.backgroundColor = AppColors.GRAY_LIGHT
    }
    
    // config with with qrcode history
    func configView(view : QRCodeViewModeDeletegate){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc func actionCellViewTap(sender : UITapGestureRecognizer){
        if let mDelegate = delegate{
            if let mViewModel = codable{
                mDelegate.cellSectionSelected(codable: mViewModel)
            }
        }
    }
}
