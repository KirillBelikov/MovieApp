//
//  Defaults.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import Foundation

class Defaults {
    
    private let ud = UserDefaults.standard
    static let shared = Defaults()
    private init() { }
    
    enum Key: String {
        case favoriteMovieId
    }
    
    var favoritesMoviesIds: [Int] {
        set {
            ud.set(newValue, forKey: Key.favoriteMovieId.rawValue)
        }
        get {
            ud.object(forKey: Key.favoriteMovieId.rawValue) as? [Int] ?? []
        }
    }
}
