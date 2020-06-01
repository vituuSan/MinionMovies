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
    var id: String { get set }
    
    func buttonFavMovieWasTapped()
    func theScreenIsLoading()
    func trailerButtonWasTapped()
}

class DetailsViewInteractor: DetailsViewInteractorProtocol {
    var presenter: DetailsViewPresenterProtocol?
    var worker: DetailsViewWorkerProtocol?
    var movie: MovieDB?
    var id: String = ""
    
    init(presenter: DetailsViewPresenterProtocol, worker: DetailsViewWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    private func fecthMovie(with id: String) {
        movie = worker?.fetchMovie(with: id)
    }
    
    func buttonFavMovieWasTapped() {
        let favMovie = FavMovieDB()
        favMovie.id = id
        checkItemInDB() ? worker?.deleteMovie(with: id) : worker?.add(item: favMovie)

        setupFavButtonImage()
    }
    
    func setupFavButtonImage() {
        checkItemInDB() ? presenter?.toggleFavButtonImage(boolean: true) : presenter?.toggleFavButtonImage(boolean: false)
    }
    
    private func checkItemInDB() -> Bool {
        return worker?.checkMovie(with: id) ?? false
    }
    
    func theScreenIsLoading() {
        fecthMovie(with: id)
        setupFavButtonImage()
        presenter?.show(item: movie!)
    }
    
    func trailerButtonWasTapped() {
        guard let checkedMovie = movie else { return }
        presenter?.showTrailer(urlString: checkedMovie.trailer!)
    }
}

