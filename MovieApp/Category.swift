//
//  Category.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

class Category: BaseResponse {
    var json: [String : Any] = [:]
    var status: Int = -1
    var errorMsg: String?
    
    var id: Int = 0
    var name: String = ""
    
    func decode(json: [String : Any]) -> BaseResponse {
        id = json.int(key: "id")
        name = json.string(key: "name") ?? ""
        return self
    }
}
