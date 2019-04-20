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
                let timeline:PopularMovies = try result.decoded()
                if timeline.totalPages != nil && _page <= timeline.totalPages ?? 0{
                    completion(.success(timeline))}
            }
            catch{
                completion(.failure(error.customDescription))
            }
            
        }
    }
}

