//
//  MovieDetailsResponse.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

class MovieDetailsResponse: BaseResponse {
    var json: [String : Any] = [:]
    var status: Int = -1
    var errorMsg: String?
    
    func decode(json: [String : Any]) -> BaseResponse {

        return self
    }
}

