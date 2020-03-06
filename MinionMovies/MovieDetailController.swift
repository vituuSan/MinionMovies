//
//  MovieDetailController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 04/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {

    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var posterMovie: UIImageView!
    @IBOutlet private weak var nameMovie: UILabel!
    @IBOutlet private weak var evaluation: UILabel!
    @IBOutlet private weak var yearAndDuration: UILabel!
    @IBOutlet private weak var resolution: UILabel!
    @IBOutlet private weak var plot: UITextView!
    @IBOutlet private weak var star1: UIImageView!
    @IBOutlet private weak var star2: UIImageView!
    @IBOutlet private weak var star3: UIImageView!
    @IBOutlet private weak var star4: UIImageView!
    @IBOutlet private weak var star5: UIImageView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createScreen()
    }
    
    func createScreen() {
        guard let checkedMovie = self.movie else { return }
        createBackground(with: checkedMovie.images)
        createPoster(with: checkedMovie.poster)
        
        nameMovie.text = checkedMovie.title
        createEvaluation(with: checkedMovie.metascore)
        evaluation.text = "(\(checkedMovie.metascore))"
        yearAndDuration.text = "\(checkedMovie.year)  \(checkedMovie.runtime)"
        
        if checkedMovie.resolutionIs4k {
            if checkedMovie.hdr {
                resolution.text = "4k  HDR"
            } else {
                resolution.text = "4k"
            }
        } else if checkedMovie.hdr {
            resolution.text = "HDR"
        } else {
            resolution.text = ""
        }
        
        plot.text = checkedMovie.plot
    }
    
    func createBackground(with urlsOfImages: [String]) {
        if let checkedUrl = URL(string: urlsOfImages[0]) {
            guard let data = try? Data(contentsOf: checkedUrl) else { return }
            backgroundImage.image = UIImage(data: data)
        }
    }
    
    func createPoster(with urlOfPoster: String) {
        if let checkedUrl = URL(string: urlOfPoster) {
            guard let data = try? Data(contentsOf: checkedUrl) else { return }
            posterMovie.image = UIImage(data: data)
        }
    }
    
    func createEvaluation(with metascore: String) {
        guard let number = Int(metascore) else { return }
        
        let star = UIImage(named: "bright-star")
        let halfStar = UIImage(named: "kindOfbright-star")
        
        if number >= 60 {
            star1.image = star
            star2.image = star
            star3.image = star
            if number >= 80 {
                star4.image = star
                if number == 100 {
                    star5.image = star
                } else {
                    star5.image = halfStar
                }
            } else {
                star4.image = halfStar
            }
        } else if number >= 20 {
            star1.image = star
            if number >= 40 {
                star2.image = star
                if number >= 50 {
                    star3.image = star
                } else {
                    star3.image = halfStar
                }
            } else {
                star2.image = halfStar
            }
        } else if number >= 10 {
            star1.image = halfStar
        }
    }
}
