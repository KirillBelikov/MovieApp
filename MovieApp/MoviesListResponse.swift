//
//  MoviesListResponse.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

class MoviesListResponse: BaseResponse {
    
    var errorMsg: String?
    var json: [String : Any] = [:]
    var status: Int = 0
    
    var totalPages: Int = 0
    var movies: [Movie] = []
    
    func decode(json: [String : Any]) -> BaseResponse {
        totalPages = json.int(key: "total_pages")
        movies = []
         let results = json.array(key: "results") as? [[String:Any]] ?? []
        for movie in results {
            if let movie = Movie().decode(json: movie) as? Movie {
                movies.append(movie)
            }
        }
        
        let favoriteMovies = movies.filter { isFavoriteMovieId(for: $0.id) }
        var notFavoriteMovies = movies.filter { !isFavoriteMovieId(for: $0.id) }
        notFavoriteMovies.sort(by: {$0.voteAverage < $1.voteAverage})
        movies = favoriteMovies + notFavoriteMovies
        
        return self
    }
    
    private func isFavoriteMovieId(for id: Int) -> Bool {
        for storedId in Defaults.shared.favoritesMoviesIds {
            if storedId == id {
                return true
            }
        }
        return false
    }
}

