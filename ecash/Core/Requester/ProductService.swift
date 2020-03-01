//
//  HomeService.swift
//  ecash
//
//  Created by phong070 on 8/1/19.
//  Copyright © 2019 thanhphong070. All rights reserved.
//

import Foundation
class ProductService: APIClient {
    
    let session: URLSession!
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    /**
     - Request api, with endpoint is product list
     */
    func productList(completion: @escaping (Result<HomeReponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.productList
        let path = endpoint.path
        var urlComponents: URLComponents {
            var components = URLComponents(string: endpoint.base)!
            components.path = path
            components.queryItems  = [
            URLQueryItem(name: "page", value: "2")]
            return components
        }
        var request = endpoint.request
        request.url = urlComponents.url
        request.httpMethod = HTTPMethod.GET.rawValue
        print(request)
        fetch(with: request, decode: { json -> HomeReponseModel? in
            guard let authResult = json as? HomeReponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is eDong to eCash
     */
    func eDongToeCash(data: eDongToeCashRequestModel,completion: @escaping (Result<eDongToeCashResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.eDongToeCashOwner
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> eDongToeCashResponseModel? in
            guard let authResult = json as? eDongToeCashResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is eDong to eCash owner amount
     */
    func eDongToeCashOwnerAmount(data: eDongToeCashOwnerAmountRequestModel,completion: @escaping (Result<eDongToeCashOwnerAmountResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.eDongToeCashOwnerAmount
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> eDongToeCashOwnerAmountResponseModel? in
            guard let authResult = json as? eDongToeCashOwnerAmountResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is eDong to eCash to someon
     */
    func eDongToeCashToSomeone(data: eDongToeCashRequestModel,completion: @escaping (Result<eDongToeCashResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.eDongToeCashToSomeone
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> eDongToeCashResponseModel? in
            guard let authResult = json as? eDongToeCashResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is eDong to eCash to someone amount
     */
    func eDongToeCashToSoneoneAmount(data: eDongToeCashOwnerAmountRequestModel,completion: @escaping (Result<eDongToeCashOwnerAmountResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.eDongToeCashToSomeoneAmount
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> eDongToeCashOwnerAmountResponseModel? in
            guard let authResult = json as? eDongToeCashOwnerAmountResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is eCash to eDong
     */
    func eCashToeDong(data: eCashToeDongRequestModel,completion: @escaping (Result<eCashToeDongResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.eCashToeDong
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> eCashToeDongResponseModel? in
            guard let authResult = json as? eCashToeDongResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is get edong info
    */
    func geteDongInfo(data: eDongInfoRequestModel,completion: @escaping (Result<eDongInfoResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.geteDongInfo
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> eDongInfoResponseModel? in
            guard let authResult = json as? eDongInfoResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is verify transaction
     */
    func getVerifyTransaction(data: VerifyTransactionRequestModel,completion: @escaping (Result<VerifyTransactionResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.VerifyTransaction
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> VerifyTransactionResponseModel? in
            guard let authResult = json as? VerifyTransactionResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
     - Request api, with endpoint is exchange cash
    */
    func exchangeCash(data : ExchangeCashRequestModel,completion: @escaping (Result<ExchangeCashResponseModel, APIServiceError>) -> Void) {
        let endpoint = HomeEndPoint.ExchangeCash
        var request = endpoint.request
        request.httpMethod = HTTPMethod.POST.rawValue
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(data)
        request.httpBody = dataEncode
        fetch(with: request, decode: { json -> ExchangeCashResponseModel? in
            guard let authResult = json as? ExchangeCashResponseModel else { return  nil }
            return authResult
        }, completion: completion)
    }
    
    /**
       - Request api, with endpoint is denomination
    */
    func getDenomination(data : DenominationRequestModel,completion: @escaping (Result<DenominationResponseModel, APIServiceError>) -> Void) {
           let endpoint = HomeEndPoint.getDenomination
           var request = endpoint.request
           request.httpMethod = HTTPMethod.POST.rawValue
           let encoder = JSONEncoder()
           let dataEncode = try? encoder.encode(data)
           request.httpBody = dataEncode
           fetch(with: request, decode: { json -> DenominationResponseModel? in
               guard let authResult = json as? DenominationResponseModel else { return  nil }
               return authResult
           }, completion: completion)
    }
}
