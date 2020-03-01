//
//  CollectionViewCell.swift
//  vietlifetravel
//
//  Created by phong070 on 7/12/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class CollectionViewCell : UICollectionViewCell{
    var delegate : CollectionViewCellDelegate?
    static var identifier =  EnumIdentifier.None
    
    let backGroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbName : ICLabel = {
        let view = ICLabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.ITEM_LABEL_SMALL_FONT_SIZE - 2)
        return view
    }()
    
    lazy var lbTitle : ICLabel = {
         let view = ICLabel()
         view.numberOfLines = 0
         view.lineBreakMode = .byWordWrapping
         view.translatesAutoresizingMaskIntoConstraints = false
         view.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.ITEM_LABEL_SMALL_FONT_SIZE - 2)
         return view
     }()
    
    lazy var lbDetail : ICLabel = {
            let view = ICLabel()
            view.numberOfLines = 0
            view.lineBreakMode = .byWordWrapping
            view.translatesAutoresizingMaskIntoConstraints = false
            view.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.ITEM_LABEL_SMALL_FONT_SIZE - 2)
            return view
    }()
    
    lazy var imgIcon : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        Utils.logMessage(message: "EnumIdentifier.PAYMENTSERVICES")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func IndexTapped(sender: UITapGestureRecognizer){
        self.delegate?.cellViewSelected(cell: self)
    }
    
    //config with Confirm
    func configView(viewModel : PaymentServicesDelegate){
        self.backGroundView.setRadius(corner: 3, color: AppColors.GRAY_LIGHT)
        self.lbName.text = viewModel.nameView
        self.imgIcon.image = UIImage(named: viewModel.iconView)
        self.lbName.textAlignment = .center
        debugPrint("Value...\(viewModel.nameView)")
    }
    
    //config cell with intro
    func configView(view : IntroViewModelDelegate){
        self.imgIcon.image = UIImage(named: view.imageView)
        self.imgIcon.contentMode = .scaleAspectFit
        self.lbTitle.text = view.titleView
        self.lbTitle.textAlignment = .center
        self.lbDetail.textAlignment = .center
        self.lbDetail.text = view.detailView
        self.lbTitle.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        self.lbDetail.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
    }
    
    //config template
    func configView(view : TemplateViewModelDelegate){
        self.backGroundView.setRadius(corner: 3, color: AppColors.GRAY_LIGHT)
        if let  mData = DocumentHelper.loadBundleString(fileName: view.imgNameView, mExtension: "png")  {
            imgIcon.image = UIImage(contentsOfFile: mData)
        }
    
        if view.isSelectedView {
            self.backGroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }else{
            self.backGroundView.backgroundColor = .clear
        }
    }
}
