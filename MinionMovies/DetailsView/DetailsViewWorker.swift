//
//  DetailsViewWorker.swift
//  MinionMovies
//
//  Created by Vitor Costa on 14/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol DetailsViewWorkerProtocol {
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<MovieDetails, Error>) -> Void)
}

class DetailsViewWorker: DetailsViewWorkerProtocol {
    
    func makeGetRequest(urlString: String, completionHandler: @escaping(Result<MovieDetails, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            guard let data = data else {
                completionHandler(.failure(error ?? NSError()))
                return
            }
            
            do {
                let items = try JSONDecoder().decode(MovieDetails.self, from: data)
                completionHandler(.success(items))
                
            } catch let error {
                completionHandler(.failure(error))
            }
        })
        task.resume()
    }
}
