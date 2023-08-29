//
//  Request.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation
import Alamofire

enum Request {
    
    case getMovies(page: Int)
    case getCategoryList
    case getMoviesByCategory(id: Int, page: Int)
    case getMovieDetails(id: Int)
    
    private var apiKey: String {
        return "d2bc56bb74d10fcca04542127ebda98c"
    }
    
    var endpoint: String {
        
        switch self {
        case .getMovies(let page):
            return "discover/movie?api_key=\(apiKey)&sort_by=popularity.desc&page=\(page)"
            
        case .getCategoryList:
            return "genre/movie/list?api_key=\(apiKey)"
            
        case .getMoviesByCategory(id: let id, page: let page):
            return "discover/movie?api_key=\(apiKey)&with_genres=\(id)&page=\(page)"
            
        case .getMovieDetails(id: let id):
            return "movie/\(id)?api_key=\(apiKey)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies,
                .getCategoryList,
                .getMoviesByCategory,
                .getMovieDetails:
            return .get
        }
    }
    
    var response: BaseResponse {
        switch self {
        case .getMovies:
            return MoviesListResponse()
        case .getCategoryList:
            return CategoriesResponse()
        case .getMoviesByCategory:
            return MoviesByCategoryResponse()
        case .getMovieDetails:
            return MovieDetailsResponse()
        }
    }
}
