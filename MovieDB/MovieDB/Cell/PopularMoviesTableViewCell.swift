//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var movieLabel: UILabel!
    //Seting up data
    var movies:MoviesResult!{
        didSet{
            movieLabel.text = movies.title
            movieImageView.setImage(url: movies?.moviePoster)
        }
    }
}
