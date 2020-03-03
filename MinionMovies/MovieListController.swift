//
//  ViewController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieListController: UIViewController {

    private let moviesImages: [String] = ["jumanji", "reiLeão"]
    private let session = URLSession.shared
    private let url = URL(string: "http://localhost:8080/response.json")!
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        task.resume()
    }
}

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            guard let image = UIImage(contentsOfFile: movies[indexPath.row].images.first!) else {
                return MovieCell()
            }
            movieCell.populate(with: image)
            
            return movieCell
        }
        return MovieCell()
    }
}
