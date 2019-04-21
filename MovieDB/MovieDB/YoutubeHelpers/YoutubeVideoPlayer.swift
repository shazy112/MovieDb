//
//  YoutubeVideoPlayer.swift
//  MovieDB
//
//  Created by Invision on 21/04/2019.
//  Copyright © 2019 Invision. All rights reserved.
//

import Foundation
import XCDYouTubeKit
import AVKit

class YoutubeVideoPlayer{
    
    class func setupStream(urls:[AnyHashable:URL])->URL?{
        return  (urls[YouTubeVideoQuality.hd720] ?? urls[YouTubeVideoQuality.medium360] ?? urls[YouTubeVideoQuality.small240])
    }
    
    class func playVideoWith(identifier:String?,vc:UIViewController){
        
        let playerViewController = AVPlayerViewController()
        vc.present(playerViewController, animated: true, completion: nil)
        
        XCDYouTubeClient.default().getVideoWithIdentifier(identifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
            
            if error != nil {
                vc.dismiss(animated: true, completion: nil)
                vc.showAlert(message: error?.localizedDescription ?? "")
            }
            else {
                if let streamURLs = video?.streamURLs {
                    if let _stream = setupStream(urls: streamURLs){
                        playerViewController?.player = AVPlayer(url: _stream)
                        
                    }
                } else {
                    vc.dismiss(animated: true, completion: nil)
                }}
        }
    }
}
