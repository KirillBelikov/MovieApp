//
//  SplashViewModel.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation
import Combine
import UIKit

class SplashViewModel {
    
    private var page: Int = 1
    private var allMovies: [Movie] = []
    private var categories: [Category] = []
    
    init() {
        getMovies()
    }
}

private extension SplashViewModel {
    
    func getMovies() {
        RequestManager.shared.sendRequest(.getMovies(page: page)) { [weak self] response, error in
            if let response = response as? MoviesListResponse, error == nil {
                self?.allMovies = response.movies 
                self?.getCategories()
            }
        }
    }
    
    func getCategories() {
        RequestManager.shared.sendRequest(.getCategoryList) { [weak self] response, error in
            if let response = response as? CategoriesResponse, error == nil {
                self?.categories = response.categories
                self?.presentHomeScreen()
            }
        }
    }
    
    func presentHomeScreen() {
        Coordinator.shared.setToRoot(.home(self.allMovies, self.categories))
    }
}
