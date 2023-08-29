//
//  Movies.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

class Movie: BaseResponse {
    var errorMsg: String?
    var json: [String : Any] = [:]
    
    var id: Int = 0
    var overview: String = ""
    var posterPath: String = ""
    var releaseDate: String = ""
    var title: String = ""
    var voteAverage: Double = 0
    
    func decode(json: [String : Any]) -> BaseResponse {
        id = json.int(key: "id")
        overview = json.string(key: "overview") ?? ""
        posterPath = json.string(key: "poster_path") ?? ""
        releaseDate = json.string(key: "release_date") ?? ""
        title = json.string(key: "title") ?? ""
        voteAverage = json.double(key: "vote_average")
        return self
    }
}
