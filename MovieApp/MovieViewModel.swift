//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class MovieViewModel {
    var id: Int
    var overview: String
    var posterPath: String
    var releaseDate: String
    var title: String
    var voteAverage: Double
    var posterUiImage: UIImage?
    var iconName: String {
        return isFavoriteMovieId(for: id) ? "heart.fill" : ""
    }
    
    init(_ movie: Movie) {
        
        id = movie.id
        overview = movie.overview
        posterPath = movie.posterPath
        releaseDate = movie.releaseDate
        title = movie.title
        voteAverage = movie.voteAverage
        downloadImage()
    }
    
    func downloadImage(_ completion: (() -> Void)? = nil) {
        RequestManager.shared.downloadImage(posterPath) { data in
            if let data = data,
               !data.isEmpty {
                self.posterUiImage = UIImage(data: data)
                completion?()
            }
            else {
                self.downloadImage()
            }
        }
    }
}

private extension MovieViewModel {
    func isFavoriteMovieId(for id: Int) -> Bool {
        for storedId in Defaults.shared.favoritesMoviesIds {
            if storedId == id {
                return true
            }
        }
        return false
    }
}
