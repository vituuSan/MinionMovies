//
//  MovieDetailController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 04/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit
import RealmSwift

protocol DetailsViewControllerProtocol: UIViewController {
    var interactor: DetailsViewInteractorProtocol? { get set }
    var movie: MovieDetails { get set }
    
    func showTrailer(url: URL)
    func show(image: UIImage)
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var homepageButton: UIButton!
    
    var interactor: DetailsViewInteractorProtocol?
    var movie: MovieDetails = MovieDetails() {
        didSet {
            setupLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan.withAlphaComponent(0.8)
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.showLoading()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "DetailsViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsViewCell")
        
        setupButtonHomepage()
        
        interactor?.theScreenIsLoading()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    func setupButtonHomepage() {
        self.homepageButton.layer.shadowOpacity = 0.23
        self.homepageButton.layer.shadowRadius = 4
        self.homepageButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.homepageButton.layer.shadowColor = UIColor.black.cgColor
        self.homepageButton.backgroundColor = .white
        self.homepageButton.layer.cornerRadius = 10
        self.homepageButton.tintColor = .black
    }
    
    func setupLayout() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.labelTitle.text = self.movie.title
            self.textViewOverview.text = self.movie.overview
            self.collectionView.reloadData()
        }
    }
    
    func showTrailer(url: URL) {
        UIApplication.shared.open(url)
    }
    
    func show(image: UIImage) {
        DispatchQueue.main.async {
            self.backgroundImage.image = image
        }
    }
    
    @IBAction func homepageButtonTap(_ sender: Any) {
        interactor?.homepageButtonWasTapped()
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsViewCell", for: indexPath) as? DetailsViewCell {
            cell.backgroundColor = .clear
            
            cell.backView.layer.cornerRadius = 25
//            cell.backView.clipsToBounds = false
//            cell.backView.layer.masksToBounds = false
            cell.backView.layer.shadowOpacity = 0.5
            cell.backView.layer.shadowRadius = 15
            cell.backView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            cell.backView.layer.shadowColor = UIColor.black.cgColor
            cell.backView.backgroundColor = .white
            
            cell.setup(title: movie.genres[indexPath.row].name ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
