//
//  HomeViewWorker.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol HomeViewWorkerProtocol {
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<[Movie], Error>) -> Void)
}

class HomeViewWorker: HomeViewWorkerProtocol {
    private let session = URLSession.shared
    
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            guard let data = data else {
                completionHandler(.failure(error ?? NSError()))
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                let results = try JSONSerialization.data(withJSONObject: response?["results"] ?? [:], options: .prettyPrinted)
                let items = try JSONDecoder().decode([Movie].self, from: results)
                completionHandler(.success(items))
                
            } catch let error {
                completionHandler(.failure(error))
            }
        })
        task.resume()
    }
}
