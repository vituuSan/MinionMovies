//
//  HomeViewCell.swift
//  MinionMovies
//
//  Created by Vitor Costa on 09/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelRelease: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    @IBOutlet weak var labelVoteCount: UILabel!
    @IBOutlet weak var backView: UIView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backView.backgroundColor = .clear
        backView.layer.masksToBounds = false
        backView.layer.shadowOpacity = 0.23
        backView.layer.shadowRadius = 4
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowColor = UIColor.black.cgColor

        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        backgroundColor = .clear
        backView.clipsToBounds = true
    }
    
    func setup(movie: Movie) {
        MinionMoviesService.fetchImage(path: movie.poster ?? "") { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.poster.image = image
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.poster.image = UIImage()
                }
            }
        }
        
        self.labelTitle.text = movie.title
        self.labelRelease.text = movie.release
        self.labelAverage.text = "\(movie.average ?? 0)"
        self.labelVoteCount.text = "(\(movie.voteCount ?? 0))"
    }
}
