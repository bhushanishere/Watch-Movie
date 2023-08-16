//
//  RestClient.swift
//  Watch-Movie
//
//  Created by Bhushan  Borse on 15/07/23.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import Foundation

enum RequestType : String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

/// If you have base url so please add here and append endpoint url after that.ß
let SERVER_URL  : String = ""

public class RestClient: NSObject {
    
    /// If you have base url so please add here and append endpoint url after that.ß
    let netManager = NetworkReachabilityManager(host: "Host_name")
    
    func callApi(api :String, completion: @escaping (Result<JSON, ErrorResult>) -> Void, type:RequestType, data:Any? = nil , isAbsoluteURL:Bool = false , headers : Any? = nil, isSilent : Bool = false, jsonSerialize : Bool? = true) {
        
        if !(netManager?.isReachable)!{
            /// Show offline message
            completion(.failure(.custom(string: RestClientMessages.kOfflineMsg)))
            SVProgressHUD.showInfo(withStatus: RestClientMessages.kOfflineMsg)
            print("Offline")
            return
        }
        
        /// If call api with showing loader
        if !isSilent {
            /// Show loader here...
        }
        
        var urlToHit = ""
        
        /// Here we check url is complete or not otherwise add base url...
        if isAbsoluteURL {
            urlToHit = api
        } else {
            urlToHit = kBaseURL + api + kAPIKey
        }
                
        /// Check url is not empty.
        guard let url = URL(string:urlToHit) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        if headers != nil {
            var temp = headers as! [String : String]
            temp["Authorization"] = kAccessToken
            temp["Content-Type"] = "application/json"
            request.allHTTPHeaderFields = temp
        }
        
        /// Add parameter to httpBody
        if data != nil && (jsonSerialize ?? true) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: data! , options: [])
        } else if data != nil {
            request.httpBody = data as? Data
        }
        /// Call URL
        AF.request(request as URLRequestConvertible).responseJSON() { response in
            if !isSilent {
                /// Show loader here...
            }
            
            switch response.result {
            case .success(let value):
                completion(.success(JSON(value)))
            case .failure(let error):
                let customError = passErrorCode(andReturn: error as NSError)
                completion(.failure(.custom(string: "An error occured during request : \(customError.localizedDescription)")))
                
            }
        }
    }
}


enum RegistrationError: Error {
    case noContentError             // 204
    case badRequestError            // 400
    case unauthorizedError          // 401
    case paymentRequiredError       // 402
    case forbiddenError             // 403
    case notFoundError              // 404
    case internalServerError        // 500
    case badGatewayError            // 502
    case serviceUnavailableError    // 503
    case gatewayTimeoutError        // 504
    case unsuppotedURLError         // -1003
    case unknownError
}

/// Get the error object and filter by error code and return the error message
func passErrorCode(andReturn error : NSError) -> Error {
    let errorCode = error.code
    switch errorCode {
    case 204:
        return RegistrationError.noContentError
    case 400:
        return RegistrationError.badRequestError
    case 401:
        return RegistrationError.unauthorizedError
    case 402:
        return RegistrationError.paymentRequiredError
    case 403:
        return RegistrationError.forbiddenError
    case 404:
        return RegistrationError.notFoundError
    case 500:
        return RegistrationError.internalServerError
    case 502:
        return RegistrationError.badGatewayError
    case 503:
        return RegistrationError.serviceUnavailableError
    case 504:
        return RegistrationError.gatewayTimeoutError
    case -1003:
        return RegistrationError.unsuppotedURLError
    default:
        return RegistrationError.unknownError
    }
}

/// Set the error message as per error type...sssss
extension RegistrationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noContentError:
            return NSLocalizedString("The server successfully processed the request and is not returning any content.", comment: "No Content")
        case .badRequestError:
            return NSLocalizedString("The server cannot or will not process the request due to an apparent client error.", comment: "Bad Request")
        case .unauthorizedError:
            return NSLocalizedString("Description of unauthorized", comment: "Unauthorized")
        case .paymentRequiredError:
            return NSLocalizedString("Description of payment required", comment: "Payment Required")
        case .forbiddenError:
            return NSLocalizedString("Description of forbidden", comment: "Forbidden")
        case .notFoundError:
            return NSLocalizedString("Description of Not found", comment: "Not Found")
        case .internalServerError:
            return NSLocalizedString("Description of internal server", comment: "Internal Server")
        case .badGatewayError:
            return NSLocalizedString("Description of bad gateway", comment: "Bad Gateway")
        case .serviceUnavailableError:
            return NSLocalizedString("Description of service unavailable", comment: "Service Unavailable")
        case .gatewayTimeoutError:
            return NSLocalizedString("Description of gateway timeout", comment: "Gateway Timeout")
        case .unsuppotedURLError:
            return NSLocalizedString("Description of unsuppoted URL", comment: "Unsuppoted URL")
        case .unknownError:
            return NSLocalizedString("Description of unknown error", comment: "Unknown Error")
        }
    }
    
    /// Here how you use this...
    /*
     let error: Error = RegistrationError.invalidEmail
     print(error.localizedDescription)
     */
}

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: self)
    }
}


class RestClientMessages : NSObject {
    static let kErrorDomain = "com.Domain.name"
    static let kOfflineMsg = "Offline, please check your connection"
    static let noAuth = "Session Expired. Please login again!"
    static let kMsgString = "message"
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
