//
//  Genres.swift
//  MovieDB
//
//  Created by Invision on 21/04/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import Foundation
struct Genre: Codable {
    let id: Int
    let name: String
    
    static func setValue(genres:[Genre],selectedMovieGenres:[Int])->String{
        /**
         Parameters: takes genres arrays of selected movies genres that gives multiple ids
         takes genres array from genre api
         -returns: string with genre name seperated by ,
         */
        return genres.filter{selectedMovieGenres.contains($0.id)}.map{$0.name}.joined(separator: ",")
    }
}


