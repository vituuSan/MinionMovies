//
//  MovieCell.swift
//  MinionMovies2
//
//  Created by Vitor Costa on 20/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    
    func setImageSettings() {
        guard let imageChecked = image else {
            return
        }
        imageView.image = imageChecked
        imageView.layer.cornerRadius = 8
    }
}
