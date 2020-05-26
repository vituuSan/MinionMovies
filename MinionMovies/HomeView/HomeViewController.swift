//
//  ViewController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit
import RealmSwift

protocol HomeViewProtocol {
    var interactor: HomeViewInteractorProtocol? { get }
    var movies: [HomeViewModel]? { get set }
}

class HomeViewController: UIViewController, HomeViewProtocol {
    @IBOutlet private weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var interactor: HomeViewInteractorProtocol?
    var movies: [HomeViewModel]? = [HomeViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.searchTextField.textColor = .white
        interactor?.theScreenIsLoading()
    }
    
    @IBAction func showSearchBar(_ sender: Any) {
        if searchBar.isHidden {
            searchBar.isHidden = false
            collectionViewTopConstraint.constant = 0
            view.layoutIfNeeded()
        } else if searchBar.isHidden == false {
            searchBar.isHidden = true
            collectionViewTopConstraint.constant = -56
            view.layoutIfNeeded()
        }
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? HomeViewCell else { return HomeViewCell() }
        
        movieCell.populate(with: movies?[indexPath.row].poster ?? "")
        return movieCell
        
    }
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetail = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return }
        movieDetail.id = movies![indexPath.row].id
        let presenter = DetailsViewPresenter(view: movieDetail)
        let dataProvider = DetailsViewDataProvider(config: .basic)
        let worker = DetailsViewWorker(dataProvider: dataProvider)
        movieDetail.interactor = DetailsViewInteractor(presenter: presenter, worker: worker)
        
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
