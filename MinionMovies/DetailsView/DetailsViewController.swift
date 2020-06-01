//
//  MovieDetailController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 04/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit
import RealmSwift

protocol DetailsViewControllerProtocol {
    var interactor: DetailsViewInteractorProtocol? { get set }
    var movieModel: DetailsViewModel? { get set }
    
    func setupFavButtonImage(string: String)
    func showTrailer(url: URL)
    func setupStars(index: Int, image: UIImage)
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var posterMovie: UIImageView!
    @IBOutlet private weak var titleMovie: UILabel!
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
    
    var interactor: DetailsViewInteractorProtocol?
    var id: String?
    var movieModel: DetailsViewModel? {
        didSet {
            setupLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.id = id ?? ""
        interactor?.theScreenIsLoading()
    }
    
    @IBAction func buttonFavMovie(_ sender: Any) {
        interactor?.buttonFavMovieWasTapped()
    }
    
    @IBAction func trailerButton(_ sender: UIButton) {
        interactor?.trailerButtonWasTapped()
    }
    
    func setupLayout() {
        backgroundImage.image = movieModel?.backgroundImage
        posterMovie.image = movieModel?.poster
        titleMovie.text = movieModel?.title
        evaluation.text = movieModel?.evaluation
        yearAndDuration.text = movieModel?.yearAndDuration
        resolution.text = movieModel?.resolution
        plot.text = movieModel?.plot
    }
    
    func showTrailer(url: URL) {
        UIApplication.shared.open(url)
    }
    
    func setupFavButtonImage(string: String) {
        favButton.image = UIImage(named: string)
    }
    
    func setupStars(index: Int, image: UIImage) {
        let images = [star1, star2, star3, star4, star5]
        images[index]?.image = image
    }
}
