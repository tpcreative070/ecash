//
//  APIClient.swift
//  vietlifetravel
//
//  Created by Mac10 on 6/25/19.
//  Copyright © 2019 Mac10. All rights reserved.
//
import Foundation
enum MessageError {
  case requestFailed
  case jsonConversionFailure
  case invalidData
  case responseUnsuccessful
  case jsonParsingFailure
  case noNeworkConnection
  
  var localizedDescription: String {
    switch self {
    case .requestFailed: return LanguageHelper.getTranslationByKey(LanguageKey.RequestFailed) ?? ""
    case .invalidData: return LanguageHelper.getTranslationByKey(LanguageKey.InvalidData) ?? ""
    case .responseUnsuccessful: return LanguageHelper.getTranslationByKey(LanguageKey.ResponseUnsuccessful) ?? ""
    case .jsonParsingFailure: return "JSON Parsing Failure"
    case .jsonConversionFailure: return "JSON Conversion Failure"
    case .noNeworkConnection: return LanguageHelper.getTranslationByKey(LanguageKey.NoInternetConnection) ?? ""
    }
  }
}

struct APIServiceError: Error {
  var errorDetail: ResponseErrorModel?
  var message: String?
  var code: Int? = 0
}

enum HTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
  case PUT = "PUT"
  case DELETE = "DELETE"
}

enum HTTPStatus: Int {
  case OK = 200
  case OK_CREATED = 201
  case OK_NO_CONTENT = 204
  case UNAUTHENTICATION = 400
  case NOT_FOUND = 404
  case INTERNAL_ERROR = 500
  case UN_AUTHORIZED = 401
}

enum ErrorCode: Int {
  case TIMEOUT = 101
  case NO_NETWORK = 102
}

protocol APIClient {
  var session: URLSession! { get }
  func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIServiceError>) -> Void)
}

extension APIClient {
  
  typealias JSONTaskCompletionHandler = (Decodable?, APIServiceError?) -> Void
  
  /**
  */
  func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
    var errorDetail = APIServiceError(errorDetail: nil, message: "", code: 0)
    let task = session.dataTask(with: request) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else {
        errorDetail.message = MessageError.requestFailed.localizedDescription
        errorDetail.code = ErrorCode.TIMEOUT.rawValue
        completion(nil, errorDetail)
        return
      }
     
      if httpResponse.statusCode == HTTPStatus.OK.rawValue || httpResponse.statusCode == HTTPStatus.OK_CREATED.rawValue || httpResponse.statusCode == HTTPStatus.OK_NO_CONTENT.rawValue {
        
        if httpResponse.statusCode == HTTPStatus.UN_AUTHORIZED.rawValue {
          NotificationCenter.default.post(name: .didRecieveUnauthorized, object: nil)
        }
        NotificationCenter.default.post(name: .didRequestApi, object: nil)
        
        if let data = data, data.count != 0 {
          do {
            let genericModel = try JSONDecoder().decode(decodingType, from: data)
            completion(genericModel, nil)
          } catch(let err) {
            print(err)
            errorDetail.message = MessageError.jsonParsingFailure.localizedDescription
            completion(nil, errorDetail)
          }
        } else {
          completion(nil, nil)
        }
      } else {
        if httpResponse.statusCode == HTTPStatus.INTERNAL_ERROR.rawValue {
            Utils.logMessage(message: "internal server error")
        }
        if let data = data {
          do {
            let errorModel = try JSONDecoder().decode(ResponseErrorModel.self, from: data)
            errorDetail.errorDetail = errorModel
            errorDetail.message = errorModel.message
            completion(nil, errorDetail)
          } catch {
            errorDetail.errorDetail = nil
            errorDetail.message = MessageError.invalidData.localizedDescription
            completion(nil, errorDetail)
          }
        } else {
          errorDetail.errorDetail = nil
          errorDetail.message = MessageError.invalidData.localizedDescription
          completion(nil, errorDetail)
        }
      }
    }
    return task
  }
  
  /**
   This fuction wrapper the request service using the Urlsession to request http
  */
  func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIServiceError>) -> Void) {
    if let data = request.httpBody {
        Utils.logMessage(message: request.url?.absoluteString ?? "")
        Utils.logMessage(message: String(data: data , encoding: .utf8) ?? "")
    }
    if Helper.isConnectedToNetwork() {
      let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
        
        //MARK: change to main queue
        DispatchQueue.main.async {
          guard let json = json else {
            if error == nil {
              completion(Result.success(nil))
            } else {
              completion(Result.failure(error!))
            }
            return
          }
          
          if let value = decode(json) {
            completion(.success(value))
          } else {
            let errorDetail = APIServiceError(errorDetail: nil, message: MessageError.invalidData.localizedDescription, code: 0)
            completion(.failure(errorDetail))
          }
        }
      }
      task.resume()
    } else {
      let errorDetail = APIServiceError(errorDetail: nil, message: MessageError.noNeworkConnection.localizedDescription, code: ErrorCode.NO_NETWORK.rawValue)
      completion(.failure(errorDetail))
    }
  }
}
