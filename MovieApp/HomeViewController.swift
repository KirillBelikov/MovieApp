//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Kirill Belikov on 28.08.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    private var viewModel: HomeViewModel
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: HomeViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Coordinator.shared.showAlert(title: "Error", subtitle: "init(coder:) has not been implemented")
        viewModel = HomeViewModel(allMovies: [], categories: [])
        super.init(coder: coder)
    }
    
    static func makeFromNib(allMovies: [Movie], categories: [Category]) -> HomeViewController {
        let viewModel = HomeViewModel(allMovies: allMovies, categories: categories)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Movies"
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerXib(xibName: FilterOptionCell.className)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerXib(xibName: MovieTableViewCell.className)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

//MARK: TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.presentedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.className) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(viewModel: viewModel.presentedMovies[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.presentedMovies[indexPath.row]
        viewModel.pushToDetails(of: movie)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last,
           lastVisibleIndexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            viewModel.getMovies {
                self.tableView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = viewModel.categories[indexPath.row].name
        let font = UIFont.systemFont(ofSize: 14)
        let textSize = (name as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
        return CGSize(width: textSize.width + 8, height: collectionView.bounds.height)
    }
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterOptionCell.className, for: indexPath) as? FilterOptionCell else {
            return UICollectionViewCell()
        }
        let category = viewModel.categories[indexPath.row]
        cell.configure(with: category, selected: viewModel.isSelected(category))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.categoryTapped(indexPath.row) { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}
