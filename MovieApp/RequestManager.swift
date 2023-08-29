//
//  RequestManager.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation
import Alamofire
import SystemConfiguration
class RequestManager {
    
    static let shared = RequestManager()
    private init() {}
    
    private let baseURL = "https://api.themoviedb.org/3/"
    
    func sendRequest(_ request: Request, showErrPopup: Bool = true, completion: @escaping (_ response: BaseResponse?, _ error:  ErrorResponse?) -> Void) {
        let urlStr = baseURL + request.endpoint
        po("🤖☝️ REQUEST URL", data: urlStr)
        let afRequest : DataRequest = AF.request(urlStr,
                                                 method: request.method,
                                                 encoding: JSONEncoding.default).validate()
        afRequest.responseData { response in
            let status = response.response?.statusCode ?? -1
            switch response.result {
            case .success(let data):
                do {
                    let decoded = try JSONSerialization.jsonObject(with: data, options: [])
                    guard var dict = decoded as? [String:Any] else {
                        if showErrPopup {
                            self.handleServerError(string: "Unable to parse response")
                        }
                        completion(nil,nil)
                        return
                    }
                    let baseResponse = request.response.decode(json: dict)
                    dict["status"] = status
                    baseResponse.json = dict
                    baseResponse.errorMsg = dict.string(key: "errorMessage")
                    if let errorMsg = baseResponse.errorMsg, showErrPopup {
                        self.handleServerError(string: errorMsg)
                    }
                    po("🤖✅ REQUEST RESPONSE STATUS: \(status)", data: dict)
                    completion(baseResponse,nil)
                }
                catch let error {
                    if showErrPopup {
                        self.handleServerError(string: error.localizedDescription)
                    }
                    po("🤖❌ url:\(urlStr)\nREQUEST SUCCESS DECODING ERROR STATUS: \(status)", data: error.localizedDescription)
                    completion(nil, nil)
                }
            case .failure(let error):
                if showErrPopup {
                    self.handleServerError(string: error.localizedDescription)
                }
                do {
                    guard let responseData = response.data, let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String:Any] else {
                        po("🤖❌ url:\(urlStr)\nREQUEST ERROR NO DATA STATUS: \(status)", data: error.localizedDescription)
                        let statusCode = ErrorResponse(status: status,json: ["message":error.localizedDescription])
                        completion(nil,statusCode)
                        return
                    }
                    po("🤖❌ url:\(urlStr)\nREQUEST ERROR WITH DATA STATUS: \(status)", data: error.localizedDescription)
                    let response = request.response.decode(json: dict)
                    response.json = dict
                    let statusCode = ErrorResponse(status: status, json: dict)
                    completion(response,statusCode)
                }
                catch {
                    let statusCode = ErrorResponse(status: status, json: ["message":error.localizedDescription])
                    completion(nil,statusCode)
                    po("🤖❌ url:\(urlStr)\nREQUEST DECODING ERROR STATUS: \(status)", data: error.localizedDescription)
                }
            }
        }
    }
    
    private func handleServerError(string: String?) {
        po("ERROR", data: string ?? "")
        Coordinator.shared.showAlert(title: "Error", subtitle: string ?? "")
    }
    
    func downloadImage(_ endPoint: String, completion: @escaping (Data?) -> ()) {
        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        let url = baseImageUrl + endPoint
        
        AF.request(url).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}

public func po(_ msg: String, data: Any) {
    print("qwe qwe \(msg): \(data)")
}
