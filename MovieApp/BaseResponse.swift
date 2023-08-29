//
//  BaseResponse.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

protocol BaseResponse: AnyObject {
    var json: [String:Any] { get set }
    func decode(json: [String:Any]) -> BaseResponse
    var status: Int { get }
    var errorMsg: String? { get set }
}

extension BaseResponse {
    var status: Int {
        return json.int(key: "status")
    }
    
    var errorMsg: String? {
        return ""
    }
}

class ErrorResponse {
    
    let statusCode: StatusCode
    let msg: String
    
    init(status: Int, json: [String:Any]?) {
        statusCode = StatusCode(status: status)
        msg = json?.string(key: "message") ?? "Unknown Error Code: \(status)"
        Coordinator.shared.showAlert(title: "Some Thing Went Wrong", subtitle: msg)
    }
    
    enum StatusCode {
        case status500
        case status403
        case status404
        case status300
        case unknownStatus
        
        init(status: Int?) {
            guard let status = status else {
                self = .unknownStatus
                return
            }
            
            switch status {
            case 500:
                self = .status500
            case 403:
                self = .status403
            case 404:
                self = .status404
            case 300:
                self = .status300
            default:
                self = .unknownStatus
            }
        }
    }
}
