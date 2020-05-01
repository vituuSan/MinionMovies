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
    
    func fetch(url: String)
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
//            if error == nil {
//                do {
//                    if let dataChecked = data {
//                        self.movies = try JSONDecoder().decode([MovieDB].self, from: dataChecked)
//                    }
//                } catch {
//                    print("JSON error: \(error.localizedDescription)")
//                }
//            } else {
//                debugPrint(error?.localizedDescription)
//            }
            print(data)
        })
        task.resume()
    }
    
    func fetch(url: String) {
        guard let checkedUrl = URL(string: url) else { return }
        let task = session.dataTask(with: checkedUrl) { data, response, error in
            if error == nil {
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                let mime = response?.mimeType, mime == "application/json" else {
                    return
                }
                do {
                    if let dataChecked = data {
                        self.movies = try JSONDecoder().decode([MovieDB].self, from: dataChecked)
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            } else {
                debugPrint(error?.localizedDescription)
            }
        }
        task.resume()
    }
    
    func setItems() -> [MovieDB]? {
        return movies
    }
}
