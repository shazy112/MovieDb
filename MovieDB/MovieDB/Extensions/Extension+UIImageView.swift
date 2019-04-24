//
//  PopularMoviesDataSource.swift
//  MovieDB
//
//  Created by Invision on 20/04/2019.
//  Copyright © 2019 Shiraz Ahmed. All rights reserved.
//
import Foundation
import UIKit
import SDWebImage

/**
 Parameter : URL
 
 -returns: image.
 */
extension UIImageView{
    
    func setImage(url:URL?){
        if let url = url{
            self.sd_setShowActivityIndicatorView(true)
            self.sd_setIndicatorStyle(.gray)
            self.sd_setImage(with: url) {[unowned self] (img, error, cacheType, url) in
                self.sd_setShowActivityIndicatorView(false)}
        }
    }
}
