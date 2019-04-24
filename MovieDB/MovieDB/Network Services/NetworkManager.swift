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

//Contains all the api calls
class NetworkManager {
    //Here Decoded returns either the model or if it fails it returs error.
    class func getPopularMovies(_page:Int,completion:@escaping (APIResult<Movies>)->Void){
        MovieService.service.request(.popularMovies(page:_page)) { result in
            do{
                let movies:Movies = try result.decoded()
                if let pages = movies.totalPages, _page <= pages{
                    completion(.success(movies))
                }
            }
            catch{
                completion(.failure(error.customDescription))
            }
            
        }
    }
    
    
    class func getMovieById(_id:Int,completion:@escaping (APIResult<[Specifications]>)->Void){
        MovieService.service.request(.getMovieById(id: _id)) { result in
            do{
                let movie:[Specifications] = try result.decoded(keypath: "results")
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

