//
//  HomeViewWorker.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol WorkerProtocol {
//    var dataProvider: DataProviderProtocol? { get }
//    var interactor: InteractorProtocol? { get }
    
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<[MovieDB], Error>) -> Void)
}

class HomeViewWorker: WorkerProtocol {
//    var dataProvider: DataProviderProtocol? = HomeViewDataProvider()
//    var interactor: InteractorProtocol? =źHomeViewInteractor()
    private let session = URLSession.shared
    private var movies: [MovieDB]?
    
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<[MovieDB], Error>) -> Void) {
        guard let checkedUrl = URL(string: urlString) else { return }
        let error = NSError()
        let task = URLSession.shared.dataTask(with: checkedUrl, completionHandler: { (data, _, _) in
            guard let checkedData = data else {
                completionHandler(.failure(error))
                return
            }
            
            do {
                self.movies = try JSONDecoder().decode([MovieDB].self, from: checkedData)
                completionHandler(.success(self.movies!))
            } catch {
                completionHandler(.failure(error))
            }
        })
        task.resume()
    }
    
    func setItems() -> [MovieDB]? {
        return movies
    }
}
