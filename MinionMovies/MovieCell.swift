//
//  MovieCellCollectionViewCell.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        self.layoutIfNeeded()
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }
    
    func populate(with image: UIImage) {
        imageView.image = image
    }
}
