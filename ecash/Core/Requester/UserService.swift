//
//  UserService.swift
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//

import Foundation
import UIKit

class UserService: APIClient {
  
  let session: URLSession!
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    self.init(configuration: .default)
  }
  
  /**
   - Request api, with endpoint is signin
   */
  func signIn(data: SignInRequestModel, completion: @escaping (Result<SignInResponseModel, APIServiceError>) -> Void) {
    let endpoint = UserEndPoint.SignIn
    var request = endpoint.request
    request.httpMethod = HTTPMethod.POST.rawValue
    let encoder = JSONEncoder()
    let dataEncode = try? encoder.encode(data)
    request.httpBody = dataEncode
    fetch(with: request, decode: { json -> SignInResponseModel? in
      guard let authResult = json as? SignInResponseModel else { return  nil }
      return authResult
    }, completion: completion)
  }
    
  /**
   - Request api, with endpoint is sign up
   */
   func signUp(data: SignUpRequestModel, completion: @escaping (Result<SignUpResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.SignUp
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> SignUpResponseModel? in
            guard let authResult = json as? SignUpResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
  /**
   - Request api, with endpoint is checking idNumber and Phone number
   */
   func checkingIdnumberAndPhoneNumber(data: CheckExistingUserRequestModel, completion: @escaping (Result<CheckExistingUserResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.CheckingIdNumberAndPhoneNumber
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> CheckExistingUserResponseModel? in
            guard let authResult = json as? CheckExistingUserResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is checking username
     */
    func checkingUsername(data: CheckExistingUserRequestModel, completion: @escaping (Result<BaseResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.CheckingUsername
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> BaseResponseModel? in
            guard let authResult = json as? BaseResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is active account
    */
    func activeAccount(data: ActiveAccountRequestModel, completion: @escaping (Result<ActiveAccountResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.ActiveAccount
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> ActiveAccountResponseModel? in
            guard let authResult = json as? ActiveAccountResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
      - Request api, with endpoint is signin with none wallet(Validate otp)
    */
    func signInWithNoneWallet(data: SignInWithNoneWalletRequestModel, completion: @escaping (Result<SignInWithNoneWalletResponseModel, APIServiceError>) -> Void) {
           let endpoint = UserEndPoint.SignInWithNoneWallet
           var request = endpoint.request
           request.httpMethod = HTTPMethod.POST.rawValue
           let encoder = JSONEncoder()
           let dataEncode = try? encoder.encode(data)
           request.httpBody = dataEncode
           fetch(with: request, decode: { json -> SignInWithNoneWalletResponseModel? in
               guard let authResult = json as? SignInWithNoneWalletResponseModel else { return  nil }
               return authResult
           }, completion: completion)
    }
       
    /**
     - Request api, with endpoint is signin with none wallet(Validate otp)
     */
    func signInWithNoneWalletValidatedOTP(data: SignInWithNoneWalletValidatedOTPRequestModel, completion: @escaping (Result<SignInWithNoneWalletValidatedOTPResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.SignInWithNoneWalletValidatedOTP
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> SignInWithNoneWalletValidatedOTPResponseModel? in
            guard let authResult = json as? SignInWithNoneWalletValidatedOTPResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is wallet info
     */
    func getWalletInfo(data: WalletInfoRequestModel, completion: @escaping (Result<WalletInfoResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.WalletInfo
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> WalletInfoResponseModel? in
            guard let authResult = json as? WalletInfoResponseModel else { return  nil }
//            print("================================. Auth Json .================================")
//            dump(data)
//            print("================================")
//            dump(authResult)
//            print("================================. End .================================")
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is public key ecash release
     */
    func getPublicKeyeCashRelease(data: PublicKeueCashReleaseRequestModel, completion: @escaping (Result<PublicKeyeCashReleaseResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.PublicKeyeCashRelese
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> PublicKeyeCashReleaseResponseModel? in
            guard let authResult = json as? PublicKeyeCashReleaseResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is public key organize release
     */
    func getPublicKeyOrganizeRelease(data: PublicKeyOrganizeReleaseRequestModel, completion: @escaping (Result<PublicKeyOrganizeReleaseResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.PublicKeyOrganizeRelease
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> PublicKeyOrganizeReleaseResponseModel? in
            guard let authResult = json as? PublicKeyOrganizeReleaseResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is sign out
     */
    func signOut(data: SignOutRequestModel, completion: @escaping (Result<BaseResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.SignOut
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> BaseResponseModel? in
            guard let authResult = json as? BaseResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is delete account
     */
    func deleteAccount(data: DestroyWalletRequestModel, completion: @escaping (Result<BaseResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.DestroyWallet
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> BaseResponseModel? in
            guard let authResult = json as? BaseResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    
    /**
     - Request api, with endpoint is send otp
     */
    func sendOTP(data: SendOTPRequestModel, completion: @escaping (Result<SendOTPResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.SendOTP
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> SendOTPResponseModel? in
            guard let authResult = json as? SendOTPResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
        - Request api, with endpoint is send otp
    */
    func editProfile(data: EditProfileRequestModel, completion: @escaping (Result<EditProfileResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.EditProfile
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> EditProfileResponseModel? in
            guard let authResult = json as? EditProfileResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
        - Request api, with endpoint is upload avatar
    */
    func uploadAvatar(data: UploadAvatarRequestModel, completion: @escaping (Result<UploadAvatarResponseModel, APIServiceError>) -> Void) {
           let endpoint = UserEndPoint.UploadAvatar
           var request = endpoint.request
           request.httpMethod = HTTPMethod.POST.rawValue
           let encoder = JSONEncoder()
           let dataEncode = try? encoder.encode(data)
           request.httpBody = dataEncode
           fetch(with: request, decode: { json -> UploadAvatarResponseModel? in
               guard let authResult = json as? UploadAvatarResponseModel else { return  nil }
               return authResult
           }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is send otp
     */
    func updatedForgotPassword(data: UpdatedForgotPasswordRequestModel, completion: @escaping (Result<UpdatedForgotPasswordResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.UpdatedForgotPassword
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> UpdatedForgotPasswordResponseModel? in
            guard let authResult = json as? UpdatedForgotPasswordResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    
    
    /**
     - Request api, with endpoint is resend otp
     */
    func resendOTP(data: ReSendOTPRequestModel, completion: @escaping (Result<ReSendOTPResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.ReSendOTP
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> ReSendOTPResponseModel? in
            guard let authResult = json as? ReSendOTPResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    
    
    /**
     - Request api, with endpoint is change password
     */
    func changePassword(data: ChangePasswordRequestModel, completion: @escaping (Result<ChangePasswordResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.ChangePassword
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> ChangePasswordResponseModel? in
            guard let authResult = json as? ChangePasswordResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is sync contact
     */
    func syncContact(data: SyncContactRequestModel, completion: @escaping (Result<BaseResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.SyncContact
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> BaseResponseModel? in
            guard let authResult = json as? BaseResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
        - Request api, with endpoint is add contact
    */
    func addContact(data: AddContactRequestModel, completion: @escaping (Result<BaseResponseModel, APIServiceError>) -> Void) {
           let endpoint = UserEndPoint.AddContact
           var request = endpoint.request
           request.httpMethod = HTTPMethod.POST.rawValue
           let encoder = JSONEncoder()
           let dataEncode = try? encoder.encode(data)
           request.httpBody = dataEncode
           fetch(with: request, decode: { json -> BaseResponseModel? in
               guard let authResult = json as? BaseResponseModel else { return  nil }
               return authResult
           }, completion: completion)
    }
    
    /**
        - Request api, with endpoint is delete contact
    */
    func deleteContact(data: DeleteContactRequestModel, completion: @escaping (Result<BaseResponseModel, APIServiceError>) -> Void) {
           let endpoint = UserEndPoint.DeleteContact
           var request = endpoint.request
           request.httpMethod = HTTPMethod.POST.rawValue
           let encoder = JSONEncoder()
           let dataEncode = try? encoder.encode(data)
           request.httpBody = dataEncode
           fetch(with: request, decode: { json -> BaseResponseModel? in
               guard let authResult = json as? BaseResponseModel else { return  nil }
               return authResult
           }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is search by phone number
    */
    func searchByPhoneNumber(data: SearchByPhoneRequestModel, completion: @escaping (Result<SearchByPhoneResponseModel, APIServiceError>) -> Void) {
        let endpoint = UserEndPoint.SearchByPhoneNumber
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> SearchByPhoneResponseModel? in
            guard let authResult = json as? SearchByPhoneResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
}
