//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    var movies:PopularMoviesResult?{
        didSet{
            guard let _movies = movies else {return}
            movieLabel.text = _movies.title
            if let _poster = movies?.moviePoster{
                movieImageView.setImage(url: _poster)
            }
        }
    }
}
