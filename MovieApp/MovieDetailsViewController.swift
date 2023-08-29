//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController, URLSessionDelegate {
    
    //MARK: - Properties
    private var viewModel: MovieDetailsViewModel
    
    @IBOutlet weak private var movieImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var releaseDateLabel: UILabel!
    @IBOutlet weak private var voteLabel: UILabel!
    @IBOutlet weak private var overviewLabel: UILabel!
    @IBOutlet weak private var favoriteButton: UIButton!
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: MovieDetailsViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Coordinator.shared.showAlert(title: "Error", subtitle: "init(coder:) has not been implemented")
        viewModel = MovieDetailsViewModel(movie: MovieViewModel(Movie()))
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieImage.image = viewModel.uiImage
        self.nameLabel.text = viewModel.name
        self.overviewLabel.text = viewModel.overview
        self.voteLabel.text = viewModel.voteAverage
        self.releaseDateLabel.text = viewModel.releaseDate
        
        let favoriteEmptyImageName =  UIImage(systemName: viewModel.iconName)
        self.favoriteButton.setImage(favoriteEmptyImageName, for: .normal)
    }
    
    
    //MARK: - Nib View
    static func makeFromNib(_ movie: MovieViewModel) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        return viewController
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        viewModel.favoriteTapped {
            let favoriteEmptyImageName =  UIImage(systemName: viewModel.iconName)
            self.favoriteButton.setImage(favoriteEmptyImageName, for: .normal)
        }
        
    }
}

