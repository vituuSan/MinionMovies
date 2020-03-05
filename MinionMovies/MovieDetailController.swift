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
    
    func mountBackground(with urls: [String]) {
        if let checkedUrl = URL(string: urls[0]) {
            guard let data = try? Data(contentsOf: checkedUrl) else { return }
            backgroundImage.image = UIImage(data: data)
        }
    }
    
    func mountPoster(with url: String) {
        if let checkedUrl = URL(string: url) {
            guard let data = try? Data(contentsOf: checkedUrl) else { return }
            posterMovie.image = UIImage(data: data)
        }
    }
}
