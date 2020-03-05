//
//  Loading.swift
//  MinionMovies
//
//  Created by Vitor Costa on 05/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

class Loading: UIViewController {

    func loadingScene() -> UIActivityIndicatorView {
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 54.5, y: 172.5, width: 300, height: 300)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        self.view.addSubview(loadingIndicator)
        return loadingIndicator
    }
    
    func stopLoading(item: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            item.stopAnimating()
        }
    }

}
