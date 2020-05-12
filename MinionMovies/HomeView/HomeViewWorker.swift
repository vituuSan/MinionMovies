//
//  HomeViewWorker.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol WorkerProtocol {
    var dataProvider: DataProviderProtocol? { get set }
    
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<[MovieDB], Error>) -> Void)
}

class HomeViewWorker: WorkerProtocol {
    var dataProvider: DataProviderProtocol?
    private let session = URLSession.shared
    private var items: [MovieDB]?
    
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<[MovieDB], Error>) -> Void) {
        guard let checkedUrl = URL(string: urlString) else { return }
        let error = NSError()
        let task = URLSession.shared.dataTask(with: checkedUrl, completionHandler: { (data, _, _) in
            guard let checkedData = data else {
                completionHandler(.failure(error))
                return
            }
            
            do {
                self.items = try JSONDecoder().decode([MovieDB].self, from: checkedData)
                completionHandler(.success(self.items!))
                
                for item in self.items! {
                    self.dataProvider?.add(item: item)
                }
            } catch {
                completionHandler(.failure(error))
            }
        })
        task.resume()
    }
}
