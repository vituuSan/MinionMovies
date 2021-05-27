//
//  Extensions.swift
//  MinionMovies
//
//  Created by Vitor Costa on 10/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import UIKit

fileprivate var aView: UIView?
fileprivate var popup: UIView!

enum AlertType {
    case error
    case success
}

extension UIViewController {
    
    func showLoading() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func hideLoading() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func showAlert(message: String, type: AlertType) {
        popup = UIView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        popup.backgroundColor = type == .error ? UIColor.red : UIColor.green
        
        let label = UILabel(frame: .zero)
        label.text = message
        label.textColor = .white
        
        popup.addSubview(label)
        self.view.addSubview(popup)
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)
    }
    
    @objc func dismissAlert() {
        if popup != nil {
            popup.removeFromSuperview()
        }
    }
}

extension UICollectionViewCell {
    
    func shadowDecorate() {
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
