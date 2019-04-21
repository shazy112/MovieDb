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
    
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    var popularMoviesDataSource = PopularMoviesDataSource()
    lazy var currentPage:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        getPopularMovies()
    }
    
    private func setupKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getPopularMovies(){
        NetworkManager.getPopularMovies(_page: currentPage) {[unowned self] (result) in
            switch result{
            case .success(let popularMovies):
                if !popularMovies.results.isEmpty{
                    self.popularMoviesDataSource.popularMovies.append(contentsOf: popularMovies.results)
                    self.popularMovies.append(contentsOf: popularMovies.results)
                    self.tableView.reloadData()
                    self.currentPage+=1
                }
            case .failure(let error):
                self.showAlert(message: error)
            }
        }
    }
    
    private func searchMovies(keyword:String){
        popularMoviesDataSource.popularMovies = popularMovies
        if keyword.count > 0{
            popularMoviesDataSource.popularMovies = popularMoviesDataSource.popularMovies.filter{$0.title.contains(keyword)}}
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.movieDetail{
            if let movieDetailVc = segue.destination as? PopularMovieDetailViewController{
                if let index = sender as? Int{
                    movieDetailVc.popularMovie = popularMoviesDataSource.popularMovies[index]
                }
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.movieDetail, sender: indexPath.row)
    }
}
extension PopularMoviesViewController:UISearchBarDelegate{
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: keyboardSize.height, left: 0, bottom:0 , right: 0)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovies(keyword: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovies(keyword: searchBar.text!)
    }
}
