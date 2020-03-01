//
//  TableViewCell.swift
//  vietlifetravel
//
//  Created by Mac10 on 7/3/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import UIKit
class TableViewCell : UITableViewCell{
    var viewModel  = TableViewCellViewModel()
    var delegate : TableViewCellDelegate?
    var identifier =  EnumIdentifier.None
    var codable : Codable?
    let backGroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewUnderLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbMoney : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        view.textColor = AppColors.GRAY_LIGHT_TEXT
        view.textAlignment  = .left
        return view
    }()
    
    lazy var lbCount : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        view.textColor = AppColors.GRAY_LIGHT_TEXT
        view.textAlignment  = .center
        return view
    }()
    
    lazy var control : ICStepper = {
        let view = ICStepper()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.buttonsBackgroundColor = AppColors.GRAY_LIGHT
        view.labelBackgroundColor = AppColors.GRAY_LIGHT
        view.labelTextColor = AppColors.BLACK_COLOR
        view.rightButton.setTitleColor(AppColors.GRAY, for: .normal)
        view.leftButton.setTitleColor(AppColors.GRAY, for: .normal)
        view.minimumValue = 0
        view.maximumValue = 10
        view.addTarget(self, action: #selector(controlValueChanged), for: .valueChanged)
        return view
    }()
    
    /*Contacts*/
    lazy var viewRoot : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var lbName : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbTitle : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbMessage : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imgAvatar : ICSwiftyAvatar = {
        let view = ICSwiftyAvatar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imgIcon : UIImageView = {
           let view = UIImageView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
    }()
       
    
    lazy var lbPhoneNumber : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbCreatedDate : ICLabel = {
          let view = ICLabel()
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
    }()
    
    lazy var viewSub : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
      
    lazy var lbDetail : ICLabel = {
          let view = ICLabel()
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
    }()
      
    lazy var lbWalletId : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    /*QRCode History*/
    lazy var imgCode : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var checkBox : ICCheckBox = {
        let view = ICCheckBox()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewAction : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    /*Transaction Logs*/
    lazy var stackView1 : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbfullNameView : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbtransactionType : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbtransactionStatus : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbtransactionAmount : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lbtransactionDate : ICLabel = {
        let view = ICLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackViewRoot : UIStackView = {
       let view = UIStackView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if reuseIdentifier == EnumIdentifier.TransfereCashToeCash.rawValue {
            identifier = EnumIdentifier.TransfereCashToeCash
        }
        else if reuseIdentifier == EnumIdentifier.WithdrawMultipleeCash.rawValue {
            identifier = EnumIdentifier.WithdrawMultipleeCash
        }
        else if reuseIdentifier == EnumIdentifier.Contact.rawValue {
            identifier = EnumIdentifier.Contact
        }
        else if reuseIdentifier == EnumIdentifier.QRCodeHistory.rawValue {
            identifier = EnumIdentifier.QRCodeHistory
        }
        else if reuseIdentifier == EnumIdentifier.ScannerResult.rawValue {
            identifier = EnumIdentifier.ScannerResult
        }
        else if reuseIdentifier == EnumIdentifier.Transactions.rawValue {
            identifier = EnumIdentifier.Transactions
        }
        else if reuseIdentifier == EnumIdentifier.ExchangeeCash.rawValue {
            identifier = EnumIdentifier.ExchangeeCash
        }
        else if reuseIdentifier == EnumIdentifier.ExchangeeCashAvailable.rawValue {
            identifier = EnumIdentifier.ExchangeeCashAvailable
        }
        else if reuseIdentifier == EnumIdentifier.ExpectationCash.rawValue {
            identifier = EnumIdentifier.ExpectationCash
        }
        else if reuseIdentifier == EnumIdentifier.AddContact.rawValue {
            identifier = EnumIdentifier.AddContact
        }
        else if reuseIdentifier == EnumIdentifier.TransactionsLogsDetail.rawValue {
            identifier = EnumIdentifier.TransactionsLogsDetail
        }
        else if reuseIdentifier == EnumIdentifier.NotificationHistory.rawValue {
            identifier = EnumIdentifier.NotificationHistory
        }
        else if reuseIdentifier == EnumIdentifier.ExchangeOverviewOptions.rawValue {
            identifier = EnumIdentifier.ExchangeOverviewOptions
        }
        else if reuseIdentifier == EnumIdentifier.ExpectationOverviewOptions.rawValue {
            identifier = EnumIdentifier.ExpectationOverviewOptions
        }
        else if reuseIdentifier == EnumIdentifier.Denomination.rawValue {
            identifier = EnumIdentifier.Denomination
        }
        else if reuseIdentifier == EnumIdentifier.SendLixi.rawValue {
            identifier = EnumIdentifier.SendLixi
        }
        else if reuseIdentifier == EnumIdentifier.Lixi.rawValue {
            identifier = EnumIdentifier.Lixi
        }
        else if reuseIdentifier == EnumIdentifier.ReceiveLixiOptions.rawValue {
            identifier = EnumIdentifier.ReceiveLixiOptions
        }
        else if reuseIdentifier == EnumIdentifier.PayInfo.rawValue {
            identifier = EnumIdentifier.PayInfo
        }
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //config with product list
    func configView(view : ListAvailableDelegate){
        lbMoney.text = view.moneyView?.toMoney() ?? "0".toMoney()
        control.minimumValue = 0
        control.maximumValue = Double(view.count)
        control.value = 0
        viewModel.maxBinding.bind { data in
            let result = (view.count - view.countSelected).description
            let mString = LanguageHelper.getTranslationByKey(LanguageKey.Count) ?? ""
            self.lbCount.text =  "\(mString): \(result)"
        }
        viewModel.maxBinding.value = view.count
    }
    
    //config with exchange cash
    func configView(view : ExchangeeCashViewModelDelegate){
        self.lbMoney.text = view.moneyView
        self.lbCount.text = view.countView
        self.lbCount.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
    }
    
    //config with Avaliable cash
    func configView(view : AvailableCashViewModelDeletegate){
        if identifier == EnumIdentifier.ExchangeOverviewOptions {
            lbMoney.text = view.moneyView?.toMoney() ?? "0".toMoney()
            lbCount.text = view.countView
            self.lbCount.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
        }else{
            lbMoney.text = view.moneyView?.toMoney() ?? "0".toMoney()
            control.minimumValue = 0
            control.maximumValue = Double(view.count)
            control.value = Double(view.countSelected)
            viewModel.maxBinding.bind { data in
                let result = (view.count - view.countSelected).description
                let mString = LanguageHelper.getTranslationByKey(LanguageKey.Count) ?? ""
                self.lbCount.text =  "\(mString): \(result)"
            }
            viewModel.maxBinding.value = view.count
        }
    }
    
    //config with transferCashMultipleList
    func configView(view : TransferCashMultipleViewModelDeletegate){
        let countWalletId = view.counteCashIdArray
        let mMaxValue  = Int((view.count / countWalletId))
        lbMoney.text = view.moneyView?.toMoney() ?? "0".toMoney()
        control.minimumValue = 0
        control.maximumValue = Double(mMaxValue)
        control.value = Double(view.countSelected)
        viewModel.maxBinding.bind { data in
        let result = (view.count - view.countSelected).description
            let mString = LanguageHelper.getTranslationByKey(LanguageKey.Count) ?? ""
            self.lbCount.text =  "\(mString): \(result)"
        }
        viewModel.maxBinding.value = view.count
    }
    
    
    //config with sendlixiviewmodel
    func configView(view : SendLixiViewModelDeletegate){
        let countWalletId = view.counteCashIdArray
        let mMaxValue  = Int((view.count / countWalletId))
        lbMoney.text = view.moneyView?.toMoney() ?? "0".toMoney()
        control.minimumValue = 0
        control.maximumValue = Double(mMaxValue)
        control.value = Double(view.countSelected)
        viewModel.maxBinding.bind { data in
        let result = (view.count - view.countSelected).description
            let mString = LanguageHelper.getTranslationByKey(LanguageKey.Count) ?? ""
            self.lbCount.text =  "\(mString): \(result)"
        }
        viewModel.maxBinding.value = view.count
    }
    
    //config expectation cash
    func configView(view : ExpectationCashViewModelDeletegate){
        if identifier == EnumIdentifier.ExpectationOverviewOptions {
            lbMoney.text = view.valueView
            lbCount.text = view.quantitiesView
            self.lbCount.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
        }else{
            lbMoney.text = view.valueView
            control.minimumValue = 0
            control.maximumValue = Double(AppConstants.MAX_CASH_AMOUNT)
            control.value = Double(view.countSelectedView) ?? 0
            viewModel.maxBinding.value = 0
        }
    }
    
    //config add cash
    func configView(view : AddCashViewModelDeletegate){
        lbMoney.text = view.valueView
        control.minimumValue = 0
        control.maximumValue = Double(AppConstants.MAX_CASH_AMOUNT)
        control.value = Double(view.countSelectedView) ?? 0
        viewModel.maxBinding.value = 0
    }
    
    //config with home
    func configView(view : HomeViewModelDelegate){
        
    }
    
    //config with contacts
    func configView(view : ContactsViewModelDeletegate){
        self.lbName.text = "\(view.nameView) \(view.walletIdView)"
        self.lbPhoneNumber.text = view.phoneNumberView
        self.lbPhoneNumber.textColor = AppColors.GRAY
        self.lbPhoneNumber.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE-2)
        self.imgAvatar.borderColor = .clear
        self.imgAvatar.background = AppColors.BLUE
        self.imgCode.image = UIImage(named: AppImages.IC_CHECK_SUCCESS)
        self.imgCode.isHidden = !view.checkShowView
    }
    
    //config with lixi
    func configView(view : LixiViewModelDelegate){
        self.imgIcon.image = UIImage(named: view.imgStatusName)
        self.imgCode.image = UIImage(named: AppImages.IC_GIFT)
        self.lbTitle.text = view.titleView
        self.lbTitle.textColor = view.colorTitleView
        self.lbTitle.numberOfLines = 0
        self.lbTitle.lineBreakMode = .byWordWrapping
        self.lbDetail.text = view.detailView
        self.lbDetail.textColor = view.colorDetailView
        self.lbDetail.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE-2)
        self.lbCreatedDate.text = view.createdDateView
        self.lbCreatedDate.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE-4)
        self.imgCode.isHidden = !view.isShowGift
    }
    
    //config with qrcode generated
    func configView(view : QRCodeViewModeDeletegate){
        self.lbName.text = view.nameView
        self.lbCreatedDate.text = view.createdDateView
        if let mData = QRCodeHelper.shared.generateDataQRCode(from: view.valueView ?? ""){
             self.imgCode.image = mData
        }
        self.checkBox.borderStyle = .square
        self.checkBox.borderWidth = 2
        self.checkBox.checkedBorderColor = AppColors.BLUE
        self.checkBox.checkmarkColor = AppColors.BLUE
        self.checkBox.isEnabled = false
        self.checkBox.isChecked = view.isCheckedView ?? false
    }
    
    //Scanner Result
    func configView(view : CashViewModelDeletegate){
        self.lbCount.text = view.countView
        self.lbCount.textColor = AppColors.GRAY_LIGHT_TEXT
        self.imgCode.image = UIImage(named: view.imageNameView ?? "")
        self.lbMoney.text = view.moneyView
        self.lbMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.viewAction.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
    }
    
    //SendCell
    func configView(view : NotificationHistoryViewModelDelegate){
        self.lbMessage.text = view.messageView
        self.lbCreatedDate.text = view.createdDateView
        self.lbMessage.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbCreatedDate.textColor = AppColors.GRAY_LIGHT_TEXT
    }
    
    //Transaction
    func configView(view : TransactionsLogsViewModelDeletegate){
        self.lbfullNameView.text = view.fullNameView == "" ? view.walletIdView : view.fullNameView
        if(view.transactionStatusView == EnumTransactionStatus.STATUS_SUCCESS.rawValue){
            self.lbtransactionStatus.text = LanguageHelper.getTranslationByKey(LanguageKey.StatusSuccess)
        }else{
            self.lbtransactionStatus.text = LanguageHelper.getTranslationByKey(LanguageKey.StatusFail)
            self.lbtransactionStatus.textColor = AppColors.RED_COLOR
        }
        self.lbtransactionStatus.textColor = AppColors.BLUE
        
        self.lbtransactionAmount.text = "\(view.transactionIconView)\(view.transactionAmountView)"
        self.lbtransactionAmount.textAlignment = .right
        
        self.lbtransactionDate.textAlignment = .right
        self.lbtransactionDate.text = view.transactionDateTimeView
        self.lbtransactionDate.textColor = AppColors.GRAY
        self.lbtransactionDate.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoRegular, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE - 4)
        
        switch view.transactionTypeView {
        case EnumTransferType.ECASH_TO_ECASH.rawValue:
            self.lbtransactionType.text = LanguageHelper.getTranslationByKey(LanguageKey.TransferToeCash)?.uppercased()
            self.imgAvatar.image = UIImage(named: AppImages.IC_CIRCLE_TRANSFER_GRAY)
            self.imgAvatar.borderColor = .clear
            break
        case EnumTransferType.ECASH_TO_EDONG.rawValue:
            self.lbtransactionType.text = LanguageHelper.getTranslationByKey(LanguageKey.WithdraweCash)?.uppercased()
            self.imgAvatar.image = UIImage(named: AppImages.IC_CIRCLE_CASH_OUT_GRAY)
            self.imgAvatar.borderColor = .clear
            break
        case EnumTransferType.EDONG_TO_ECASH.rawValue:
            self.lbtransactionType.text = LanguageHelper.getTranslationByKey(LanguageKey.AddeCash)?.uppercased()
            self.imgAvatar.image = UIImage(named: AppImages.IC_CIRCLE_CASH_IN_GRAY)
            self.imgAvatar.borderColor = .clear
            break
        case EnumTransferType.EXCHANGE_MONEY.rawValue:
            self.lbtransactionType.text = LanguageHelper.getTranslationByKey(LanguageKey.ExchangeCash)?.uppercased()
            self.imgAvatar.image = UIImage(named: AppImages.IC_CIRCLE_CASH_CHANGE_GRAY)
            self.imgAvatar.borderColor = .clear
            break
        case EnumTransferType.LIXI.rawValue:
            self.lbtransactionType.text = LanguageHelper.getTranslationByKey(LanguageKey.LuckyMoney)?.uppercased()
            self.imgAvatar.image = UIImage(named: AppImages.IC_LIX_TRANSACTION)
            self.imgAvatar.borderColor = .clear
            break
        case EnumTransferType.PAY_TO_TO_PAY_PAID.rawValue:
            self.lbtransactionType.text = LanguageHelper.getTranslationByKey(LanguageKey.Payment)?.uppercased()
            self.imgAvatar.image = UIImage(named: AppImages.IC_PAYTO_GRAY)
            self.imgAvatar.borderColor = .clear
            break
        default:
            self.lbtransactionType.text = ""
            self.imgAvatar.borderColor = .clear
        }
        self.lbtransactionType.font = AppFonts.moderateScale(fontName: AppFonts.SFranciscoBold, size: AppFonts.TEXTFIELD_TITLE_FONT_SIZE)
        
    }
    
    //Transactions logs detail
    func configView(view : CashListTransactionsLogsDetailViewModelDelegate){
        self.lbCount.text = view.countView
        self.lbCount.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbMoney.text = view.moneyView
        self.lbMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.viewAction.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
    }
    
    //ReceiveLixiOptions
    func configView(view : ReceiveLixiOptionsViewModelDeletegate){
        self.lbCount.text = view.countView
        self.lbCount.textColor = AppColors.GRAY_LIGHT_TEXT
        self.lbMoney.text = view.moneyView
        self.lbMoney.textColor = AppColors.GRAY_LIGHT_TEXT
        self.viewAction.setCorner(corner: 3, color: AppColors.GRAY_LIGHT)
    }

    // Cell for Pay To - To Pay InfoTransactionOptionsVC
    func configView(view : InfoTransactionOptionsViewModelListDelegate){
        self.lbCount.text = view.countView
        self.lbMoney.text = view.moneyView.toMoney()
    }
    
    func configData(viewModel : Codable){
        self.codable = viewModel
    }
    
    @objc func actionCellViewTap(sender : UITapGestureRecognizer){
        self.delegate?.cellViewSelected(cell: self)
        if let data = codable {
            self.delegate?.cellViewSelected(cell: data)
        }
        
        if identifier == EnumIdentifier.QRCodeHistory {
            self.checkBox.isChecked = !self.checkBox.isChecked
        }
    }
    
    @objc func actionCellViewAction(sender : UITapGestureRecognizer){
        if identifier == EnumIdentifier.Lixi {
            self.delegate?.cellViewSelected(cell: self, action: EnumResponseToView.ACTION_GIFT)
        }
    }
    
    @objc func controlValueChanged(sender : ICStepper){
        if identifier == EnumIdentifier.TransfereCashToeCash {
            if let mData = codable {
                if let mObject = mData.get(value: TransferMultipleViewModel.self){
                    let countWalletId = mObject.counteCashIdArray
                    let mSelectedAction = Int(sender.value) * countWalletId
                    let mCountAction = Int(sender.value)
                    if mCountAction > 0 {
                        self.delegate?.cellViewSelected(cell: self, countSelected: mSelectedAction)
                        self.viewModel.maxBinding.value = mSelectedAction
                    }else{
                        self.delegate?.cellViewSelected(cell: self, countSelected: mCountAction)
                        self.viewModel.maxBinding.value = mCountAction
                    }
                }
            }
        }
        else  if identifier == EnumIdentifier.SendLixi {
            if let mData = codable {
                if let mObject = mData.get(value: SendLixiViewModel.self){
                    let countWalletId = mObject.counteCashIdArray
                    let mSelectedAction = Int(sender.value) * countWalletId
                    let mCountAction = Int(sender.value)
                    if mCountAction > 0 {
                        self.delegate?.cellViewSelected(cell: self, countSelected: mSelectedAction)
                        self.viewModel.maxBinding.value = mSelectedAction
                    }else{
                        self.delegate?.cellViewSelected(cell: self, countSelected: mCountAction)
                        self.viewModel.maxBinding.value = mCountAction
                    }
                }
            }
        }
        else{
            self.delegate?.cellViewSelected(cell: self, countSelected: Int(sender.value))
            self.viewModel.maxBinding.value = Int(sender.value)
        }
    }

}
