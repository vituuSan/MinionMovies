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
    func show(item: MovieDB)
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    var view: DetailsViewControllerProtocol?
    
    init(view: DetailsViewControllerProtocol) {
        self.view = view
    }
    
    func show(item: MovieDB) {
        let detailsMovieModel = DetailsViewModel(backgroundImage: createImage(urlString: item.poster!),
            poster: createImage(urlString: item.poster ?? ""),
            title: item.title ?? "",
            evaluation: item.metascore ?? "",
            stars: item.metascore ?? "",
            yearAndDuration: (item.year ?? "") + "  " + (item.runtime ?? ""),
            resolution: createResolution(item: item),
            plot: item.plot ?? "")
        
        view?.movieModel = detailsMovieModel
        createStars(with: item.metascore ?? "")
    }
    
    func showTrailer(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        view?.showTrailer(url: url)
    }
    
    func toggleFavButtonImage(boolean: Bool) {
        view?.setupFavButtonImage(string: boolean ? "marked" : "mark")
    }
    
    private func createImage(urlString: String) -> UIImage {
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return UIImage() }
        return image
    }
    
    private func createResolution(item: MovieDB) -> String {
        let is4K = item.resolutionIs4k ?? false ? "4K" : ""
        let hdr = item.hdr ?? false ? "HDR" : ""
        return is4K + "  " + hdr
    }
    
    private func createStars(with metascore: String) {
        guard var number = Double(metascore) else { return }
        var i = 1

        while i <= 5 {
            if number / 20 >= 1 {
                view?.setupStars(index: i - 1, image: UIImage(named: "bright-star")!)
            } else if number / 20 >= 0.5 {
                view?.setupStars(index: i - 1, image: UIImage(named: "kindOfbright-star")!)
            }
            
            number -= 20
            i += 1
        }
    }
}
