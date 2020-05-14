//
//  DetailsViewPresenter.swift
//  MinionMovies
//
//  Created by Vitor Costa on 14/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

protocol DetailsViewPresenterProtocol {
    var view: DetailsViewControllerProtocol? { get set }
    
    func showTrailer(urlString: String)
    func toggleFavButtonImage(boolean: Bool)
    func setupBackgroundImage(urlString: String)
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    var view: DetailsViewControllerProtocol?
    var detailsMovieModel: DetailsViewModel?
    
    init(view: DetailsViewControllerProtocol) {
        self.view = view
    }
    
    func showTrailer(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        view?.showTrailer(url: url)
    }
    
    func createPoster(urlImage: String) {
        guard let image = UIImage(named: urlImage) else { return }
        view?.setupPoster(with: image)
    }
    
    func toggleFavButtonImage(boolean: Bool) {
        view?.chooseImageOfFavButton(boolean: boolean)
    }
    
    func setupBackgroundImage(urlString: String) {
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
        view?.setupBackground(image: image)
    }
}
