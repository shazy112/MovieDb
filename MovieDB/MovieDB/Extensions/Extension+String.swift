//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import Foundation

extension String {
    
    /**
     It converts a string type Date to desired App format.
     
     -returns: the converted string date.
     */
    
    func toString()->String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd"
        guard let dated = dateFormatter.date(from:self) else {return nil}
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: dated)
    }
    
}
