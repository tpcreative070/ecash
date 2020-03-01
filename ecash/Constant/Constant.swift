//
//  AppConstant.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Security
import UIKit

/// Constants used by the library
public struct KeychainSwiftConstants {
    /// Specifies a Keychain access group. Used for sharing Keychain items between apps.
    public static var accessGroup: String { return toString(kSecAttrAccessGroup) }
    
    /**
     A value that indicates when your app needs access to the data in a keychain item. The default value is AccessibleWhenUnlocked. For a list of possible values, see KeychainSwiftAccessOptions.
     
     */
    public static var accessible: String { return toString(kSecAttrAccessible) }
    
    /// Used for specifying a String key when setting/getting a Keychain value.
    public static var attrAccount: String { return toString(kSecAttrAccount) }
    
    /// Used for specifying synchronization of keychain items between devices.
    public static var attrSynchronizable: String { return toString(kSecAttrSynchronizable) }
    
    /// An item class key used to construct a Keychain search dictionary.
    public static var klass: String { return toString(kSecClass) }
    
    /// Specifies the number of values returned from the keychain. The library only supports single values.
    public static var matchLimit: String { return toString(kSecMatchLimit) }
    
    /// A return data type used to get the data from the Keychain.
    public static var returnData: String { return toString(kSecReturnData) }
    
    /// Used for specifying a value when setting a Keychain value.
    public static var valueData: String { return toString(kSecValueData) }
    
    /// Used for returning a reference to the data from the keychain
    public static var returnReference: String { return toString(kSecReturnPersistentRef) }
    
    static func toString(_ value: CFString) -> String {
        return value as String
    }
}



struct AppConstants {
    static let LARGE_SIZE = 200
    static let MEDIUM_SIZE = 50
    static let SMALL_SIZE = 20
    static let MAX_LENGHT_QRCODE = 1000
    static let MAX_LENGHT = 250
    static let MIN_LENGHT = 1
    static let MAX_CASH_AMOUNT = 1000
    static let FLOAT_LABEL_MARGIN_LEFT = CGFloat(30)
    static let FLOAT_LABEL_HEIGHT = CGFloat(25)
    static let INPUT_FIELD_HEIGHT = CGFloat(30)
    static let HEIGHT_BUTTON_DEFAULT = CGFloat(50)
    static let WIDTH_BUTTON_DEFAULT = CGFloat(100)
    static let IC_DEFAULT = CFloat(25)
    static let IC_CLOSE_WIDTH = CFloat(30)
    static let IC_CLOSE_HEIGHT = CFloat(30)
    static let MARGIN_LEFT = CGFloat(20)
    static let MARGIN_RIGHT = CGFloat(-20)
    static let MARGIN_TOP = CGFloat(20)
    static let MARGIN_BOTTOM = CGFloat(-10)
    static let ALPHA_DEFAULT = CGFloat(1)
    static let ALPHA_DISBALE = CGFloat(0.5)
    static let TABLE_ROW_HEIGHT = CGFloat(70)
    // switch button default config
    static let SWITCH_ON_TINT_COLOR = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
    static let SWITCH_OFF_TINT_COLOR = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
    static let SWITCH_CORNER_RADIUS = CGFloat(0.5)
    static let SWITCH_THUMB_CORNER_RADIUS = CGFloat(0.5)
    static let SWITCH_THUMB_SIZE_WIDTH = 27
    static let SWITCH_THUMB_SIZE_HEIGHT = 27
    static let SWITCH_THUMB_ON_TINT_COLOR = UIColor(red: 183/255, green: 61/255, blue: 55/255, alpha: 1)
    static let SWITCH_THUMB_OFF_TINT_COLOR = UIColor(red: 99/255, green: 109/255, blue: 121/255, alpha: 1)
    static let SWITCH_ANIMATION_DURATION = 0.25
    static let HEIGHT_CONSTRAINT_LABLE = CGFloat(20)
    static let HEIGHT_CONSTRAINT_VIEW = CGFloat(50)
    static let HEIGHT_CONSTRAINT_LABLE_PASSENGERS = CGFloat(20)
    static let SOUND_EMPTY = "empty.wav"
    static let APP_INDIE_TIME: Double = 300
}

struct AppFonts {
    // official font
    static let SFranciscoSemiBold = "SFProText-Semibold"
    static let SFranciscoBold = "SFProText-Bold"
    static let SFranciscoRegular = "SFProText-Regular"
    static let SFranciscoLight = "SFProText-Light"
    
    // 4 levels
    static let TITLE_FONT_SIZE = CGFloat(32)
    static let SUB_TITLE_FONT_SIZE = CGFloat(18)
    static let TEXTFIELD_TITLE_FONT_SIZE = CGFloat(16)
    static let BUTTON_TITLE_SIZE = CGFloat(20)
    static let FOOTER_LABEL_FONT_SIZE = CGFloat(14)
    
    static let LABEL_FONT_SIZE = CGFloat(18)
    static let ERROR_LABEL_FONT_SIZE = CGFloat(15)
    static let FLOAT_LABEL_FONT_SIZE = CGFloat(16)
    static let FLOAT_PLACEHOLDER_FONT_SIZE = CGFloat(14)
    static let NOTICE_LABEL_FONT_SIZE = CGFloat(18)
    static let NOTICE_LABEL_SUB_FONT_SIZE = CGFloat(16)
    static let INPUT_TEXT_FONT_SIZE_DEFAULT = CGFloat(15)
    static let VERSION_FONT_SIZE = CGFloat(18)
    static let GROUP_ITEM_TITLE = CGFloat(20)
    static let ITEM_LABEL_FONT_SIZE = CGFloat(18)
    static let ITEM_LABEL_SUB_FONT_SIZE = CGFloat(16)
    static let ITEM_LABEL_SMALL_FONT_SIZE = CGFloat(14)
    static let BUTTON_FONT_SIZE = CGFloat(16)
    static let VERSION_FONT_NORMAL_SIZE = CGFloat(16)
    
    static func moderateScale(fontName: String = AppFonts.SFranciscoRegular, size: CGFloat = AppFonts.LABEL_FONT_SIZE, factor: CGFloat = 1)->UIFont{
        let guidelineBaseWidth = CGFloat(375) // Scaling font for iPhone 5s, 5
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        _ = screenSize.height
        let temp = (screenWidth / guidelineBaseWidth * size)
        var font: UIFont?
        if Helper.isIpad() {
            font =  UIFont(name: fontName, size: (size * 1.2))!
        } else {
            if screenWidth >= guidelineBaseWidth {
                font =  UIFont(name: fontName, size: (size + (temp - size) * factor))!
            }else{
                font =  UIFont(name: fontName, size: (size + (temp - size) * 1))!
            }
        }
        return font!
    }
}

struct AppImages {
    static let IC_SEARCH = "ic_search"
    static let IC_DELETE = "ic_delete"
    static let IC_HOME = "ic_home"
    static let IC_CONTACT = "ic_contact"
    static let IC_TRANSACTION = "ic_history"
    static let IC_WALLET = "ic_wallet"
    static let IC_SCANNER = "ic_scanner"
    static let IC_SCAN = "ic_scan"
    static let IC_SCANNER_BLUE = "ic_scanner_blue"
    static let IC_QRCODE = "ic_qrcode"
    static let IC_LOGO = "ic_logo"
    static let IC_USER = "ic_user"
    static let IC_PASSWORD = "ic_password"
    static let IC_DROPDOWN = "ic_drop_down"
    static let IC_CIRCLE_CASH_IN = "ic_circle_cash_in"
    static let IC_CIRCLE_CASH_OUT = "ic_circle_cash_out"
    static let IC_CIRCLE_CASH_CHANGE = "ic_circle_cash_change"
    static let IC_CIRCLE_TRANSFER = "ic_circle_transfer"
    
    static let IC_CIRCLE_CASH_IN_GRAY = "ic_circle_cash_in_gray"
    static let IC_CIRCLE_CASH_OUT_GRAY = "ic_circle_cash_out_gray"
    static let IC_CIRCLE_CASH_CHANGE_GRAY = "ic_circle_cash_change_gray"
    static let IC_CIRCLE_TRANSFER_GRAY = "ic_circle_transfer_gray"
    
    static let IC_BELL = "ic_bell"
    static let IC_LIXI = "ic_lixi"
    static let IC_GIFT = "ic_gift"
    static let IC_LIXI_CLOSE = "ic_lixi_close"
    static let IC_LIXI_OPEN = "ic_lixi_open"
    static let IC_LIXI_BACKGROUND = "ic_lixi_background"
    static let IC_ELECTRONIC = "ic_electronic"
    static let IC_WATER = "ic_water"
    static let IC_SHOP = "ic_shop"
    static let IC_CABLE = "ic_cable"
    static let IC_BG_HEADER = "ic_bg_header"
    static let IC_FULL_HEADER = "ic_full_header"
    static let IC_ERROR = "ic_error"
    static let IC_SUCCESS = "ic_success"
    static let IC_SIGN_OUT = "ic_sign_out"
    static let IC_HELP = "ic_help"
    static let IC_DESTROY = "ic_block"
    static let IC_CHANGE_PASSWORD = "ic_change_password"
    static let IC_NEXT = "ic_next"
    static let IC_NEXT_IOS = "ic_next_ios"
    static let IC_EDIT_PICTURE = "ic_edit_picture"
    static let IC_EXCLAMATION = "ic_exclamation"
    static let IC_FLASH = "ic_flash"
    static let IC_GALLERY = "ic_gallery"
    static let IC_CONTACT_ACTIVE = "ic_contact_active"
    static let IC_BACK = "ic_back"
    static let IC_PLUS = "ic_plus"
    static let IC_CHECK_LIST = "ic_check_list"
    static let IC_CHECK_LIST_ACTIVE = "ic_check_list_active"
    static let IC_CHECKBOX = "ic_checkbox"
    static let IC_CHECKBOX_ACTIVE = "ic_checkbox_active"
    static let IC_CHECK_SUCCESS = "ic_check_success"
    static let IC_CHECK_FAIL = "ic_check_fail"
    static let IC_MORE = "ic_more"
    static let IC_FILTER = "ic_filter"
    static let IC_SHARE = "ic_share"
    static let IC_DOWNLOAD = "ic_download"
    static let IC_SIGN_OUT_RED = "ic_sign_out_red"
    static let IC_CHECK = "ic_check"
    static let IC_LANGUAGE = "ic_language"
    static let IC_INTRO_BACKGROUND = "ic_intro_background"
    static let IC_INTRO_1 = "ic_intro_1"
    static let IC_INTRO_2 = "ic_intro_2"
    static let IC_INTRO_3 = "ic_intro_3"
    static let IC_INTRO_4 = "ic_intro_4"
    static let IC_INTRO_LIXI_1 = "ic_intro_lixi_1"
    static let IC_INTRO_LIXI_2 = "ic_intro_lixi_2"
    static let IC_INTRO_LIXI_3 = "ic_intro_lixi_3"
    static let IC_INTRO_LIXI_4 = "ic_intro_lixi_4"
    static let IC_AVATAR = "ic_avatar"
    static let IC_SEND = "ic_send"
    static let IC_LIX_TRANSACTION = "ic_lixi_transaction"
    static let IC_PAYMENT = "ic_payment"
    static let IC_PAYTO = "ic_payto"
    static let IC_PAYTO_GRAY = "ic_payto_gray"
}

struct AppColors {
    static let gray_default = UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    static let gray_border = UIColor.init(red: 210/255, green: 207/255, blue: 208/255, alpha: 1)
    static let gray_background = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
    
    static let TEXTFIELD_BORDER = UIColor.init(rgb: 0x797979)
    static let BUTTON_BG_COLOR = UIColor.init(rgb: 0x3A4455)
    
    static let GRAY_COLOR = UIColor.init(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    static let GRAY_COLOR_0_7 = UIColor.init(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 0.7)
    static let FLOAT_LABEL_COLOR = UIColor.init(red: 132/255.0, green: 136/255.0, blue: 143/255.0, alpha: 1.0)
    static let PLACEHOLDER_LABEL_COLOR = UIColor.init(red: 47/255.0, green: 47/255.0, blue: 47/255.0, alpha: 1.0)
    static let TITLE_COLOR_GLOBAL = UIColor.init(red: 77/255.0, green: 77/255.0, blue: 77/255.0, alpha: 1.0)
    // Official color
    static let BLUE_COLOR = UIColor.init(red: 58/255.0, green: 68/255.0, blue: 85/255.0, alpha: 1.0) // For links buttons, actions, labels and functions
    static let RED_COLOR = UIColor.init(red: 204/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1.0) // For special elements, UI status & hover effects
    static let GREY_COLOR = UIColor.init(red: 251/255.0, green: 251/255.0, blue: 251/255.0, alpha: 1.0) // For element backgrounds ex: Sub-menu
    static let WHITE_COLOR = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) // For menu / List-Buttons
    static let BLACK_COLOR = UIColor.init(red: 46/255.0, green: 45/255.0, blue: 44/255.0, alpha: 1.0) // For regular text and labels
    static let RED2_COLOR = UIColor.init(red: 134/255.0, green: 26/255.0, blue: 23/255.0, alpha: 1.0) // For special text, buttons, and active states
    static let GREY2_COLOR = UIColor.init(red: 178/255.0, green: 178/255.0, blue: 178/255.0, alpha: 1.0) // For placeholders and inactive elemenet
    static let GREY3_COLOR = UIColor.init(rgb: 0xb2b2b2) // for episode left side background
    
    static let GREEN_COLOR = UIColor.init(red: 73/255.0, green: 170/255.0, blue: 75/255.0, alpha: 1.0) // For UI status & confirmations
    static let ORANGE_COLOR = UIColor.init(red: 241/255.0, green: 119/255.0, blue: 10/255.0, alpha: 1.0) // For UI status and elements
    static let ALARM_COLOR = UIColor.init(rgb: 0x861a17)
    static let OVERLAY_BG_COLOR = UIColor.init(white: 0, alpha: 0.5)
    static let STATUS_COLOR = UIColor.darkGray
    static let GREEN_LIGHT_COLOR = UIColor.init(red: 137/255.0, green: 176/255.0, blue: 35/255.0, alpha: 1.0) // For UI background color for header
    static let GREEN_DARK_COLOR = UIColor.init(red: 15/255.0, green: 124/255.0, blue: 126/255.0, alpha: 1.0) // For UI background
    static let BLUE_LIGHT_COLOR = UIColor.init(red: 0/255.0, green: 104/255.0, blue: 139/255.0, alpha: 1.0) // For UI search view
    
//    blue: #38BBE9
//    blue-light: #38BBE9 (50% opacity)
//    gray: #99A9B3
//    gray-light: #F0F0F0
//    gray-light-text : #828899
//    black: #000000
//    popup background: #082034 (50% opacity)
//    F0F0F0 : background color of contact
    static let BLUE = UIColor.init(red: 56/255.0, green: 187/255.0, blue: 233/255.0, alpha: 1.0)
    static let BLUE_LIGHT = UIColor.init(red: 56/255.0, green: 187/255.0, blue: 233/255.0, alpha: 0.5)
    static let GRAY = UIColor.init(red: 153/255.0, green: 169/255.0, blue: 179/255.0, alpha: 1.0)
    static let GRAY_LIGHT = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    static let GRAY_LIGHT_TEXT = UIColor.init(red: 130/255.0, green: 136/255.0, blue: 153/255.0, alpha: 1.0)
    static let GRAY_50 = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let GRAY_80 = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)

    static let POPUP_BACKGROUND = UIColor.init(red: 8/255.0, green: 32/255.0, blue: 52/255.0, alpha: 0.5)
    static let ORANGE = UIColor.init(red: 241/255.0, green: 89/255.0, blue: 43/255.0, alpha: 1.0)
    static let GRAY_LIGHT_90 = UIColor.init(red: 242/255.0, green: 246/255.0, blue: 249/255.0, alpha: 1.0)
}

struct LanguageKey {
    static let RequestFailed = "REQUEST_FAILED"
    static let InvalidData = "INVALID_DATA"
    static let ResponseUnsuccessful = "RESPONSE_UNSUCCESSFUL"
    static let NoInternetConnection = "NO_INTERNET_CONNECTION"
    static let JsonParsingFailure = "JSON_PARSING_FAILURE"
    static let JsonConversionFailure = "JSON_CONVERSION_FAILURE"
    static let ErrorPasswordRequired = "ERROR_PASSWORD_REQUIRED"
    static let ErrorOldPasswordRequired = "ERROR_OlD_PASSWORD_REQUIRED"
    static let ErrorNewPasswordRequired = "ERROR_NEW_PASSWORD_REQUIRED"
    static let ErrorConfirmPasswordRequired = "ERROR_CONFIRM_PASSWORD_REQUIRED"
    static let ErrorPasswordInvalid = "ERROR_PASSWORD_INVALID"
    static let ErrorPasswordLength = "ERROR_PASSWORD_LENGTH"
    static let ErrorEmailRequired = "ERROR_EMAIL_REQUIRED"
    static let ErrorEmailInvalid = "ERROR_EMAIL_INVALID"
    static let ErrorUserNameRequired = "ERROR_USERNAME_REQUIRED"
    static let ErrorUserNameInvalid = "ERROR_USERNAME_INVALID"
    static let ErrorPhoneNumberRequired = "ERROR_PHONENUMBER_REQUIRED"
    static let ErrorPhoneNumberInvalid = "ERROR_PHONENUMBER_INVALID"
    static let UsernamePlaceHolder = "USERNAME"
    static let EmailPlaceHolder = "EMAIL"
    static let PasswordPlaceHolder = "PASSWORD"
    static let PhonePlaceHolder = "PHONE"
    static let SignInButton = "SIGNIN"
    static let Error = "ERROR"
    static let Success = "SUCCESS"
    static let Fail = "FAIL"
    
    static let ErrorFirstNameRequired = "ERROR_FIRSTNAME_REQUIRED"
    static let ErrorLastNameRequired = "ERROR_LASTNAME_REQUIRED"
    static let ErrorBirthdayRequired = "ERROR_BIRTHDAY_REQUIRED"
    static let ErrorBirthdayInvalid = "ERROR_BIRTHDAY_INVALID"
  
    //time
    static let Time_Day = "DAY"
    static let Time_Days = "DAYS"
    static let Time_Hour = "HOUR"
    static let Time_Hours = "HOURS"
    static let Time_Minute = "MINUTE"
    static let Time_Minutes = "MINUTES"
    static let Time_Second = "SECOND"
    static let Time_Seconds = "SECONDS"
    
    //Home
    static let To = "TO"
    static let FROM = "FROM"
    static let Passengers = "PASSENGERS"
    static let SeatClass = "SEATCLASS"
    static let DepartureDate = "DEPARTURE_DATE"
    static let ReturnDate = "RETURN_DATE"
    static let Search = "SEARCH"
    static let Price = "PRICE"
    static let Direct = "DIRECT"
    static let StopNumber = "STOPNUMBER"
    static let Continue = "CONTINUE"
    static let Departure = "DEPARTURE"
    static let Return = "RETURN"
    static let History = "HISTORY"
    static let Sync  = "SYNC"
    static let AccountName = "ACCOUNTNAME"
    static let eCashId = "ECASHID"
    static let eCashBalance = "ECASHBALANCE"
    static let eDongId = "EDONGID"
    static let eDongBalance = "EDONGBALANCE"
    static let AddeCash = "ADDECASH"
    static let WithDraweCash = "WITHDRAWECASH"
    static let ExchangeeCash = "EXCHANGEECASH"
    static let Transfer = "TRANSFER"
    static let PaymentServices = "PAYMENTSERVICES"
    static let PayEVN = "PAYEVN"
    static let RequirePayTo = "REQUIRE_PAY_TO"
    static let CreateToPay = "CREATE_TO_PAY"
    static let PayWATER = "PAYWATER"
    static let PaySupermarket = "PAYSUPERMARKET"
    static let PayVTVCab = "PAYVTVCAB"
    static let ActiveAccountNow = "ACTIVE_ACCOUNT_NOW"
    static let ReNewNotAllow = "RENEW_NOT_ALLOW"

    
    //Confirm
     static let Gender = "GENDER"
     static let FirstName = "FIRSTNAME"
     static let LastName = "LASTNAME"
     static let Birthday = "BIRTHDAY"
     static let ContactInfo = "CONTACTINFO"
     static let Booking = "BOOKING"
     static let FillUp = "FILL_UP"
    //Checkout
     static let TicketNumber = "TICKETNUMBER"
     static let Status = "STATUS"
     static let TotalMoney = "TOTALMONEY"
     static let NoPayment = "NOPAYMENT"
     static let Paymented = "PAYMENTED"
     static let Checkout = "CHECKOUT"
     static let FLIGHTNAME = "FLIGHTNAME"
     //Destination
     static let SearchPlaceholder = "SEARCHPLACEHOLDER"
     static let NoResult = "NORESULT"
     static let Cancel = "CANCEL"
     static let TryAgain = "TRY_AGAIN"
     static let Ok = "OK"
   
     //SignIn
     static let TitleBrand = "ECASH"
     static let SignOut = "SIGNOUT"
     static let SignInWithGoogle = "SIGNINWITHGOOGLE"
     static let ErrorUserNameNotMathCurrentUserName = "ERROR_USERNAME_DOES_NOT_MATH_CURRENT_USERNAME"
     static let USER_NOT_ACTIVE = "USER_NOT_ACTIVE"
     //HistoryCheckout
     static let OneWay = "ONEWAY"
     static let Total = "TOTAL"
     static let Quantity = "QUANTITY"
     static let CreatedDate = "CREATEDDATE"
     static let Contact = "CONTACT"
     static let Maximum7Passengers = "MAXIMUM7PASSENGERS"
     static let InfantCouldNotMoreThanAdult = "INFANTCOUNTNOTMORETHANADULT"
     //Gallery
     static let ChooseFromLibrary = "CHOOSEFROMLABRARY"
     static let ChooseFromPhotoRoll = "CHOOSEFROMPHOTOROLL"
     static let NoSources = "NOSOURCES"
     static let TakePhoto = "TAKEPHOTO"
     static let TakeVideo = "TAKEVIDEO"
     //Tab bar
     static let Home = "HOME"
     static let Scanner = "SCANNER"
     static let Transaction = "TRANSACTION"
     static let MyWallet = "MYWALLET"
     static let MyProfile = "MYPROFILE"
     static let eCash = "ECASH"
     //SignIn
     static let CouldNotSignIn = "COULD_NOT_SIGN_IN"
     static let DoNotHaveAnAccount = "DO_NOT_HAVE_AN_ACCOUNT"
     static let SignUpNow = "SIGN_UP_NOW"
     static let ActiveSuccessful = "ACTIVE_SUCCESSFUL"
     static let UsernameCouldNotContainSpecialCharacter = "USERNAME_COULD_NOT_CONTAIN_SPECIAL_CHARACTER"
     //SignUp
     static let SignUp = "SIGNUP"
     static let AccountNumber = "ACCOUNTNUMBER"
     static let FullName = "FULLNAME"
     static let Password = "PASSWORD"
     static let EnterId = "ENTERID"
     static let EnterPhoneNumber = "ENTERPHONENUMBER"
     static let ConfirmPassWord = "CONFIRMPASSWORD"
     static let ErrorAccountNumberRequired = "ERROR_ACCOUNT_NUMBER_REQUIRED"
     static let ErrorFullNameRequired = "ERROR_FULLNAME_REQUIRED"
     static let ErrorConfirmRequired = "ERROR_CONFIRM_REQUIRED"
     static let ErrorIdRequired = "ERROR_ID_REQUIRED"
     static let ErrorIdInvalid = "ERROR_ID_INVALID"
     static let ErrorPasswordDoNotMatch = "PASSWORD_DO_NOT_MATCH"
     static let Alert = "ALERT"
     static let ErrorOTPRequest = "ERROR_OTP_REQUIRED"
     static let AddOTP = "ADD_OTP"
     static let PleaseEnterTheOTPCode = "PLEASE_ENTER_THE_OTP_CODE"
     static let Active = "ACTIVE"
     static let OTPCode = "OTP_CODE"
     static let IdMustBeDigitNumber = "ID_MUST_BE_DIGIT_NUMBERS"
    
     //Add eCash
     static let Verify = "VERIFY"
     static let Money = "MONEY"
     static let M500 = "M500"
     static let M200 = "M200"
     static let M100 = "M100"
     static let M50 = "M50"
     static let M20 = "M20"
     static let M10 = "M10"
     static let YoureDongBalanceIsNotEnough = "EDONG_NOT_ENOUGH"
     static let SocketConnectError = "SOCKET_CONNECT_ERROR"
     static let NotFoundeDongId = "NOT_FOUND_EDONG_ID"
     static let eCashToeCash = "ECASH_TO_ECASH"
     static let NoListAvailable = "NO_LIST_AVAILABLE"
     static let SelectMoney = "SELECT_MONEY"
     static let Count = "COUNT"
     static let Amount = "AMOUNT"
     //WithdraweCash
     static let WithdraweCash = "WITHDRAW_ECASH"
     static let WithdrawToeDong = "WITHDRAW_TO_EDONG"
     static let EnterMoney = "ENTERMONEY"
     static let ErrorMoneyRequired = "ERROR_MONEY_REQUIRED"
     static let YoureCashBalanceIsNotEnough = "ECASH_NOT_ENOUGH"
    
    //Transfer
     static let EntereCashId = "ENTER_ECASH_ID"
     static let EnterContent = "ENTER_CONTENT"
     static let TransferToeCash = "TRANSFER_TO_ECASH"
     static let ErrorWalletIdRequired = "ERROR_WALLET_ID_REQUIRED"
     static let ErrorMonenyRequired = "ERROR_MONEY_REQUIRED"
     static let ErrorContentRequired = "ERROR_CONTENT_REQUIRED"

     //Alert
     static let ErrorOcurred = "ERROR_OCURRED"
     static let IdNumber = "ID_NUMBER"
     static let Username  = "USERNAME"
     static let NotExisted = "NOT_EXISTED"
     static let AlreadyExisted = "ALREADYEXISTED"
     static let Close = "CLOSE"
     static let Yes = "YES"
     static let No = "NO"
     static let DoYouWantToSignIn = "DO_YOU_WANT_TO_SIGIN"
     static let TransactionSuccessful = "TRANSACTION_SUCCESSFUL"
     static let YouHaveAddedToeCash = "YOU_HAVE_ADDED_TO_ECASH"
     static let YouHaveWithdrawnFromeDong = "YOU_HAVE_WITHDRAWN_FROM_EDONG"
     static let YouHaveTransferredToeCash = "YOU_HAVE_TRANSFERRED_TO_ECASH"
     static let YouHaveExchangedCash = "YOU_HAVE_EXCHANGED_CASH"
    
    
     //My Wallet
     static let ChangePassword = "CHANGE_PASSWORD"
     static let Help = "HELP"
     static let ChangedPasswordSuccessfully = "CHANGED_PASSWORD_SUCCESSFULLY"
     static let DeleteAccount = "DELETEACCOUNT"
     static let DoYouWantExitThisSession = "DO_YOU_WANT_EXIT_THIS_SESSION"
     
     //My Profile
     static let Address = "ADDRESS"
     static let PhoneNumber = "PHONE_NUMBER"
     static let Change = "CHANGE"
     static let SessionExpried = "SESSION_EXPIRED"
     static let SignIn = "SIGN_IN"
     static let ThisFeatureComingSoon = "THIS_FEATURE_COMING_SOON"
     static let MyAvatar = "MY_AVATAR"
     static let MyQRCode = "MY_QRCODE"
     static let ValueExisted = "VALUE_EXISTED"
     //Scanner
     static let Flash = "FLASH"
     static let Gallery = "GALLERY"
     static let ScanQR = "SCANQR"
     static let CreatedQR = "CREATED_QR"
     static let QRTitle = "QRTITLE"
     static let QRStatus = "QRSTATUS"
     static let UseQRCode = "USEQRCODE"
     static let GeneratedQR = "GENERATEDQR"
     static let AskPermissionAlert = "ASK_PERMISSION_ALERT"
     static let QRCodeHasBeenReceivedBefore = "QRCODE_HAS_BEEN_RECEIVED_BEFORE"
     static let InvalidQRCode = "INVALID_QRCODE"
     static let TransactionAreSentToAnother = "TRANSACTION_ARE_SENT_TO_ANOTHER"
     //Exchange eCash
     static let CashListAvailable = "CASH_LIST_AVAILABLE"
     static let CashExchage = "CASH_EXCHANGE"
     static let CashReceive = "CASH_RECEIVE"
     static let ExchangeCash = "EXCHANGE_CASH"
     static let TotalExchangeCash = "TOTAL_EXCHANGE_CASH"
     static let TotalExpectationCash = "TOTAL_EXPECTATION_CASH"

    //Transactions History
    static let StatusSuccess = "STATUS_SUCCESS"
    static let StatusFail = "STATUS_FAIL"
    static let Months = "MONTHS"
    
     //Generated QRCode
     static let Send = "SEND"
     static let Delete = "DELETE"
     //Scanner Result
     static let ReceiveeCash = "RECEIVEECASH"
     static let TransactionsInfo = "TRANSACTIONSINFO"
     static let eCashTotal = "ECASHTOTAL"
     static let Sender = "SENDER"
     static let Content = "CONTENT"
     static let ReceiverNotFound = "RECEIVER_NOT_FOUND"
     static let AskPermission = "ASK_PERMISSION"
     static let ReceivedLixiSuccessfully = "RECEIVED_LIXI_SUCCESSFULLY"
     //Contact
     static let Edit = "EDIT"
     static let DeviceInfo = "DEVICE_INFO"
     static let WalletNumber = "WALLET_NUMBER"
     static let TypeName = "TYPE_NAME"
     //Add contact
     static let AddContact = "ADD_CONTACT"
    static let AddContactSuccess = "ADD_CONTACT_SUCCESS"
    static let AddContactExisted = "ADD_CONTACT_EXISTED"
     static let Add = "ADD"
     static let TypePhoneNumberWalletId = "TYPE_PHONE_NUMBER_OR_WALLET_ID"
     //Transaction filter
     static let Time = "TIME"
     static let TransactionType = "TRANSACTION_TYPE"
     static let Done = "DONE"
     static let TransactionDetail = "TRANSACTION_DETAIL"
     static let eCashEmount = "ECASH_AMOUNT"
     static let Clear = "CLEAR"
     static let ChooseTime = "CHOOSE_TIME"
     static let ChooseType = "CHOOSE_TYPE"
     static let ChooseStatus = "CHOOSE_STATUS"
     //Transaction log detail
     static let QRCode = "QRCODE"
     static let Share = "SHARE"
     static let SaveToDevice = "SAVE_TO_DEVICE"
     static let ReceiverCode = "RECEIVER_CODE"
     static let Issuer = "ISSUER"
     static let SenderCode  = "SENDER_CODE"
     static let FullNameTitle = "FULLNAME_TITLE"
     static let AlreadySavedQRCodeToDevice = "ALREADY_SAVED_QRCODE_TO_DEVICE"
     static let AreYouSureDeleteThisAccount  = "ARE_YOU_SURE_DELETE_THIS_ACCOUNT"
     static let SavedToDevice = "SAVED_TO_DEVICE"
     //Destroy Wallet
     static let DestroyAccount = "DESTROY_ACCOUNT"
     static let DestroyContent   = "DESTROY_CONTENT"
     static let TransfereCash = "TRANSFER_ECASH"
     static let Exit = "EXIT"
     static let DestroyAccountSuccessfully = "DESTROY_ACCOUNT_SUCCESSFULLY"
     //Change Password
     static let EnterNewPassword = "ENTER_NEW_PASSWORD"
     static let EnterOldPassword = "ENTER_OLD_PASSWORD"
     static let NewPasswordIsTheSameWithOldPassword = "NEW_PASSWORD_IS_THE_SAME_WITH_OLD_PASSWORD"
     //Forgot password
     static let ForgotPassword  = "FORGOTPASSWORD"
     static let VerifyOTP = "VERIFY_OTP"
     static let TheCodeWasSentTo = "THE_CODE_WAS_SEND_TO"
     static let EnterOTPCode = "ENTER_OTP_CODE"
     static let Resend = "RESEND"
     static let RecoverPassword = "RECOVERPASSWORD"
     static let RecoverPasswordSuccessfully = "RECOVER_PASSWORD_SUCCESSFULLY"
     //Mutiple languages
     static let ChooseYourLanguage = "CHOOSE_YOUR_LANGUAGE"
     static let Vietnamese = "VIETNAMESE"
     static let English = "English"
     static let Language =  "LANGUAGE"
     //My QRCode
     static let ScanQRCodeLetToEWallet = "SCANQRCODELETTOADDEWALLET"
     static let CouldNotAddToItself  = "COULD_NOT_ADD_TO_ITSELF"
     static let CouldNotTransferToItself = "COULD_NOT_TRANSFER_TO_ITSELF"
     static let YourImagesSaveToPhotos = "YOUR_IMAGE_WAS_SAVED_TO_PHOTOS"
     //Intro
     static let Skip = "SKIP"
     static let Start = "START"
     static let NotificationHistory = "NOTIFICATION_HISTORY"
    
     //Profile info
     static let ProfileInfo = "PROFILE_INFO"
     static let Full_Name = "FULL_NAME_PROFILE"
     static let ErrorAddressRequired = "ERROR_ADDRESS_REQUIRED"
     //GalleryOptions
     static let ChangeAvatar = "CHANGE_AVATAR"
     static let ChooseFromGallery = "CHOOSE_FROM_GALLERY"
     static let TakePicture = "TAKE_PICTURE"
     static let YouCouldNotSelectMoreThan = "YOU_COULD_NOT_SELECT_MORE_THAN"
     //Lixi
     static let Opened = "OPENED"
     static let Lock = "LOCK"
     static let YourLixi = "YOUR_LIXI"
     static let LuckyMoneyFrom = "LUCKY_MONEY_FROM"
     static let LuarNewYearFromECPAY = "LUNAR_NEW_YEAR_FROM_ECPAY"
     //SendLixi
     static let SendLixi = "SEND_LIXI"
     //ReceiveLixiOptions
     static let Greetings = "GREETINGS"
     static let GreetingsMessage = "GREETINGS_MESSAGE"
     static let LuckyMoney = "LUCKY_MONEY"
     static let ChooseTemplate  = "CHOOSE_TEMPLATE"
     static let ErrorOccurredLocalDB = "ERROR_OCCURREDLOCAL_DB"
     static let UpdatedSuccessfully = "UPDATED_SUCCESSFULLY"
     static let InsertedSuccessfully = "INSERTED_SUCCESSFULLY"
     static let ErrorOccurredFromSystem = "ERROR_OCCURRED_FROM_SYSTEM"
     static let PleaseActiveAccountToUseThisFeature = "PLEASE_ACTIVE_ACCOUNT_TO_USE_THIS_FEATURE"
     static let NotFound = "NOT_FOUND"
     static let AccountDoesNotExist = "ACCOUNT_DOES_NOT_EXIST"
     static let PasswordIncorrect = "PASSWORD_INCORRECT"
     static let OTPInvalid = "OTP_INVALID"
     static let OTPIncorrect = "OTP_INCORRECT"
     static let AccountNotActivated = "ACCOUNT_NOT_ACTIVATED"
     static let PleaseEnterParam = "PLEASE_ENTER_PARAM"
     static let PleaseEnterFullFields = "PLEASE_ENTER_FULL_FIELDS"
     //Request payment
     static let Payment = "PAYMENT"
     static let PaymentRequest = "PAYMENT_REQUEST"
     static let PaymentContent = "PAYMENT_CONTENT"
     static let InputAccountEcashNumber = "INPUT_ACCOUNT_ECASH_NUMBER"
     static let GetAccountByQrCode = "GET_ACCOUNT_BY_QR_CODE"
     static let InputPaymentAmount = "INPUT_PAYMENT_AMOUNT"
     static let InputPaymentContent = "INPUT_PAYMENT_CONTENT"
     //Popup Request payment
     static let AccountECashWallet = "ACCOUNT_ECASH_WALLET"
     static let RequireYourPayment = "REQUIRE_YOUR_PAYMENT"
     static let WithContentPaymentAs = "WITH_CONTENT_PAYMENT_AS"
     //Popup Failure Transaction
     static let CannotProcessPayment = "CANNOT_PROCESS_PAYMENT"
     static let CurrentWalletNotEnoughMoney = "CURRENT_WALLET_NOT_ENOUGH_MONEY"
     static let ToProcessTransaction = "TO_PROCESS_TRANSACTION"
     static let YouHavePaid = "YOU_HAVE_PAID"
     static let ForAccountECashWallet = "FOR_ACCOUNT_ECASH_WALLET"
     static let HomeScreen = "HOME_SCREEN"
     static let Confirm = "CONFIRM"
     static let PaymentInfo = "PAYMENT_INFO"
     static let AmountYouArePayment = "AMOUNT_YOU_ARE_PAYMENT"
     static let ForWallet = "FOR_WALLET"
     static let TotalEcashPayment = "TOTAL_ECASH_PAYMENT"
     static let CreatePaymentBill = "CREATE_PAYMENT_BILL"
     static let CreatedSuccessQRCode = "CREATED_SUCCESS_QR_CODE"
     static let ScanQrCodeToPay = "SCAN_QR_CODE_TO_PAY"
     static let eCashID = "ECASH_ID"
     static let DownToDevice = "DOWN_TO_DEVICE"
     static let SentRequestSuccessFul = "SENT_REQUEST_SUCCESSFUL"
     static let AmountEcashComfortable = "AMOUNT_ECASH_COMFORTABLE"
     static let AmountMustLesser20Million = "AMOUNT_MUST_LESSER_20_MILLION"
     static let Paid = "LUCKY_MONEY"
     static let Maximum10WalletCheckout = "MAXIMUM_10_WALLET_CHECKOUT"
     static let SummaryValues = "SUMMARY_VALUES"
     static let PleaseScanAnotherWallet = "PLEASE_SCAN_ANOTHER_WALLET"
     static let LocalDataHadViolented = "LOCAL_DATA_HAD_VIOLENTED"
}

struct LanguageCode {
    static let English = "en"
    static let Vietnamese = "vi"
}

struct StorageKey {
  static let activeAccountData = "ActiveAccountData"
  static let signupData = "SignUpData"
  static let signInData = "SignInData"
  static let signInNoneWalletData = "SignInNoneWalletData"
  static let configData = "configurationData"
  static let cipherKey = "cipherKey"
  static let eDongInfoData = "eDongInfoData"
  static let isAlreadyStore = "isAlreadyStore"
  static let keychain = "keychain"
  static let keychainFirebase = "keychainFirebase"
  static let masterkey = "masterkey"
  static let lastAccessTime = "lastAccessTime"
  static let firstCreatedKeyChain = "firstCreatedKeyChain"
  static let deviceId  = "deviceId"
  static let multipleLanguages = "multipleLanguages"
  static let firebaseToken = "firebaseToken"
  static let channelPublicKey = "channelPublicKey"
  static let isIntro = "isIntro"
  static let isSignOut = "isSignOut"
  static let ToPayQRModel = "ToPayQRModel"
  static let IsWaittingForPayToQR = "IS_WAITING_FOR_PAY_TO_QR"
  static let CurrentPayToState = "CURRENT_PAY_TO_STATE"
  static let newApp = "NEW_APP"
}

struct LimitationValues {
    static var MAXIMUM_AMOUNT_TRANSACTION = 20000000
}

struct FolderName {
    static let db = "db"
    static let gallery = "gallery"
    static let png = "png"
}

struct ConfigKey {
   static let BaseUrl = "RootUrl"
   static let WSUrl = "WSUrl"
   static let AppName = "CFBundleName"
   static let GoogleClientId = "GoogleClientId"
   static let GoogleReversedClientId = "GoogleReversedClientId"
   static let AppDataFolder = "appDataFolder"
   static let RequestUpdateeDong = "RequestUpdateeDong"
   static let DismissView = "DismissView"
   static let RequestQRCodeResult = "RequestQRCodeResult"
   static let UpdatedUIForChangedLanguage = "UpdatedUIForChangedLanguage"
   static let RequestCheckAvailableNotification = "RequestCheckAvailableNotification"
   static let RequestNavigationNotificationHistory = "RequestNavigationNotificationHistory"
   static let RequestSaveToPhotos = "RequestSaveToPhotos"
   static let ActionToView = "ActionToView"
   static let ActionToObjectView = "ActionToObjectView"
}

struct CipherKey {
    static let Key = "0123456789ABCDEFGHIJKL0123456789"
    static let PrivateChannelKey = CommonService.getClientSecretKey() ?? ""
    static let PublicChannelKey = CommonService.getClientPublicKey() ?? ""
    static let PublicServerKey = CommonService.getChannelPublicKey() ?? ""
    static let EDONGECPAY = 1238161606
    static let ECPAY = "ECPAY"
    static let ExchangeCash = "Exchange cash"
}

struct GoogleScopes {
    static let DRIVE_FILE = " https://www.googleapis.com/auth/drive.file"
    static let DRIVE_APPDATA = "https://www.googleapis.com/auth/drive.appdata"
}

struct ApiEndPointUrl {
    static let BaseUrl = ConfigKey.BaseUrl
    static let CheckingIdNumberAndPhoneNumber = "/ecgateway/execute/FU100"
    static let CheckingUsername = "/ecgateway/execute/FU00003"
    static let SignUp = "/ecgateway/execute/FU0001"
    static let ActiveAccount = "/ecgateway/execute/FU0003"
    static let SignIn = "/ecgateway/execute/FU00004"
    static let SignOut = "/ecgateway/execute/GW000001"
    static let eDongToeCashOwner = "/ecgateway/execute/GWEC0004"
    static let eDongToeCashOwnerAmount = "/ecgateway/execute/GWEC0001"
    static let eDongToeCashToSomeone = "/ecgateway/execute/GWEC0002"
    static let eDongToeCashToSomeoneAmount = "/ecgateway/execute/GWEC0003"
    static let GeteDongInfo = "/ecgateway/execute/FU0002"
    static let eCashToeDong = "/ecgateway/execute/GW000001"
    static let SignInWithNoneWallet = "/ecgateway/execute/GWEC0029"
    static let SignInWithNoneWalletValidatedOTP = "/ecgateway/execute/GWEC0030"
    static let GetWalletInfo = "/ecgateway/execute/GWEC0007"
    static let GetPublicKeyeCashRelease = "/ecgateway/execute/GWEC0005"
    static let GetPublicKeyOrganizeRelease = "/ecgateway/execute/GWEC0006"
    static let ReSendOTP = "/ecgateway/execute/GW000004"
    static let ChangePassword = "/ecgateway/execute/GW000003"
    static let DestroyWallet = "/ecgateway/execute/GWEC0020"
    static let VerifyTransaction = "/ecgateway/execute/GWEC0008"
    static let ExchangeCash = "/ecgateway/execute/GWEC0011"
    static let SyncContact = "/ecgateway/execute/GWEC0017"
    static let SearchByPhoneNumber = "/ecgateway/execute/GWEC0016"
    static let SendOTP = "/ecgateway/execute/GWEC0024"
    static let UpdatedForgotPassword = "/ecgateway/execute/GWEC0025"
    static let EditProfile = "/ecgateway/execute/GWEC0021"
    static let UploadAvatar = "/ecgateway/execute/GWEC0022"
    static let GetDenomination = "/ecgateway/execute/GWEC0031"
    static let AddContact = "/ecgateway/execute/GWEC0023"
    static let DeleteContact = "/ecgateway/execute/GWEC0038"
    
    static let UserSignIn = "/api/login"
    static let UserList = "/api/users/"
    static let SearchList = "/api/Airline/Search"
    static let Donwload = "/api/download"
    static let Upload = "/api/upload"
    static let Booking = "/api/Airline/Book"
    static let SaveInfo = "/api/Airline/SavePaymentInfo"
    static let ExecutePayment = "/api/airline/excusePayments"
    static let UpdatePaymentInfo = "/api/Airline/UpdatePaymentInfo"
    static let UserPassword = "/api/v2/users/password"
    static let UserDetail = "/api/v2/users/{userId}"
    static let UserAction = "/api/v2/users/{userId}/action"
    static let UserChangeUserData = "/api/v2/users/{userId}"
    static let UserPhoto = "/api/v2/users/{userId}/photo"
    static let ListUser = "/api/v2/users"
    static let AllUserEvent = "/api/v2/events/users"
}

struct Storyboard {
    static let main = "Main"
    static let author = "Author"
    static let settings = "Settings"
    static let lixi = "Lixi"
}

struct DataKeyType {
    static let ArrayString = "ArrayString"
    static let StringOriginal = "StringOriginal"
    static let QRCodeModel = "QRCodeModel"
    static let QRResultData = "QRResultData"
    static let TransferDataModel = "TransferDataModel"
}

struct Controller {
    static let signin = "SignIn"
    static let signup = "SignUp"
    static let settings = "Settings"
    static let contact = "Contact"
    static let scanner = "Scanner"
    static let transaction = "TransactionsLogs"
    static let myWallet = "MyWallet"
    static let home = "Home"
    static let tabWallet = "TabWallet"
    static let tabProfile = "TabProfile"
    static let addeCash = "AddeCash"
    static let withdraweCash = "WithdraweCash"
    static let withdraweCashMultiple = "WithdraweCashMultiple"
    static let exchangeeCash = "ExchangeeCash"
    static let transfereCash = "TransfereCash"
    static let transfereCashMultiple = "TransfereCashMultiple"
    static let alert = "Alert"
    static let scannerResult = "ScannerResult"
    static let qrCodeHistory = "QRCodeHistory"
    static let exchangeeCashOptions = "ExchangeeCashOptions"
    static let addContact  = "AddContact"
    static let editContact = "EditContact"
    static let transactionFilter = "TransactionFilter"
    static let transactionLogsDetail = "TransactionLogsDetail"
    static let signOutOptions = "SignOutOptions"
    static let destroyWalletOptions = "DestroyWalletOptions"
    static let destroyWalletSuccessfulOptions = "DestroyWalletSuccessfulOptions"
    static let changePassword = "ChangePassword"
    static let forgotPassword = "ForgotPassword"
    static let forgotPasswordOTPOptions = "ForgotPasswordOTPOptions"
    static let recoverPassword = "RecoverPassword"
    static let multipleLanguages = "MultipleLanguages"
    static let myQRCode = "MyQRCode"
    static let intro = "Intro"
    static let notificationHistory = "NotificationHistory"
    static let exchangeeCashOverviewOptions = "ExchangeeCashOverviewOptions"
    static let helpSupport = "HelpSupport"
    static let editProfile = "EditProfile"
    static let galleryOptions = "GalleryOptions"
    static let lixi = "Lixi"
    static let sendLixi = "SendLixi"
    static let receiveLixiOptions = "ReceiveLixiOptions"
    static let payTo = "PayTo"
    static let toPay = "ToPay"
    static let toPayQR = "ToPayQR"
    static let requirePaymentOptions = "RequirePaymentOptions"
    static let transactionFailureOptions = "TransactionFailureOptions"
    static let transactionSuccessOptions = "TransactionSuccessOptions"
    static let infoTransactionOptions = "InfoTransactionOptions"
    static let classNameSignInVC = "ecash.SignInVC"
    static let classNameIntroVC = "ecash.IntroVC"
}

enum EnumIdentifier : String {
    case None = "None"
    case Home  = "Home"
    case HistoryCheckout = "HistoryCheckout"
    case PaymentServices = "PaymentServices"
    case TransfereCashToeCash = "transferecashtoecash"
    case WithdrawMultipleeCash = "WithdrawMultipleeCash"
    case Contact = "contacts"
    case Transactions = "transactions"
    case QRCodeHistory = "qrcodeHistory"
    case ScannerResult = "ScannerResult"
    case ExchangeeCash = "ExchangeeCash"
    case ExchangeeCashAvailable = "ExchangeeCashAvailable"
    case ExpectationCash = "ExpectationCash"
    case AddContact = "AddContact"
    case TransactionsLogsDetail = "TransactionsLogsDetail"
    case Intro = "Intro"
    case NotificationHistory = "NotificationHistory"
    case ExchangeOverviewOptions = "ExchangeOverviewOptions"
    case ExpectationOverviewOptions = "ExpectationOverviewOptions"
    case Denomination = "Denomination"
    case SendLixi = "SendLixi"
    case Lixi = "Lixi"
    case ReceiveLixiOptions = "ReceiveLixiOptions"
    case PayInfo = "PayInfo"
}

enum EnumViewControllerNameIdentifier : String {
    case ContactVC = "ContactVC"
    case ScannerVC = "ScannerVC"
    case PayToVC = "PayToVC"
    case InfoTransactionOptionsVC = "InfoTransactionOptionsVC"
    case GlobalUpdateEvent = "GlobalUpdateEvent"
}

enum EnumResponseCode : String {
    case USER_IS_NOT_EXISTED = "3035"
    case NOT_EXISTING_USER = "1004"
    case SIGNATURE_INVALID = "3029"
    case EXISTING_VALUE = "0000"
    case Value_IS_EXISTED = "1006"
    case SESSION_NOT_EXISTED = "3043"
    case OTP_INCORRECT = "3014"
    case OTP_INVALID = "0998"
    case USER_NOT_ACTIVE = "3077"
    case PASSWORD_INVALID = "3019"
    case MISS_PARAM = "0996"
    case RENEW_NOT_ALLOW = "3015"
}

enum EnumResponseAction : String {
    case CREATED_SUCCESSFULLY = "CREATED_SUCCESSFULLY"
    case EXISTING_USERNAME = "EXISTING_USERNAME"
    case ERROR = "ERROR"
    case ERROR_USERNAME = "ERROR_USERNAME"
    case ERROR_IDNUMBER_PHONENUMBER = "ERROR_IDNUMBER_PHONENUMBER"
    case ECASH_TO_EDONG = "ECASH_TO_EDONG"
    case ECASH_TO_ECASH = "ECASH_TO_ECASH"
    case EDONG_TO_ECASH = "EDONG_TO_ECASH"
    case EXCHANGE_CASH = "EXCHANGE_CASH"
    case TRANSACTION = "TRANSACTION"
    case UPDATE = "UPDATE"
    case REQUEST_SIGN_IN = "REQUEST_SIGN_IN"
}

enum EnumFunctionName : String {
    case CHECKING_ID_NUMBER_PHONE_NUMBER = "FU100"
    case CHECKING_USERNAME = "FU00003"
    case ACTIVE_ACCOUNT = "FU0003"
    case SIGN_UP_USER = "FU0001"
    case SIGN_IN_USER  = "FU00004"
    case WEB_SOCKET = "EC00027"
    case GET_EDONG = "FU0002"
    case SIGN_IN_WITH_NONE_WALLET = "GWEC0029"
    case SIGN_IN_WITH_NONE_WALLET_VALIDATED_OTP = "GWEC0030"
    case WALLET_INFO = "GWEC0007"
    case ECASH_RELEASE = "GWEC0005"
    case ORGANIZE_RELEASE = "GWEC0006"
    case EDONG_TO_ECASH_OWNER = "GWEC0004"
    case EDONG_TO_ECASH_OWNER_AMOUNT = "GWEC0001"
    case EDONG_TO_ECASH_RECEIVER = "GWEC0002"
    case ECASH_TO_EDONG = "GWEC0009"
    case SIGN_OUT = "GW000001"
    case RESEND_OTP = "GW000004"
    case CHANGE_PASSWORD = "GW000003"
    case DESTROY_WALLET = "GWEC0010"
    case VERIFY_TRANSACTION = "GWEC0008"
    case EXCHANGE_CASH = "GWEC0011"
    case SYNC_CONTACT = "GWEC0017"
    case SEARCH_BY_PHONE = "GWEC0016"
    case SEND_OTP = "GWEC0024"
    case UPDATED_FORGOT_PASSWORD = "GWEC0025"
    case EDIT_PROFILE = "GWEC0021"
    case UPLOAD_AVATAR = "GWEC0022"
    case DENOMINATION = "GWEC0031"
    case AddContact = "GWEC0023"
    case DeleteContact = "GWEC0038"
}

enum EnumChannelName : String {
    case MB001 = "MB001"
}

enum EnumResponseToView : String {
    case ACTIVE_SUCCESS  = "ACTIVE_SUCCESS"
    case SIGN_IN_SUCCESS = "SIGN_IN_SUCCESS"
    case SIGN_UP_SUCCESS = "SIGN_UP_SUCCESS"
    case SIGN_OUT_SUCCESS = "SIGN_OUT_SUCCESS"
    case OTP_INVALID = "OTP_INVALID"
    case NO_LIST_AVAILABLE = "NO_LIST_AVAILABLE"
    case LIST_AVAILABLE = "LIST_AVAILABLE"
    case CLEAN_CONTROL = "CLEAN_CONTROL"
    case EDONG_TO_ECASH = "EDONG_TO_ECASH"
    case ECASH_TO_EDONG = "ECASH_TO_EDONG"
    case ECASH_TO_ECASH = "ECASH_TO_ECASH"
    case EXCHANGE_CASH = "EXCHANGE_CASH"
    case UPDATE_DATA_SOURCE = "UPDATE_DATA_SOURCE"
    case UPDATE_DATA_SOURCE_COLLECTION_VIEW = "UPDATE_DATA_SOURCE_COLLECTION_IVEW"
    case NO_INTERNET_CONNECTION = "NO_INTERNET_CONNECTION"
    case NO_SOCKET_CONNECTION = "NO_SOCKET_CONNECTION"
    case UPDATED_CONTACT_SUCCESSFULLY = "UPDATED_CONTACT_SUCCESSFULLY"
    case RESEND_OTP_CODE = "RESEND_OTP_CODE"
    case DELETE_ACCOUNT_SUCCESSFULLY = "DELETE_ACCOUNT_SUCCESSFULLY"
    case ECASH_AVAILABLE = "ECASH_AVAILABLE"
    case NO_ECASH = "NO_ECASH"
    case CHANGED_PASSWORD_SUCCESSFULLY = "CHANGED_PASSWORD_SUCCESSFULLY"
    case SENT_OTP_SUCCESSFULLY = "SENT_OTP_SUCCESSFULLY"
    case UPDATED_FORGOT_PASSWORD_SUCCESSFULLY = "UPDATED_FORGOT_PASSWORD_SUCCESSFULLY"
    case USER_NOT_ACTIVE = "USER_NOT_ACTIVE"
    case UPDATED_UI = "UPDATED_UI"
    case SAVED_TO_DEVICE = "SAVED_TO_DEVICE"
    case INVALID_QRCODE = "INVALID_QRCODE"
    case TRANSACTION_WAS_RECEIVED = "TRANSACTION_WAS_RECEIVED"
    case TRANSACTION_WAS_SENT_TO_ANOTHER = "TRANSACTION_WAS_SENT_TO_ANOTHER"
    case REQUEST_OTP = "REQUEST_OTP"
    case SignIn = "SIGN_IN"
    case Intro = "INTRO"
    case START = "START"
    case SKIP = "SKIP"
    case EDITED_PROFILE_SUCCESSFULLY = "EDITED_PROFILE_SUCCESSFULLY"
    case MULTIPLE_SELECTED_DONE = "MULTIPLE_SELECTED_DONE"
    case READY_TO_SUBMIT = "READY_TO_SUBMIT"
    case ACTION_GIFT = "ACTION_GIFT"
    case UPDATE_HOME_TO_LIXI = "UPDATE_HOME_TO_LIXI"
    case UPDATE_LIXI_UI = "UPDATE_LIXI_UI"
    case UPDATED_SUCCESSFULLY = "UPDATED_SUCCESSFULLY"
    case INSERTED_SUCCESSFULLY = "INSERTED_SUCCESSFULLY"
    case SOCKET_PAY_TO_REQUESTED = "SOCKET_PAY_TO_REQUESTED"
    case PayToToPayUnloadingButton  = "PAY_TO_TO_PAY_UNLOADING_BUTTON"
    case PayToAndToPaySuccessfully = "PAY_TO_AND_TO_PAY_SUCCESSFULLY"
}

enum EnumPassdata : String {
    case NONE = "NONE"
    case ALERT = "ALERT"
    case SIGNUP_RESPONSE = "SIGNUP_RESPONSE"
    case ALREADY_EXISTING_USER = "ALREADY_EXISTING_USER"
    case SIGNUP_RESPONSE_SUCCESSFULLY = "SIGNUP_RESPONSE_SUCCESSFULLY"
    case NAVIGATION = "NAVIGATION"
    case TRANSACTION_RESPONSE = "TRANSACTION_RESPONSE"
    case ECASH_TO_EDONG = "ECASH_TO_EDONG"
    case ECASH_TO_ECASH = "ECASH_TO_ECASH"
    case EDONG_TO_ECASH = "EDONG_TO_ECASH"
    case SCANNER_RESULT = "SCANNER_RESULT"
    case EXCHANGE_CASH = "EXCHANGE_CASH"
    case CONTACT_ENTITIES = "CONTACT_ENTITIES"
    case TRANSACTION_LOGS_HISTORY = "TRANSACTION_LOGS_HISTORY"
    case TRANSACTION_LOGS_DETAIL = "TRANSACTION_LOGS_DETAIL"
    case DESTROY_WALLET_OPTIONS = "DESTROY_WALLET_OPTIONS"
    case OTP = "OTP"
    case UPDATED_FORGOT_PASSWORD_COMPLETED = "UPDATED_FORGOT_PASSWORD_COMPLETED"
    case GALLERY_OPTIONS = "GALLERY_OPTIONS"
    case ReceiveLixiOptions = "ReceiveLixiOptions"
    case PayToToPayStatusPaidSuccessful = "PAY_TO_TO_PAY_STATUS_PAID_SUCCESSFUL"
    case PayToToPayStatusPaidFailure = "PAY_TO_TO_PAY_STATUS_PAID_FAILURE"
    case UserDataDidChange = "USER_DATA_DID_CHANGE"
}

enum EnumTransferType : String {
    case ECASH_TO_ECASH  = "CT"
    case ECASH_TO_EDONG = "ND"
    case EDONG_TO_ECASH = "NC"
    case EXCHANGE_MONEY = "DC"
    case STOPPING_SOCKET = "CF"
    case RECEIVE_SYNC_CONTACT = "DB"
    case DESTROY_WALLET = "HV"
    case LIXI = "LX"
    case MYQRCODE = "MC"
    case QRCODE_TO_PAY = "TP"
    case PAY_TO_TO_PAY_PAID = "TT"
    case PAY_TO_TO_PAY_REQUEST_PAYMENT = "YT"
}


enum EnumTransactionStatus : String {
    case STATUS_SUCCESS  = "1"
    case STATUS_FAIL = "0"
}

enum InputOutputType : Bool {
    case INPUT
    case OUTPUT
}

enum ButtonStatus : String {
    case ENABLE = "ENABLE"
    case DISABLE = "DISABLE"
    case LOADING = "LOADING"
}

enum EnumTransactionsAction  : String {
    case INSERT_TRANSACTION_SUCCESS = "INSERT_TRANSACTION_SUCCESS"
    case INSERT_TRANSACTION_FAILED  = "INSERT_TRANSACTION_FAILED"
    case UPDATE_TRANSACTION_SUCCESS = "UPDATE_TRANSACTION_SUCCESS"
    case UPDATE_TRANSACTION_FAILED = "UPDATE_TRANSACTION_FAILED"
    
    case INSERT_CASH_LOGS_TEMPORARY_SUCCESS = "INSERT_CASH_LOGS_TEMPORARY_SUCCESS"
    case INSERT_CASH_LOGS_TEMPORARY_FAILED = "INSERT_CASH_LOGS_TEMPORARY_FAILED"
    case UPDATE_CASH_LOGS_TEMPORARY_SUCCESS = "UPDATE_CASH_LOGS_TEMPORARY_SUCCESS"
    case UPDATE_CASH_LOGS_TEMPORARY_FAILED = "UPDATE_CASH_LOGS_TEMPORARY_FAILED"
   
    case INSERT_CASH_LOGS_SUCCESS = "INSERT_CASH_LOGS_SUCCESS"
    case INSERT_CASH_LOGS_COMPLETED = "INSERT_CASH_LOGS_COMPLETED"
    case INSERT_CASH_LOGS_FAILED = "INSERT_CASH_LOGS_FAILED"
    case UPDATE_CASH_LOGS_SUCCESS = "UPDATE_CASH_LOGS_SUCCESS"
    case UPDATE_CASH_LOGS_FAILED = "UPDATE_CASH_LOGS_FAILED"
    case CASH_LOGS_EXISTING = "CASH_LOGS_EXISTING"
    
    case INSERT_CASH_INVALID_LOGS_SUCCESS = "INSERT_CASH_INVALID_LOGS_SUCCESS"
    case INSERT_CASH_INVALID_LOGS_FAILED = "INSERT_CASH_INVALID_LOGS_FAILED"
    case UPDATE_CASH_INVALID_LOGS_SUCCESS = "UPDATE_CASH_INVALID_LOGS_SUCCESS"
    case UPDATE_CASH_INVALID_LOGS_FAILED = "UPDATE_CASH_INVALID_LOGS_FAILED"
    case CASH_INVALID_LOGS_EXISTING = "CASH_INVALID_LOGS_EXISTING"
    
    case INSERT_DECISIONS_DIARY_SUCCESS = "INSERT_DECISIONS_DIARY_SUCCESS"
    case INSERT_DECISIONS_DIARY_FAILED = "INSERT_DECISIONS_DIARY_FAILED"
    case UPDATE_DECISIONS_DIARY_SUCCESS = "UPDATE_DECISIONS_DIARY_SUCCESS"
    case UPDATE_DECISIONS_DIARY_FAILED = "UPDATE_DECISIONS_DIARY_FAILED"
    
    case CASH_RELEASE_SUCCESS = "CASH_RELEASE_SUCCESS"
    case CASH_RELEASE_COMPLETE = "CASH_RELEASE_COMPLETE"
    case VERIFY_KEY_SUCCESS = "VERIFY_KEY_SUCCESS"
    case VERIFY_KEY_FAILED = "VERIFY_KEY_FAILED"
    case FINISH_TRANSACTION_SUCCESS = "FINISH_TRANSACTION_SUCCESS"
    
    case WALLET_PUBLIC_KEY_SUCCESS = "WALLET_PUBLIC_KEY_SUCCESS"
    case WALLET_PUBLIC_KEY_FAILED = "WALLET_PUBLIC_KEY_FAILED"
}

enum EnumTransactionsName : String {
    case CASH_LOGS = "CASH_LOGS"
    case CASH_INVALID_LOGS = "CASH_INVALID_LOGS"
    case CASH_LOGS_TEMPORARY = "CASH_LOGS_TEMPORARY"
    case TRANSACTIONS_LOGS = "TRANSACTIONS_LOGS"
    case DECISIONS_DIARY = "DECISIONS_DIARY"
    case CASH_RELEASE = "CASH_RELEASE"
    case VERIFY_KEY = "VERIFY_KEY"
    case FINISH_TRANSACTION = "FINISH_TRANSACTION"
    case WALLET_PUBLIC_KEY = "WALLET_PUBLIC_KEY"
}

public enum KeychainSwiftAccessOptions {
    
    /**
     
     The data in the keychain item can be accessed only while the device is unlocked by the user.
     
     This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute migrate to a new device when using encrypted backups.
     
     This is the default value for keychain items added without explicitly setting an accessibility constant.
     
     */
    case accessibleWhenUnlocked
    
    /**
     
     The data in the keychain item can be accessed only while the device is unlocked by the user.
     
     This is recommended for items that need to be accessible only while the application is in the foreground. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
     
     */
    case accessibleWhenUnlockedThisDeviceOnly
    
    /**
     
     The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
     
     After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute migrate to a new device when using encrypted backups.
     
     */
    case accessibleAfterFirstUnlock
    
    /**
     
     The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
     
     After the first unlock, the data remains accessible until the next restart. This is recommended for items that need to be accessed by background applications. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
     
     */
    case accessibleAfterFirstUnlockThisDeviceOnly
    
    /**
     
     The data in the keychain item can always be accessed regardless of whether the device is locked.
     
     This is not recommended for application use. Items with this attribute migrate to a new device when using encrypted backups.
     
     */
    case accessibleAlways
    
    /**
     
     The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
     
     This is recommended for items that only need to be accessible while the application is in the foreground. Items with this attribute never migrate to a new device. After a backup is restored to a new device, these items are missing. No items can be stored in this class on devices without a passcode. Disabling the device passcode causes all items in this class to be deleted.
     
     */
    case accessibleWhenPasscodeSetThisDeviceOnly
    
    /**
     
     The data in the keychain item can always be accessed regardless of whether the device is locked.
     
     This is not recommended for application use. Items with this attribute do not migrate to a new device. Thus, after restoring from a backup of a different device, these items will not be present.
     
     */
    case accessibleAlwaysThisDeviceOnly
    
    static var defaultOption: KeychainSwiftAccessOptions {
        return .accessibleWhenUnlocked
    }
    
    var value: String {
        switch self {
        case .accessibleWhenUnlocked:
            return toString(kSecAttrAccessibleWhenUnlocked)
            
        case .accessibleWhenUnlockedThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
            
        case .accessibleAfterFirstUnlock:
            return toString(kSecAttrAccessibleAfterFirstUnlock)
            
        case .accessibleAfterFirstUnlockThisDeviceOnly:
            return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
            
        case .accessibleAlways:
            return toString(kSecAttrAccessibleAlways)
            
        case .accessibleWhenPasscodeSetThisDeviceOnly:
            return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
            
        case .accessibleAlwaysThisDeviceOnly:
            return toString(kSecAttrAccessibleAlwaysThisDeviceOnly)
        }
    }
    
    func toString(_ value: CFString) -> String {
        return KeychainSwiftConstants.toString(value)
    }
}
