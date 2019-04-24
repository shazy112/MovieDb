//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    var movies:[MoviesResult] = []
    @IBOutlet weak private var tableView: UITableView!{
        didSet{
            //Setting up DataSource to our Movie data source class and delegate to self
            tableView.dataSource = moviesDataSource
            tableView.delegate = self
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    
    var moviesDataSource = MoviesDataSource()
    var currentPage:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        getPopularMovies()
    }
    
    private func setupKeyboardNotifications(){
        //Adding observers to check when keyboard will show and hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getPopularMovies(){
        //Api call to get popular movies
        NetworkManager.getPopularMovies(_page: currentPage) {[unowned self] (result) in
            switch result{
            case .success(let popularMovies):
                //Checking if popular movies returned from api are not empty
                if !popularMovies.results.isEmpty{
                    //if data is available then Appends data to movie data source reloads tableview and increament current page
                    self.moviesDataSource.movies.append(contentsOf: popularMovies.results)
                    self.movies.append(contentsOf: popularMovies.results)
                    self.tableView.reloadData()
                    self.currentPage+=1
                }
            case .failure(let error):
                self.showAlert(message: error)
            }
        }
    }
    
    private func searchMovies(keyword:String){
        //Movies datasource is always updated with data that initilly we received from api
        moviesDataSource.movies = movies
        //if only the count is greater than zero than filter the keyword else reload tableviewview to bring initial data
        if keyword.count > 0{
            moviesDataSource.movies = moviesDataSource.movies.filter{$0.title.contains(keyword)}}
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.movieDetail{
            if let movieDetailVc = segue.destination as? MovieDetailViewController{
                if let index = sender as? Int{
                    movieDetailVc.movie = moviesDataSource.movies[index]
                }
            }
        }
    }
}

extension MoviesViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Checking if tableview has reached its lastcell then call api with increamented page no to load more data
        if indexPath.row == moviesDataSource.movies.count - 1{
            getPopularMovies()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.movieDetail, sender: indexPath.row)
    }
}
extension MoviesViewController:UISearchBarDelegate{
    
    @objc func keyboardWillShow(_ notification:Notification) {
        /**
         When searchbar is tapped IQKeyboard manager sends the self.view top to minus frame with respect to  keyboard height there fore we have to set tableview top insets to keyboard height so it does not get stucked
         */
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: keyboardSize.height, left: 0, bottom:0 , right: 0)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        /**
         When keyboard is hidden we bring insets of tableview to normal
         */
        
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
