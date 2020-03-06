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
        mountScreen()
    }
    
    func mountScreen() {
        guard let checkedMovie = self.movie else { return }
        mountBackground(with: checkedMovie.images)
        mountPoster(with: checkedMovie.poster)
        
        nameMovie.text = checkedMovie.title
        mountEvaluation(with: checkedMovie.metascore)
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
    
    func mountBackground(with urlsOfImages: [String]) {
        if let checkedUrl = URL(string: urlsOfImages[0]) {
            guard let data = try? Data(contentsOf: checkedUrl) else { return }
            backgroundImage.image = UIImage(data: data)
        }
    }
    
    func mountPoster(with urlOfPoster: String) {
        if let checkedUrl = URL(string: urlOfPoster) {
            guard let data = try? Data(contentsOf: checkedUrl) else { return }
            posterMovie.image = UIImage(data: data)
        }
    }
    
    func mountEvaluation(with metascore: String) {
        guard let number = Int(metascore) else { return }
        
        let image1 = {
            if number < 20 {
                self.star1.image = UIImage(named: "kindOfbright-star")
            } else {
                self.star1.image = UIImage(named: "bright-star")
            }
        }
        let image2 = {
            if number < 40 {
                self.star2.image = UIImage(named: "kindOfbright-star")
            } else {
                self.star2.image = UIImage(named: "bright-star")
            }
        }
        let image3 = {
            if number < 60 {
                self.star3.image = UIImage(named: "kindOfbright-star")
            } else {
                self.star3.image = UIImage(named: "bright-star")
            }
        }
        let image4 = {
            if number < 80 {
                self.star4.image = UIImage(named: "kindOfbright-star")
            } else {
                self.star4.image = UIImage(named: "bright-star")
            }
        }
        let image5 = {
            if number < 100 {
                self.star5.image = UIImage(named: "kindOfbright-star")
            } else {
                self.star5.image = UIImage(named: "bright-star")
            }
        }
        switch number {
        case 10..<31:
            image1()
        case 30..<51:
            image1()
            image2()
        case 50..<71:
            image1()
            image2()
            image3()
        case 70..<91:
            image1()
            image2()
            image3()
            image4()
        case 90..<101:
            image1()
            image2()
            image3()
            image4()
            image5()
        default:
            break
        }
    }
}
