//
//  Endpoint.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import Foundation

protocol Endpoint {
  var base: String { get }
  var path: String { get }
}

extension Endpoint {
  
  var base: String {
    return CommonService.getBaseUrl()
  }
  
  var sessionId: String {
    return CommonService.getCurrentSessionId()!
  }
  
  var defaultContentType: String {
    return "application/json"
  }
  
  var apiKey: String {
    return "api_key=34a92f7d77a168fdcd9a46ee1863edf1"
  }
  
  var urlComponents: URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    return components
  }
  
  var request: URLRequest {
    let url = urlComponents.url!
    var requestUrl = URLRequest(url: url)
    requestUrl.setValue(defaultContentType, forHTTPHeaderField: "Content-Type")
    requestUrl.setValue(sessionId, forHTTPHeaderField: "sessionId")
    // Todo set token in here
    return requestUrl
  }
}

//==================
// start user endpoint
enum UserEndPoint {
  case CheckingIdNumberAndPhoneNumber
  case CheckingUsername
  case SignIn
  case SignUp
  case SignOut
  case ActiveAccount
  case SignInWithNoneWallet
  case SignInWithNoneWalletValidatedOTP
  case WalletInfo
  case PublicKeyeCashRelese
  case PublicKeyOrganizeRelease
  case ReSendOTP
  case ChangePassword
  case SyncContact
  case SearchByPhoneNumber
  case DestroyWallet
  case SendOTP
  case UpdatedForgotPassword
  case EditProfile
  case UploadAvatar
  case AddContact
  case DeleteContact
}

extension UserEndPoint: Endpoint {
  var path: String {
    switch self {
    case .CheckingIdNumberAndPhoneNumber:
      return ApiEndPointUrl.CheckingIdNumberAndPhoneNumber
    case .CheckingUsername :
      return ApiEndPointUrl.CheckingUsername
    case .SignUp:
      return ApiEndPointUrl.SignUp
    case .ActiveAccount:
      return ApiEndPointUrl.ActiveAccount
    case .SignIn:
      return ApiEndPointUrl.SignIn
    case .SignOut:
      return ApiEndPointUrl.SignOut
    case .SignInWithNoneWallet:
        return ApiEndPointUrl.SignInWithNoneWallet
    case .SignInWithNoneWalletValidatedOTP:
      return ApiEndPointUrl.SignInWithNoneWalletValidatedOTP
    case .WalletInfo :
      return ApiEndPointUrl.GetWalletInfo
    case .PublicKeyeCashRelese :
      return ApiEndPointUrl.GetPublicKeyeCashRelease
    case .PublicKeyOrganizeRelease :
      return ApiEndPointUrl.GetPublicKeyOrganizeRelease
    case .ReSendOTP :
      return ApiEndPointUrl.ReSendOTP
    case .ChangePassword :
      return ApiEndPointUrl.ChangePassword
    case .SyncContact :
      return ApiEndPointUrl.SyncContact
    case .SearchByPhoneNumber :
      return ApiEndPointUrl.SearchByPhoneNumber
    case .DestroyWallet :
      return ApiEndPointUrl.DestroyWallet
    case .SendOTP :
      return ApiEndPointUrl.SendOTP
    case .UpdatedForgotPassword:
       return ApiEndPointUrl.UpdatedForgotPassword
    case .EditProfile:
        return ApiEndPointUrl.EditProfile
    case .AddContact:
        return ApiEndPointUrl.AddContact
    case .DeleteContact:
        return ApiEndPointUrl.DeleteContact
    case .UploadAvatar:
        return ApiEndPointUrl.UploadAvatar
   }
  }
}

enum SyncEndPoint {
    case upload
    case download
}

extension SyncEndPoint : Endpoint {
    var path: String {
        switch self {
        case .download:
            return ApiEndPointUrl.Donwload
        case .upload:
            return ApiEndPointUrl.Upload
    }
    }
}

enum HomeEndPoint {
    case productList
    case eDongToeCashOwner
    case eDongToeCashOwnerAmount
    case eDongToeCashToSomeone
    case eDongToeCashToSomeoneAmount
    case geteDongInfo
    case eCashToeDong
    case VerifyTransaction
    case ExchangeCash
    case getDenomination
}

extension HomeEndPoint: Endpoint {
    var path: String {
        switch self {
        case .productList:
            return ApiEndPointUrl.UserList
        case .eDongToeCashOwner:
            return ApiEndPointUrl.eDongToeCashOwner
        case .geteDongInfo:
            return ApiEndPointUrl.GeteDongInfo
        case .eCashToeDong:
            return ApiEndPointUrl.eCashToeDong
        case .VerifyTransaction:
            return ApiEndPointUrl.VerifyTransaction
        case .eDongToeCashOwnerAmount:
            return ApiEndPointUrl.eDongToeCashOwnerAmount
        case .eDongToeCashToSomeone :
            return ApiEndPointUrl.eDongToeCashToSomeone
        case .eDongToeCashToSomeoneAmount :
            return ApiEndPointUrl.eDongToeCashToSomeoneAmount
        case .ExchangeCash :
            return ApiEndPointUrl.ExchangeCash
        case .getDenomination :
            return ApiEndPointUrl.GetDenomination
        }
        
    }
}
