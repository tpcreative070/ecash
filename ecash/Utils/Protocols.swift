//
//  Protocols.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import UIKit
protocol PickerViewDelegate : UIPickerViewDelegate,UIPickerViewDataSource {
  func cancelPicker()
  func donePicker()
  func setTitlePicker() -> String
}

protocol BaseViewModel {
    var showLoading: Bindable<Bool> { get }
    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?  { get set }
}

protocol UserViewModelDelegate : BaseViewModel {
    var navigate: (() -> ())?  { get set }
    var responseToView : ((String) ->())? {get set}
    var email: String? { get }
    var password: String? { get }
    var username : String? {get}
    var fullName : String? {get}
    var confirm : String? {get}
    var id : String? {get}
    var phoneNumber : String? {get}
    var existingValue : Bindable<AlertData> {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var focusTextField : UITextField? {get}
    var otpCode : String? {get}
    var isSignIn : Bool? {get}
    var readOnlyUsernameBinding : Bindable<Bool> {get}
    var isContactBinding : Bindable<Bool> {get}
    var phoneNumberBinding : Bindable<String> {get}
    var fullNameBinding : Bindable<String> {get}
    var userNameBinding : Bindable<String> {get}
    var finalPassword : String {get}
    var transactionCode : String? {get}
    var avatarBinding : Bindable<UIImage> {get}
}

protocol HomeViewModelDelegate  {
    var fullNameView : String {get}
    var eCashIdView : String {get}
    var eCashBalanceView : String {get}
    var eDongIdView : String {get}
    var eDongBalanceView : String {get}
}

protocol PaymentServicesDelegate {
    var iconView : String {get}
    var nameView : String {get}
}

protocol HomeViewModelListDelegate : BaseViewModel , UserProfileBindingDeletegate{
    var isTestEnvironment : Bindable<Bool> {get}
    var alertMessage : Bindable<String> {get}
    var bindToSourceViewModels :(() -> ())?  { get set }
    var bindToSourceCollectionViewViewModels :(() -> ())?  { get }
    var list : [HomeViewModel] {get}
    var startSocket : Bindable<Bool> {get}
    var requestActiveAccount : Bindable<Bool> {get}
    var isRefreshUI : Bindable<Bool> {get}
    var otpValue : String? {get}
    var responseToView : ((String) ->())? {get set}
    var noneWalletInfo : SignInWithNoneWalletViewModel {get}
    var eDeviceKey : ELGamalModel? {get}
    var availableNotification : Bindable<Int> {get}
    var availableLixi : Bindable<Int> {get}
}

protocol NotificationHistoryViewModelDelegate {
    var titleView : String {get}
    var messageView : String {get}
    var createdDateView : String {get}
    var groupIdView : Int {get}
}

protocol IntroCellDelegate {
  func onSkip()
  func onStart(isStart : Bool)
}

protocol NotificationHistoryViewModelListDelegate : BaseViewModel{
    var responseToView : ((String) ->())? {get set}
    var listNotificationHistory : [NotificationHistoryViewModel] {get}
    var currentCell : NotificationHistoryViewModel? {get}
}

protocol QRCodeViewModelListDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var listQRCode : [QRCodeViewModel] {get}
    var shareIntent : Bindable<[UIImage]> {get}
    var deleteList : Bindable<[String]> {get}
    var isVisible : Bindable<Bool> {get}
    var isSelected : Bindable<Bool> {get}
}

protocol ContactsViewModelDeletegate {
    var nameView : String {get}
    var walletIdView : String {get}
    var phoneNumberView : String {get}
    var firstCharacterView : String {get}
    var checkShowView : Bool {get}
    var groupId : Int {get}
}

protocol ContactsViewModelListDeletegate  : BaseViewModel{
    var navigate: (() -> ())?  { get }
    var listContacts : [ContactsViewModel] {get}
    var responseToView : ((String) ->())? {get set}
    var search : String? {get}
    var currentCell : ContactsViewModel? {get}
    var isContactBinding : Bindable<Bool> {get}
    var isCallFirstTime : Bool? {get}
    var isSelected : Bindable<Bool> {get}
    var listReceiver : [String] {get}
}

protocol AddContactViewModelDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var search : String? {get}
    var currentCell : ContactsViewModel? {get}
    var listContacts : [ContactsViewModel] {get}
}

protocol ExpectationCashViewModelDeletegate {
    var quantitiesView : String {get}
    var valueView : String {get}
    var countSelectedView : String {get}
    var groupId : Int {get}
}

protocol AddCashViewModelDeletegate {
    var quantitiesView : String {get}
    var valueView : String {get}
    var countSelectedView : String {get}
    var groupId : Int {get}
}

protocol AvailableCashViewModelDeletegate {
    var moneyView : String? {get}
    var countView : String? {get}
    var groupId : Int {get}
    var count : Int {get}
    var countSelected : Int {get}
}

protocol TransferCashMultipleViewModelDeletegate {
    var moneyView : String? {get}
    var countView : String? {get}
    var groupId : Int {get}
    var count : Int {get}
    var counteCashIdArray : Int {get}
    var countSelected : Int {get}
}

protocol TransactionFilterViewModelDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var timeBinding : Bindable<String> {get}
    var typeBinding : Bindable<String> {get}
    var statusBinding : Bindable<String> {get}
    var hashType : [Int: String] {get}
    var hashStatus: [Int: String] {get}
    var listType : Bindable<[String]> {get}
    var listStaus : Bindable<[String]> {get}
    var time : String? {get}
    var type : String? {get}
    var status : String? {get}
    var isTimeOpening : Bool {get}
}

protocol EditContactViewModelDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var walletIdBinding : Bindable<String> {get}
    var fullNameBinding : Bindable<String> {get}
    var phoneNumberBinding : Bindable<String> {get}
    var mobileInfoBinding : Bindable<String> {get}
    var fullName : String? {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
}

protocol ExchangeeCashListOptionsDelegate : BaseViewModel {
    var listAvailable : [ListAvailableViewModel] {get}
    var listExpectation : [ExpectationCashViewModel] {get}
    var responseToView : ((String) ->())? {get set}
    var totalMoneyBinding: Bindable<String> {get}
    var totalMoney: String? {get}
    var totalMoneyDispay : String? {get}
    var isExchangeCash : Bool? {get}
    var moneyValue : Bindable<Dictionary<Int, Int>>{ get }
    var titleBinding : Bindable<String> {get}
    var listExchangeOverview : [ListAvailableViewModel] {get}
    var listExpectationOverview : [ExpectationCashViewModel] {get}
}

protocol TransactionsLogsViewModelDeletegate {
    var fullNameView : String {get}
    var walletIdView : String {get}
    var transactionTypeView : String {get}
    var transactionStatusView : String {get}
    var transactionAmountView : String {get}
    var transactionDateView : String {get}
    var transactionDateTimeView : String {get}
    var transactionIconView : String {get}
    var sortId : Int64 {get}
}

protocol TransactionsLogsViewModelListDeletegate  : BaseViewModel{
    var navigate: (() -> ())?  { get }
    var listTransactionsLogs : [TransactionsLogsViewModel] {get}
    var responseToView : ((String) ->())? {get set}
    var search : String? {get}
    var currentCell : TransactionsLogsViewModel? {get}
}

protocol TransactionLogsDetailViewModelDelegate {
    var cashList : [CashListTransactionsLogsDetailViewModel] {get}
    var typeView : String {get}
    var moneyView : String {get}
    var statusView : String {get}
    var receiverView : String {get}
    var fullNameView : String {get}
    var phoneNumberView : String {get}
    var issuerView : String {get}
    var contentView : String {get}
    var createdDateView : String {get}
    var transactionIconView : String {get}
}

protocol TransactionsLogsDetailListViewDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var typeBinding : Bindable<String> {get}
    var moneyBinding : Bindable<String> {get}
    var statusBinding : Bindable<String> {get}
    var isSenderBinding : Bindable<Bool> {get}
    var receiverBinding : Bindable<String> {get}
    var fullNameBinding : Bindable<String> {get}
    var phoneNumberBinding : Bindable<String> {get}
    var issuerBinding : Bindable<String> {get}
    var contentBinding : Bindable<String> {get}
    var createdDateBinding : Bindable<String> {get}
    var senderBinding : Bindable<String> {get}
    var list  : [CashListTransactionsLogsDetailViewModel] {get}
    var listQRCode : [String] {get}
    var isQRCode : Bindable<Bool> {get}
    var listImage  : Bindable<[UIImage]> {get}
    var qrCode : Bindable<UIImage> {get}
    var saveFileToPhotos : Bindable<UIImage> {get}
    var listTransactionQRCode : [TransactionQREntityModel] {get}
}

protocol CashListTransactionsLogsDetailViewModelDelegate  {
    var moneyView : String {get}
    var countView : String {get}
    var imageNameView : String {get}
}

protocol ScannerViewModelDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var dictionaryList : [Int: QRCodeModel] {get}
    var resultScan : Bindable<String> {get}
    var transactionIdBinding : Bindable<String> {get}
    var cameraBinding : Bindable<Bool>{get set}
}

protocol ScannerResultViewModelListDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var totalMoneyBinding: Bindable<String> {get}
    var senderNameBinding: Bindable<String> {get}
    var phoneNumberBinding : Bindable<String> {get}
    var contentBinding : Bindable<String> {get}
    var walletIdBinding : Bindable<String> {get}
    var listCash : [CashListViewModel] {get}
}

protocol CashViewModelDeletegate {
    var moneyView : String? {get}
    var countView : String? {get}
    var imageNameView : String? {get}
}

protocol ReceiveLixiOptionsViewModelDeletegate {
    var moneyView : String {get}
    var countView : String {get}
    var groupId : Int {get}
}

protocol ReceiveLixiOptionsViewModelListDelegate  : BaseViewModel{
    var responseToView : ((String) ->())? {get set}
    var listeCash : [ReceiveLixiOptionsViewModel] {get}
    var lixiBinding : Bindable<String> {get}
    var contentBinding : Bindable<String> {get}
    var imgTemplateBinding : Bindable<UIImage> {get}
}

protocol ScannerResultViewModelDelegate {
    var cashList : [CashListViewModel] {get}
    var totalMoneyView : String {get}
    var senderNameView : String {get}
    var phoneNumnerView : String {get}
    var contentView : String {get}
}

protocol MyWalletViewModelDelegate : BaseViewModel, UserProfileBindingDeletegate {
    var navigate: (() -> ())?  { get }
    var responseToView : ((String) ->())? {get set}
    var eCashAvailable  : String {get}
    var avatarBinding : Bindable<UIImage> {get}
}

protocol MyProfileViewModelDelegate : BaseViewModel, UserProfileBindingDeletegate{
    var navigate: (() -> ())?  { get }
    var responseToView : ((String) ->())? {get set}
    var avatarBinding : Bindable<UIImage> {get}
    var phoneBinding : Bindable<String> {get}
    var emailBinding : Bindable<String> {get}
    var addressBinding : Bindable<String> {get}
}

protocol AddeCashListDelegate : BaseViewModel , UserProfileBindingDeletegate{
    var navigate: (() -> ())?  { get }
    var alertMessage : Bindable<String> {get}
    var totalMoneyBinding : Bindable<String> {get}
    var moneyValue : Bindable<Dictionary<Int, Int>>{ get }
    var eDongIdSelected : String? {get}
    var totalMoney : String? {get}
    var responseToView : ((String) ->())? {get set}
    var eDongAvailableAmount : Int? {get}
    var eDongMinBalance : Int? {get}
    var listDenomination : [AddCashViewModel] {get}
}

protocol MyQRCodeViewModelDelegate {
    var fullNameBinding : Bindable<String> {get}
    var phoneNumberBinding : Bindable<String> {get}
    var codeBinding : Bindable<UIImage> {get}
    var responseToView : ((String) ->())? {get set}
    var avatarBinding : Bindable<UIImage> {get}
}

protocol SignOutOptionsViewModelDelegate : BaseViewModel {
     var responseToView : ((String) ->())? {get set}
}

protocol DestroyWalletOptionsViewModelDelegate : BaseViewModel  {
    var responseToView : ((String) ->())? {get set}
    var contentBinding : Bindable<String> {get}
}

protocol ListAvailableDelegate {
    var moneyView : String? {get}
    var groupId : Int {get}
    var count : Int {get}
    var countSelected : Int {get}
}

protocol ExchangeeCashViewModelDelegate {
    var moneyView : String {get}
    var countView : String {get}
}

protocol QRCodeViewModeDeletegate {
    var valueView : String? {get}
    var nameView : String? {get}
    var createdDateView : String? {get}
    var transactionIdView : String? {get}
    var isCheckedView : Bool? {get}
}

protocol WithdraweCashDelegate : BaseViewModel, UserProfileBindingDeletegate {
    var moneyInput : String? {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var responseToView : ((String) ->())? {get set}
    var eDongIdSelected : String? {get}
    var eDongIdTransferSelected : String? {get}
    var listAvailable : [ListAvailableViewModel] {get}
    var selectedItem : Bindable<Dictionary<Int, Int>>{ get }
    var totalMoneyBinding: Bindable<String> {get}
    var isTypeMoney: Bool? {get}
    var totalMoney : String? {get}
    var eDongAvailableAmount : Int? {get}
    var eDongMinBalance : Int? {get}
    var totalMoneyDispay : String? {get}
}

protocol ExchangeeCashListDelegate : BaseViewModel, UserProfileBindingDeletegate {
    var responseToView : ((String) ->())? {get set}
    var listAvailable : [ExchangeeCashViewModel] {get}
    var exchangeCashBinding : Bindable<String> {get}
    var expectationCashBinding : Bindable<String> {get}
    var matchValueBinding : Bindable<Bool> {get}
}

protocol TransfereCashDelegate : BaseViewModel ,UserProfileBindingDeletegate {
    var eCashId : String? {get}
    var moneyInput : String? {get}
    var content : String? {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var responseToView : ((String) ->())? {get set}
    var eDongIdSelected : String? {get}
    var eDongIdTransferSelected : String? {get}
    var listAvailable : [ListAvailableViewModel] {get}
    var selectedItem : Bindable<Dictionary<Int, Int>>{ get }
    var totalMoneyBinding: Bindable<String> {get}
    var totalMoney: String? {get}
    var isTypeMoney: Bool? {get}
    var eDongAvailableAmount : Int? {get}
    var eDongMinBalance : Int? {get}
    var totalMoneyDispay: String? {get}
    var isQRCode : Bool? {get}
    var eCashArray : [String] {get}
}

protocol TransfereCashMultipleListDelegate : BaseViewModel ,UserProfileBindingDeletegate {
    var eCashId : String? {get}
    var moneyInput : String? {get}
    var content : String? {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var responseToView : ((String) ->())? {get set}
    var eDongIdSelected : String? {get}
    var eDongIdTransferSelected : String? {get}
    var listAvailable : [TransferMultipleViewModel] {get}
    var selectedItem : Bindable<Dictionary<Int, Int>>{ get }
    var totalMoneyBinding: Bindable<String> {get}
    var totalMoney: String? {get}
    var isTypeMoney: Bool? {get}
    var eDongAvailableAmount : Int? {get}
    var eDongMinBalance : Int? {get}
    var totalMoneyDispay: String? {get}
    var isQRCode : Bool? {get}
    var eCashIdArray : [String] {get}
    var listeCash : Dictionary<String,[CashLogsEntityModel]> {get}
    var leftWalletId : Int {get}
}

protocol SendLixiViewModelListDelegate : BaseViewModel ,UserProfileBindingDeletegate {
    var eCashId : String? {get}
    var moneyInput : String? {get}
    var content : String? {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var responseToView : ((String) ->())? {get set}
    var eDongIdSelected : String? {get}
    var eDongIdTransferSelected : String? {get}
    var listAvailable : [SendLixiViewModel] {get}
    var selectedItem : Bindable<Dictionary<Int, Int>>{ get }
    var totalMoneyBinding: Bindable<String> {get}
    var totalMoney: String? {get}
    var isTypeMoney: Bool? {get}
    var eDongAvailableAmount : Int? {get}
    var eDongMinBalance : Int? {get}
    var totalMoneyDispay: String? {get}
    var isQRCode : Bool? {get}
    var eCashIdArray : [String] {get}
    var listeCash : Dictionary<String,[CashLogsEntityModel]> {get}
    var leftWalletId : Int {get}
    var listTemplate : [TemplateViewModel] {get}
    var templateCode : String? {get}
}

protocol SendLixiViewModelDeletegate {
    var moneyView : String? {get}
    var countView : String? {get}
    var groupId : Int {get}
    var count : Int {get}
    var counteCashIdArray : Int {get}
    var countSelected : Int {get}
}

protocol TemplateViewModelDelegate {
    var imgNameView : String {get}
    var codeView : String {get}
    var isSelectedView : Bool {get}
}

protocol LixiViewModelDelegate {
    var imgStatusName : String {get}
    var isShowGift : Bool {get}
    var titleView : String {get}
    var detailView : String {get}
    var colorTitleView : UIColor {get}
    var colorDetailView : UIColor {get}
    var createdDateView : String {get}
}

protocol LixiViewModelListDelegate  : BaseViewModel{
    var responseToView : ((String) ->())? {get set}
    var listLixi : [LixiViewModel] {get}
    var receiveLixiOptionsData : Bindable<ReceiveLixiOptionsData> {get}
}

protocol ExchangeeCashOverviewOptionsViewModelListDeletegate : BaseViewModel{
    var responseToView : ((String) ->())? {get set}
    var exchangeList : [ListAvailableViewModel] {get}
    var expectationList : [ExpectationCashViewModel] {get}
    var exchangeCashBinding : Bindable<String> {get}
    var expectationCashBinding : Bindable<String> {get}
}

protocol UserProfileBindingDeletegate {
    var fullNameBinding: Bindable<String> {get}
    
    var eCashIdBinding: Bindable<String> {get}
    
    var eCashBalanceBinding: Bindable<String> {get}
    
    var eDongIdBinding: Bindable<String> {get}
    
    var eDongBalanceBinding: Bindable<String> {get}
    
    var eDongAccountListBinding : Bindable<[String]> {get}
    
    var idNumberBinding : Bindable<String> {get}
    
    var eCashPhoneNumber : Bindable<String> {get}
    
    var userProfile : Bindable<UserProfileViewModel> {get}
}

protocol MultipleLanguagesListViewModelDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var list  : [MultipleLanguagesViewModel] {get}
}

protocol IntroViewModelDelegate {
    var titleView : String {get}
    var detailView : String {get}
    var imageView : String {get}
}

protocol IntroViewModelListDelegate : BaseViewModel {
    var responseToView : ((String) ->())? {get set}
    var list : [IntroViewModel] {get}
}

protocol ChangePasswordViewModelDelegate : BaseViewModel {
    var oldPassword : String? {get}
    var newPassword : String? {get}
    var confirmPassword : String? {get}
    var oldValue : String? {get}
    var responseToView : ((String) ->())? {get set}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
}

protocol ForgotPasswordViewModelDelegate  : BaseViewModel{
    var responseToView : ((String) ->())? {get set}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var otpCode : String? {get}
    var newPassword : String? {get}
    var confirmPassword : String? {get}
    var userNameBinding : Bindable<String> {get}
    var username : String? {get}
    var readOnlyUsernameBinding : Bindable<Bool> {get}
    var transactionCode : String? {get}
    var userId : String? {get}
    var isForgorPassword : Bool? {get}
}

protocol EditProfileViewModelDelegate  : BaseViewModel{
    var responseToView : ((String) ->())? {get set}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var fullNameBinding : Bindable<String> {get}
    var addressBinding : Bindable<String> {get}
    var idNumberBinding : Bindable<String> {get}
    var emailBinding : Bindable<String> {get}
    var avatarBinding : Bindable<UIImage> {get}
    var fullName : String? {get}
    var address : String? {get}
    var idNumber : String? {get}
    var email : String? {get}
}

protocol UserProfileViewModelDeletegate {
    var fullNameView : String? {get}
    var eCashIdView : String? {get}
    var eCashBalanceView : String? {get}
    var eDongIdView : String? {get}
    var eDongBalanceView : String? {get}
    var eCashPhoneNumberView : String? {get}
    var idNumberView : String? {get}
    var phoneNumberView: String? {get}
    var emailView : String? {get}
    var addressView : String? {get}
}

protocol TableViewCellDelegate {
    func cellViewSelected(cell: TableViewCell)
    func cellViewSelected(cell: TableViewCell,action: EnumResponseToView)
    func cellViewSelected(cell: TableViewCell,countSelected : Int)
    func cellViewSelected(cell: Codable)
    func cellCodable(codable : Codable)
}

protocol CollectionViewCellDelegate {
    func cellViewSelected(cell: CollectionViewCell)
    func cellCodable(codable : Codable)
}

protocol HeaderSectionDelegate {
    func cellSectionSelected(codable : Codable)
}

protocol TbViewCellViewModelDelegate  {
    var firstName: String? { get }
    var lastName: String? { get }
    var birthday : String? {get}
    var genderType : String? {get}
    var errorMessages: Bindable<Dictionary<String, String>>{ get }
    var codable : Codable {get}
    var verified : (() -> ())? {get set}
    var maxBinding: Bindable<Int> {get}
}

protocol TreeNodeDelegate {
    var identifier: String { get }
    var isExpandable: Bool { get }
}

protocol DownloadDelegate {
    func complete()
}

protocol BaseDelegate {
    
}

protocol PayToViewModelDelegate {
    var titleAccountNameBinding: Bindable<String> {get set}
    var acountNameValueBinding: Bindable<String> {get set}
    var titleECashIdBinding: Bindable<String> {get set}
    var eCashIdValueBinding: Bindable<String> {get set}
    var titleECashBalanceBinding: Bindable<String> {get set}
    var eCashBalanceValueBinding: Bindable<String> {get set}
    var lbTitleContentBinding: Bindable<String> {get set}
    var titleGetQRCodeBinding: Bindable<String> {get set}
    var eCashAccountNumberBinding: Bindable<String> {get set}
    var amountBinding: Bindable<String> {get set}
    var contentBinding: Bindable<String> {get set}
    var titleConfirmBinding: Bindable<String> {get}
}

protocol RequirePaymentOptionsViewModelDelegate: class {
    var customerNameBinding: Bindable<String>{ get }
    var amountBinding: Bindable<String>{ get }
    var contentBinding: Bindable<String>{ get }
}

protocol RequirePaymentOptionsDelegate: class {
    func requirePaymentOptionsResult(_ socketRequestPaytoModel: SocketRequestPaytoModel?)
}

protocol TransactionFailureOptionsViewModelDelegate: class {
    var content: Bindable<String>{ get }
}

protocol TransactionFailureOptionsDelegate: class {
    func transactionFailureOptionsResult(_ isSuccess: Bool?)
}


protocol TransactionSuccessOptionsViewModelDelegate: class {
    var amount: Bindable<String>{ get }
    var account: Bindable<String>{ get }
}

protocol TransactionSuccessOptionsDelegate: class {
    func transactionSuccessOptionsResult(_ isSuccess: Bool?)
}

protocol InfoTransactionOptionsViewModelDelegate: class {
    var grantTotalBinding: Bindable<String>{ get }
    var accountBinding: Bindable<String>{ get }
    var totalAmountBinding: Bindable<String>{ get }
    var contentBinding: Bindable<String>{ get }
    var responseToView : ((String) ->())? {get set}
    var listItems: [InfoTransactionOptionsViewModelList] { get }
}

protocol InfoTransactionOptionsViewModelListDelegate: class {
    var moneyView : String {get}
    var countView : String {get}
    var groupId : Int {get}
    var count : Int {get}
}

protocol InfoTransactionOptionsDelegate: class {
    func infoTransactionOptionsResult(_ isSuccess: Bool?, account: String, amount: String)
}

protocol ToPayQRViewModelDelegate: class {
    var qrContent: Bindable<String>{ get }
}

protocol ToPayViewModelDelegate: class {
    var titleHeader: Bindable<String> {get set}
    
    var titleAccountNameBinding: Bindable<String> {get set}
    var acountNameValueBinding: Bindable<String> {get set}
    var titleECashIdBinding: Bindable<String> {get set}
    var eCashIdValueBinding: Bindable<String> {get set}
    var titleECashBalanceBinding: Bindable<String> {get set}
    var eCashBalanceValueBinding: Bindable<String> {get set}
    
    var titleContentBinding: Bindable<String> {get set}
    
    var amountValueBinding: Bindable<String> {get set}
    var contentValueBinding: Bindable<String> {get set}
    
    var titleConfirmBinding: Bindable<String> {get}
}

protocol BasePopupDelegate: BaseViewController{
    associatedtype GenericType
    var delegate: GenericType {set get}
}
