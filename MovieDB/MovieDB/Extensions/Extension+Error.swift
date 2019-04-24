//
//  Extension+Error.swift
//  MainPlug
//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//
import Foundation
import Moya
/**
 Extension of Moya error class that gets the error and returns string from response that is contained in a message key.
 */
extension Error{
    var customDescription:String{
        get{
            if let error = self as? MoyaError, let response = error.response, let json = try? response.mapJSON() as? [String: Any], let message = json?["message"] as? String{
                return message
            }
            return localizedDescription
        }
    }
}
