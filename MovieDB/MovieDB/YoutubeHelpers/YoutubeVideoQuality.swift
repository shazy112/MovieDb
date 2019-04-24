//
//  YoutubeVideoQuality.swift
//  MovieDB
//
//  Created by Invision on 21/04/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import Foundation
import XCDYouTubeKit
/**
 Struct for youtube video quality
 */
struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}
