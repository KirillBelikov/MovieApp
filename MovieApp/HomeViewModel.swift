//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation
import UIKit

class HomeViewModel {
    
    private var allMoviesPage: Int = 1
    private var categoryPage: Int = 1
    private var totalPages: Int = 2
    private var allMovies: [MovieViewModel] = []
    private(set) var presentedMovies: [MovieViewModel] = []
    private(set) var categories: [Category] = []
    private var selectedCategoryId: Int?
    
    
    init(allMovies: [Movie], categories: [Category]) {
        self.allMovies = allMovies.map {
            MovieViewModel($0)
        }
        self.presentedMovies = self.allMovies
        self.categories = categories
    }
    
    func getMovies(_ completion: @escaping () -> Void) {
        if allMoviesPage <= totalPages {
            self.allMoviesPage += 1
            RequestManager.shared.sendRequest(.getMovies(page: allMoviesPage)) { [weak self] response, error in
                guard let self = self, error == nil else {
                    return completion()
                }
                if let response = response as? MoviesListResponse {
                    self.allMovies.append(contentsOf: response.movies.map({ MovieViewModel($0)}))
                    self.presentedMovies = self.allMovies
                    self.totalPages = response.totalPages
                    completion()
                }
                else {
                    failAlert()
                    completion()
                }
            }
        }
        else {
            noMoreMovies()
            completion()
        }
    }
    
    func categoryTapped(_ index: Int,_ completion: @escaping () -> Void) {
        let category = categories[index]
        
        if category.id == selectedCategoryId {
            self.presentedMovies = self.allMovies
            self.categoryPage = 0
            self.selectedCategoryId = nil
            completion()
        }
        else {
            if selectedCategoryId != category.id {
                categoryPage = 0
                presentedMovies.removeAll()
            }
            getMoviesByCategory(for: category.id, completion)
        }
    }
    
    func pushToDetails(of movie: MovieViewModel) {
        Coordinator.shared.push(to: .details(movie))
    }
    
    func isSelected(_ category: Category) -> Bool {
        return category.id == selectedCategoryId
    }
}

private extension HomeViewModel {
    
    func getMoviesByCategory(for categoryId: Int,_ completion: @escaping () -> Void) {
        selectedCategoryId = categoryId
        if allMoviesPage <= totalPages {
            self.categoryPage += 1
            RequestManager.shared.sendRequest(.getMoviesByCategory(id: categoryId, page: self.categoryPage)) { [weak self] response, error in
                if let response = response as? MoviesByCategoryResponse, error == nil {
                    self?.presentedMovies.append(contentsOf: response.movies.map({ MovieViewModel($0)}))
                    completion()
                }
                else{
                    self?.failAlert()
                    completion()
                }
            }
        }
        else {
            noMoreMovies()
            completion()
        }
    }
    
    func noMoreMovies() {
        Coordinator.shared.showAlert(title: "No More Movies", subtitle: "We Present You All The Movies By Your Request, Change Category")
    }
    
    func failAlert() {
        Coordinator.shared.showAlert(title: "Some Thing Went Wrong", subtitle: "Request Failed")
    }
}
