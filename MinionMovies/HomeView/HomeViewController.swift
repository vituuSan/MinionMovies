//
//  ViewController.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/02/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import UIKit

protocol HomeViewProtocol: UIViewController {
    var interactor: HomeViewInteractorProtocol? { get }
    var movies: [Movie] { get set }
}

class HomeViewController: UIViewController, HomeViewProtocol {
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: HomeViewInteractorProtocol?
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.hideLoading()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.title = "Movies"
        self.view.backgroundColor = .cyan.withAlphaComponent(0.8)
        
        tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        self.showLoading()
        
        interactor?.theScreenIsLoading()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell") as? HomeViewCell {
            cell.setup(movie: movies[indexPath.section])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        let presenter = DetailsViewPresenter(view: controller)
        let interactor = DetailsViewInteractor(presenter: presenter, worker: DetailsViewWorker())
        interactor.id = self.movies[indexPath.section].id ?? 0
        controller.interactor = interactor
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // Settings to cell's spacing
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
}
