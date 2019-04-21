//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//
import Result
import Foundation

import Foundation
class NetworkManager {
    
    class func getPopularMovies(_page:Int,completion:@escaping (APIResult<PopularMovies>)->Void){
        MovieService.service.request(.popularMovies(page:_page)) { result in
            do{
                let movies:PopularMovies = try result.decoded()
                if movies.totalPages != nil && _page <= movies.totalPages ?? 0{
                    completion(.success(movies))}
            }
            catch{
                completion(.failure(error.customDescription))
            }
            
        }
    }
    
    
    class func getMovieById(_id:Int,completion:@escaping (APIResult<[Movie]>)->Void){
        MovieService.service.request(.getMovieById(id: _id)) { result in
            do{
                let movie:[Movie] = try result.decoded(keypath: "results")
                    completion(.success(movie))}
            catch{
                completion(.failure(error.customDescription))
            }
            
        }
    }
    
    class func getGenres(completion:@escaping (APIResult<[Genre]>)->Void){
        MovieService.service.request(.getGenres()) { result in
            do{
                let genres:[Genre] = try result.decoded(keypath: "genres")
                completion(.success(genres))}
            catch{
                completion(.failure(error.customDescription))
            }
            
        }
    }
}

