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
    let favMovie = FavMovieDB()
    var movie: MovieDB?
    var id: String? {
        didSet {
            favMovie.id = id!
            movie = worker?.getItem(id: id!)
        }
    }
    
    init(presenter: DetailsViewPresenterProtocol, worker: DetailsViewWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func buttonFavMovieWasClicked() {
        guard case favMovie.id = movie?.id else { return }
        
        if checkItemInDB() {
            worker?.delete(item: favMovie)
        } else {
            worker?.add(item: favMovie)
        }
        setupFavButtonImage()
    }
    
    func setupFavButtonImage() {
        if checkItemInDB() {
            presenter?.toggleFavButtonImage(boolean: true)
        } else {
            presenter?.toggleFavButtonImage(boolean: false)
        }
    }
    
    func checkItemInDB() -> Bool {
        if worker?.check(item: favMovie) ?? false {
            return true
        } else {
            return false
        }
    }
    
    func theScreenIsLoading() {
        
        if checkItemInDB() {
            presenter?.toggleFavButtonImage(boolean: true)
        } else {
            presenter?.toggleFavButtonImage(boolean: false)
        }
        presenter?.show(item: movie!)
    }
    
    func trailerButtonWasClicked() {
        guard let checkedMovie = movie else { return }
        presenter?.showTrailer(urlString: checkedMovie.trailer!)
    }
}

