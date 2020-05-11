//
//  ViewController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit
import RealmSwift

protocol ViewProtocol {
    var interactor: InteractorProtocol? { get }
    var movies: [HomeViewModel]? { get set }
    var filteredMovies: [HomeViewModel]? { get set }
}

class HomeViewController: UIViewController, ViewProtocol {
    @IBOutlet private weak var constraintTopCollectionView: NSLayoutConstraint!
    @IBOutlet private weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    private var searching = false
    var interactor: InteractorProtocol?
    var movies: [HomeViewModel]? = [HomeViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var filteredMovies: [HomeViewModel]? = [HomeViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: Initializers
    init(configurator: HomeViewConfigurator = HomeViewConfigurator.sharedInstance) {
        super.init(nibName: nil, bundle: nil)
        
        configure(configurator: configurator)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure(configurator: HomeViewConfigurator.sharedInstance)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.searchTextField.textColor = .white
        
        interactor?.theScreenIsLoading()
    }
    
    @IBAction func showSearchBar(_ sender: Any) {
        if searchBar.isHidden {
            searchBar.isHidden = false
            constraintTopCollectionView.constant = 0
            view.layoutIfNeeded()
        } else if searchBar.isHidden == false {
            searchBar.isHidden = true
            constraintTopCollectionView.constant = -56
            view.layoutIfNeeded()
        }
    }
    
    private func configure(configurator: HomeViewConfigurator = HomeViewConfigurator.sharedInstance) {
        configurator.configure(viewController: self)
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredMovies?.count ?? 0
        } else {
            return movies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            if searching {
                movieCell.populate(with: filteredMovies?[indexPath.row].poster ?? "")
            } else {
                movieCell.populate(with: movies?[indexPath.row].poster ?? "")
            }
            
            return movieCell
        }
        return MovieCell()
    }
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetail = storyboard?.instantiateViewController(identifier: "MovieDetailController") as? MovieDetailController else { return }
//        movieDetail.movie = movies[indexPath.row]
        searchBar.endEditing(true)
        
        self.navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

// MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.searching(string: searchText)
        
        searching = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
