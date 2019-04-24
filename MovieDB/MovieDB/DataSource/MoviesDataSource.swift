//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import Foundation
import UIKit
/**
 Tableview Data source that sets up the required method need to populate any tableview
 
 */

class MoviesDataSource:NSObject,UITableViewDataSource{
    var movies:[MoviesResult] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MoviesTableViewCell
        cell.movies = movies[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
}
