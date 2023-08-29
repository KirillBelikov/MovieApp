//
//  CategoriesResponse.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

class CategoriesResponse: BaseResponse {
    var json: [String : Any] = [:]
    var status: Int = -1
    var errorMsg: String?
    
    var categories: [Category] = []
    
    func decode(json: [String : Any]) -> BaseResponse {
        categories = []
        let genresArray = json.array(key: "genres") as? [[String:Any]] ?? []
        for genre in genresArray {
            if let genre = Category().decode(json: genre) as? Category {
                categories.append(genre)
            }
        }
        categories.sort(by: { $0.name < $1.name })
        
        return self
    }
}
