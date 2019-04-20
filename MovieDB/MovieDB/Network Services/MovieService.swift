//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case popularMovies(page:Int)
    case searchMovies(query: String, page: Int)
}

extension MovieService: TargetType {
    static let service = MoyaProvider<MovieService>()
    var baseURL: URL { return URL(string: APIConfiguration.baseURL)! }
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/movie/popular"
        case .searchMovies:
            return "/search/movie"
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .searchMovies, .popularMovies:
            return .get
        }
    }
        
    var task: Task {
        switch self {
        case .popularMovies(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case let .searchMovies(query, page):
            return .requestParameters(parameters: ["query": query, "page": page], encoding: URLEncoding.queryString)
        }
    }
 
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
