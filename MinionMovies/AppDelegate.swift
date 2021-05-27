//
//  AppDelegate.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let controller = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let presenter = HomeViewPresenter(view: controller)
        let interactor = HomeViewInteractor(presenter: presenter, worker: HomeViewWorker())

        controller.interactor = interactor
        let navigation = UINavigationController(rootViewController: controller)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}
