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
    @IBOutlet private weak var yearAndDuration: UILabel!
    @IBOutlet private weak var resolution: UILabel!
    @IBOutlet private weak var plot: UITextView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
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
        
        let image1 = ({
            self.star1.image = UIImage(named: "bright-star")
        })
        let image2 = ({
            self.star2.image = UIImage(named: "bright-star")
        })
        let image3 = ({
            self.star3.image = UIImage(named: "bright-star")
        })
        let image4 = ({
            self.star4.image = UIImage(named: "bright-star")
        })
        let image5 = ({
            self.star5.image = UIImage(named: "bright-star")
        })
        switch number {
        case 20..<40:
            image1()
        case 40..<60:
            image1()
            image2()
        case 60..<80:
            image1()
            image2()
            image3()
        case 80..<100:
            image1()
            image2()
            image3()
            image4()
        case 100:
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
