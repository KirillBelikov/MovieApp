//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class MovieDetailsViewModel {
    
    private(set) var name: String
    private(set) var overview: String
    private(set) var releaseDate: String
    private(set) var voteAverage: String
    private(set) var uiImage: UIImage?
    private var movieId: Int
    var iconName: String {
        return isFavoriteMovieId(for: movieId) ? "heart.fill" : "heart"
    }
    
    init(movie: MovieViewModel) {
        name = movie.title
        overview = movie.overview
        releaseDate = "Release Date:\n\(movie.releaseDate)"
        voteAverage = "Vote Average:\n\(movie.voteAverage)"
        uiImage = movie.posterUiImage
        movieId = movie.id
    }
    
    func favoriteTapped(_ completion: () -> Void) {
        var array: [Int] = Defaults.shared.favoritesMoviesIds
        if array.contains(where: {$0 == movieId}) {
            array.removeAll(where: { $0 == movieId})
        }
        else {
            array.append(movieId)
        }
        Defaults.shared.favoritesMoviesIds = array
        completion()
    }
}

private extension MovieDetailsViewModel {
    func isFavoriteMovieId(for id: Int) -> Bool {
        for storedId in Defaults.shared.favoritesMoviesIds {
            if storedId == id {
                return true
            }
        }
        return false
    }
}
