//
//  SetupGenres.swift
//  MovieDB
//
//  Created by Invision on 21/04/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import Foundation
class SetGenres{
    class func value(genres:[Genre],selectedMovieGenres:[Int]?)->String{
        var value = ""
        for i in selectedMovieGenres ?? []{
            let _ = genres.compactMap{
                if $0.id == i{
                    value.append("\($0.name),")}
            }
        }
        return String(value.dropLast())
    }
}
