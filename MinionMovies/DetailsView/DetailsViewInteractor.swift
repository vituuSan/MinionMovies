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
    var id: String? { get set }
    
    func buttonFavMovieWasClicked()
    func theScreenIsLoading()
    func trailerButtonWasClicked()
}

class DetailsViewInteractor: DetailsViewInteractorProtocol {
    var presenter: DetailsViewPresenterProtocol?
    var worker: DetailsViewWorkerProtocol?
    var movie: MovieDB?
    var id: String? {
        didSet {
            movie = worker?.getItem(id: id!)
        }
    }
    
    init(presenter: DetailsViewPresenterProtocol, worker: DetailsViewWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func buttonFavMovieWasClicked() {
        let favMovie = FavMovieDB()
        favMovie.id = id!
        checkItemInDB() ? worker?.delete(item: id!) : worker?.add(item: favMovie)

        setupFavButtonImage()
    }
    
    func setupFavButtonImage() {
        checkItemInDB() ? presenter?.toggleFavButtonImage(boolean: true) : presenter?.toggleFavButtonImage(boolean: false)
    }
    
    private func checkItemInDB() -> Bool {
        if worker?.check(item: id!) ?? false {
            return true
        } else {
            return false
        }
    }
    
    func theScreenIsLoading() {
        setupFavButtonImage()
        presenter?.show(item: movie!)
    }
    
    func trailerButtonWasClicked() {
        guard let checkedMovie = movie else { return }
        presenter?.showTrailer(urlString: checkedMovie.trailer!)
    }
}

