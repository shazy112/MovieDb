//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import AVKit
class PopularMovieDetailViewController: UIViewController {
    
    @IBOutlet weak private var overviewLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var genresLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    private lazy var movie : [Movie] = []
    private lazy var genres :[Genre] = []
    var popularMovie:PopularMoviesResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        getGenres()
        getMovie(id: popularMovie?.id ?? 0)
    }
    
    private func getGenres(){
        NetworkManager.getGenres {[unowned self] (result) in
            switch result{
            case .success(let myGenres):
                self.genres = myGenres
            case .failure(let message):
                self.showAlert(message: message)
            }
        }
    }
    
    private func getMovie(id:Int){
        NetworkManager.getMovieById(_id: id) {[unowned self] (result) in
            switch result{
            case .success(let myMovie):
                self.movie = myMovie
                self.setData()
            case .failure(let message):
                self.showAlert(message: message)
            }
        }
    }
    
    private func setData(){
        dateLabel.text = popularMovie?.releaseDate.convertToAppFormat()
        genresLabel.text = SetGenres.value(genres: genres, selectedMovieGenres: popularMovie?.genreids)
        overviewLabel.text = popularMovie?.overview
        titleLabel.text = popularMovie?.title
        if let _poster = popularMovie?.moviePoster{
            imageView.setImage(url: _poster)
        }
    }
    
    @IBAction func watchTrailerTapped(_ sender: Any) {
        if let key = movie.first?.key {
            YoutubeVideoPlayer.playVideoWith(identifier: key, vc: self)}
    }
    
}



