//
//  MovieCellCollectionViewCell.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setImageSettings() {
        imageView.layer.cornerRadius = 6
    }
    
    func populate(with image: UIImage) {
        imageView.image = image
        setImageSettings()
    }
}
