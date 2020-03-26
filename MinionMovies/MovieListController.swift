//
//  ViewController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit
import RealmSwift

class MovieListController: UIViewController {

    private let session = URLSession.shared
    private let url = URL(string: "http://localhost:8080/response.json")!
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
    private var searching = false
    
    @IBOutlet weak var constraintTopCollectionView: NSLayoutConstraint!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.searchTextField.textColor = .white
        
        let task = session.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                let mime = response?.mimeType, mime == "application/json" else {
                        return
                }
                
                do {
                    if let dataChecked = data {
                        self.movies = try JSONDecoder().decode([Movie].self, from: dataChecked)
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            } else {
                debugPrint(error?.localizedDescription)
            }
            self.reloadCollectionView()
            self.saveMovieInDB()
        }
        task.resume()
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
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func saveMovieInDB() {
        for movie in movies {
            let movieDB = MovieDB()
            
            movieDB.id = movie.id
            movieDB.title = movie.title
            movieDB.year = movie.year
            movieDB.rated = movie.rated
            movieDB.released = movie.released
            movieDB.runtime = movie.runtime
            movieDB.genre = movie.genre
            movieDB.director = movie.director
            movieDB.writer = movie.writer
            movieDB.actors = movie.actors
            movieDB.plot = movie.plot
            movieDB.awards = movie.awards
            movieDB.metascore = movie.metascore
            movieDB.resolutionIs4k = movie.resolutionIs4k
            movieDB.hdr = movie.hdr
            movieDB.trailer = movie.trailer
            movieDB.image = movie.images.first
            
            do {
                let realm = try Realm()
                
                try realm.write {
                    realm.add(movieDB, update: .modified)
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
}

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            if searching {
                movieCell.populate(with: filteredMovies[indexPath.row].poster)
            } else {
                movieCell.populate(with: movies[indexPath.row].poster)
            }
            
            return movieCell
        }
        return MovieCell()
    }
}

extension MovieListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieDetail = storyboard?.instantiateViewController(identifier: "MovieDetailController") as? MovieDetailController else {
            return
        }
        movieDetail.movie = movies[indexPath.row]
        searchBar.endEditing(true)
        self.navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

extension MovieListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = movies.filter({ $0.title.prefix(searchText.count) == searchText })
        searching = true
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
