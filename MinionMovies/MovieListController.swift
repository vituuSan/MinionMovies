//
//  ViewController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieListController: UIViewController {

    let moviesImages: [String] = ["jumanji", "reiLeão"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredStatusBarStyle
    }

}

extension MovieListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            guard let image = UIImage(named: moviesImages[indexPath.row]) else {
                return MovieCell()
            }
            movieCell.populate(with: image)
            
            return movieCell
        }
        return MovieCell()
    }
}
