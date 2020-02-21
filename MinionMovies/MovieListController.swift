//
//  ViewController.swift
//  MinionMovies2
//
//  Created by Vitor Costa on 20/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieListController: UIViewController {

    let moviesImages: [String] = ["jumanji", "reiLeão"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            movieCell.image = UIImage(named: moviesImages[indexPath.row])
            movieCell.setImageSettings()
            
            return movieCell
        } else {
            return MovieCell()
        }
    }
}
