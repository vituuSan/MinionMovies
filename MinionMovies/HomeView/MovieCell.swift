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
    
    func populate(with textURL: String) {
        if let url = URL(string: textURL) {
            guard let imageData = try? Data(contentsOf: url) else {
                imageView.contentMode = .scaleAspectFit
                return imageView.image = UIImage(named: "file-not-found")
            }
            let image = UIImage(data: imageData)
            imageView.image = image
        } else {
            imageView.image = UIImage(named: textURL)
        }
    }
}
