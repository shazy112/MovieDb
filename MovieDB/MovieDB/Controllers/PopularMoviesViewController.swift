//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    lazy var popularMovies:[PopularMoviesResult] = []
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = popularMoviesDataSource
            tableView.delegate = self
        }
    }
    var popularMoviesDataSource = PopularMoviesDataSource()
    lazy var currentPage:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMovies()
    }
    
    private func getPopularMovies(){
        NetworkManager.getPopularMovies(_page: currentPage) {[unowned self] (result) in
            switch result{
            case .success(let popularMovies):
                if !popularMovies.results.isEmpty{
                    self.popularMoviesDataSource.popularMovies.append(contentsOf: popularMovies.results)
                    self.tableView.reloadData()
                    self.currentPage+=1
                }
            case .failure(let error):
                self.showAlert(message: error)
            }
        }
    }
}

extension PopularMoviesViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == popularMoviesDataSource.popularMovies.count - 1{
            getPopularMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

