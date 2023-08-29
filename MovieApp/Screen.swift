//
//  Screen.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

enum Screen {
    
    case splash
    case home(_ movies: [Movie],_ categories: [Category])
    case details(_ movie: MovieViewModel)
    
    var viewController: UIViewController {
        switch self {
        case .splash:
            return SplashViewController.makeFromNib()
        case .home(let movies, let categories):
            return HomeViewController.makeFromNib(allMovies: movies, categories: categories)
        case .details(let movie):
            return MovieDetailsViewController.makeFromNib(movie)
        }
    }
}
