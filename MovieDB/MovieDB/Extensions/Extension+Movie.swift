//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import Foundation
extension MoviesResult{
    
    
    /**
     This property returns a URL to fetch movie poster
     */
    
    var moviePoster:URL?{
        guard let poster = posterPath else {return nil}
        return URL(string: "\(APIConfiguration.imagesBaseURL)\(poster)")
    }
}

