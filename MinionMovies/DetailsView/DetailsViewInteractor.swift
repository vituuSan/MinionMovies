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
    
    func addOrRemoveFromFavorites(item: MovieDB?)
    func theScreenIsLoading()
    func trailerButtonWasClicked()
}

class DetailsViewInteractor: DetailsViewInteractorProtocol {
    var presenter: DetailsViewPresenterProtocol?
    var worker: DetailsViewWorkerProtocol?
    var movie: MovieDB?
    let favMovie = FavMovieDB()
    
    init(presenter: DetailsViewPresenterProtocol, worker: DetailsViewWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func addOrRemoveFromFavorites(item: MovieDB?) {
        guard case favMovie.id = item?.id else { return }
        
        if worker?.check(item: favMovie) ?? false {
            worker?.delete(item: favMovie)
            presenter?.toggleFavButtonImage(boolean: false)
        } else {
            worker?.add(item: favMovie)
            presenter?.toggleFavButtonImage(boolean: true)
        }
    }
    
    func theScreenIsLoading() {
        
    }
    
    func trailerButtonWasClicked() {
        guard let checkedMovie = movie else { return }
        presenter?.showTrailer(urlString: checkedMovie.trailer!)
    }
}

