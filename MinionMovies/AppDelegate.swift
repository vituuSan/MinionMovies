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
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "Movies") as! HomeViewController
        let presenter = HomeViewPresenter(view: controller)
        let interactor = HomeViewInteractor(presenter: presenter, worker: HomeViewWorker())
       
        interactor.worker?.dataProvider = HomeViewDataProvider(dbManager: DBManager(config: .basic))
        controller.interactor = interactor
        
        let navigationController = storyboard.instantiateViewController(withIdentifier: "Navigation") as! UINavigationController
        navigationController.viewControllers = [controller] 
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

