//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var heartImage: UIImageView!
    @IBOutlet weak private var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: MovieViewModel) {
        if viewModel.posterUiImage == nil {
            viewModel.downloadImage {
                self.movieImage.image = viewModel.posterUiImage
            }
        }
        else {
            movieImage.image = viewModel.posterUiImage
        }
        heartImage.image = UIImage(systemName: viewModel.iconName)
        nameLabel.text = viewModel.title
    }
}
