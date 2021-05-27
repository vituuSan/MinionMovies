//
//  DetailsViewInteractor.swift
//  MinionMovies
//
//  Created by Vitor Costa on 14/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol DetailsViewInteractorProtocol {
    var presenter: DetailsViewPresenterProtocol? { get set }
    var worker: DetailsViewWorkerProtocol? { get set }
    var id: Int { get set }
    
    func theScreenIsLoading()
    func homepageButtonWasTapped()
}

class DetailsViewInteractor: DetailsViewInteractorProtocol {
    var presenter: DetailsViewPresenterProtocol?
    var worker: DetailsViewWorkerProtocol?
    var movie: MovieDetails?
    var id: Int = 0
    
    init(presenter: DetailsViewPresenterProtocol, worker: DetailsViewWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func theScreenIsLoading() {
        worker?.makeGetRequest(urlString: "https://api.themoviedb.org/3/movie/\(id)?api_key=27be02dff2f4dd49499f203c5bc3bd3e") { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
                self?.presenter?.show(item: movie)
                self?.loadImage()
                
            case .failure(let error):
                self?.presenter?.showAlert(message: error.localizedDescription, type: .error)
            }
        }
    }
    
    private func loadImage() {
        MinionMoviesService.fetchImage(path: movie?.poster ?? "") { [weak self] result in
            switch result {
            case .success(let image):
                self?.presenter?.show(image: image)
            case .failure(let error):
                self?.presenter?.showAlert(message: error.localizedDescription, type: .error)
            }
        }
    }
    
    func homepageButtonWasTapped() {
        guard let checkedMovie = movie else { return }
        presenter?.showTrailer(urlString: checkedMovie.homepage!)
    }
}

