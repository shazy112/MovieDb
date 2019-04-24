//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak private var overviewLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var genresLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    
    private lazy var specs : [Specifications] = []
    private lazy var genres :[Genre] = []
    var movie:MoviesResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Detail"
        getGenres()
        getMovieSpecs(id: movie?.id ?? 0)
    }
    
    private func getGenres(){
        //Call to get genres
        NetworkManager.getGenres {[unowned self] (result) in
            switch result{
            case .success(let myGenres):
                self.genres = myGenres
            case .failure(let message):
                self.showAlert(message: message)
            }
        }
    }
    
    private func getMovieSpecs(id:Int){
        //Getting movies specs from id received from the previous controller
        NetworkManager.getMovieById(_id: id) {[weak self] (result) in
            switch result{
            case .success(let _specs):
                self?.specs = _specs
                self?.setData()
            case .failure(let message):
                self?.showAlert(message: message)
            }
        }
    }
    
    private func setData(){
        dateLabel.text = movie?.releaseDate.toString()
        genresLabel.text = Genre.setValue(genres: genres, selectedMovieGenres: movie?.genreids ?? [])
        overviewLabel.text = movie?.overview
        titleLabel.text = movie?.title
        imageView.setImage(url: movie?.moviePoster)
    }
    
    @IBAction func watchTrailerTapped(_ sender: Any) {
        if let key = specs.first?.key {
            YoutubeVideoPlayer.playVideoWith(identifier: key, vc: self)
        }
    }
    
}



