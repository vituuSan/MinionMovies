//
//  MovieDetailController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 04/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit
import RealmSwift

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
    @IBOutlet private weak var favButton: UIBarButtonItem!
    
    var movie: MovieDB?
    internal var dbManager: DBManagerProtocol = DBManager(config: Realm.Configuration.defaultConfiguration)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLayout()
    }
    
    @IBAction func toggleFavMovie(_ sender: Any) {
        guard let checkedMovie = movie else { return }
        if !dbManager.check(object: checkedMovie) {
            dbManager.add(object: checkedMovie)
        } else {
            dbManager.delete(object: checkedMovie)
        }
        chooseImageOfFavButton()
    }
    
    @IBAction func trailerButton(_ sender: UIButton) {
        guard let checkedMovie = movie,
            let url = URL(string: checkedMovie.trailer ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    func setupLayout() {
        guard let checkedMovie = self.movie else { return }
        createBackground(with: checkedMovie.images ?? List<String>())
        chooseImageOfFavButton()
        createPoster(with: checkedMovie.poster ?? "")
        
        nameMovie.text = checkedMovie.title
        createEvaluation(with: checkedMovie.metascore ?? "")
        evaluation.text = "(\(checkedMovie.metascore ?? ""))"
        yearAndDuration.text = "\(checkedMovie.year ?? "")  \(checkedMovie.runtime ?? "")"
        
        if checkedMovie.resolutionIs4k ?? false {
            if checkedMovie.hdr ?? false {
                resolution.text = "4k  HDR"
            } else {
                resolution.text = "4k"
            }
        } else if checkedMovie.hdr ?? false {
            resolution.text = "HDR"
        } else {
            resolution.text = ""
        }
        
        plot.text = checkedMovie.plot
    }
    
    func chooseImageOfFavButton() {
        guard let checkedMovie = movie else { return }
        
        if dbManager.check(object: checkedMovie) {
            favButton.image = UIImage(named: "marked")
        } else {
            favButton.image = UIImage(named: "mark")
        }
    }
    
    func createBackground(with urlsOfImages: List<String>) {
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
        guard var number = Double(metascore) else { return }
        let images = [star1, star2, star3, star4, star5]
        var i = 1

        while i <= 5 {
            if number / 20 >= 1 {
                images[i - 1]?.image = UIImage(named: "bright-star")
            } else if number / 20 >= 0.5 {
                images[i - 1]?.image = UIImage(named: "kindOfbright-star")
            }
            
            number -= 20
            i += 1
        }
    }
}
