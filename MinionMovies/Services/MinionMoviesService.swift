//
//  MinionMoviesService.swift
//  MinionMovies
//
//  Created by Vitor Costa on 12/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import UIKit

class MinionMoviesService {
    static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'TMDB-Info.plist'.")
            }

            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "api_key") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
            }
            return "?api_key=" + value
        }
    }
    
    static func fetchImage(path: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: ServiceConstants.basePathImage + path) else {
            completion(.failure(NSError(domain: "Unrecognizer path.", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            guard let data = data else {
                completion(.failure(error ?? NSError()))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "Unrecognizer format for image.", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(image))
        })
        task.resume()
    }
}
