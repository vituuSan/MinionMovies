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
    func show(item: MovieDetails)
    func showAlert(message: String, type: AlertType)
    func show(image: UIImage)
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    var view: DetailsViewControllerProtocol?
    
    init(view: DetailsViewControllerProtocol) {
        self.view = view
    }
    
    func show(item: MovieDetails) {
        view?.movie = item
    }
    
    func showTrailer(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        view?.showTrailer(url: url)
    }
    
    private func createImage(urlString: String) -> UIImage {
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
    func showAlert(message: String, type: AlertType) {
        view?.showAlert(message: message, type: type)
    }
    
    func show(image: UIImage) {
        view?.show(image: image)
    }
}
