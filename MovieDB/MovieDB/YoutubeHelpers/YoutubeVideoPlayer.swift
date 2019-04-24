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
    
    /**
     Plays video for any youtube identifier
     */
    
    class func setupStream(urls:[AnyHashable:URL])->URL?{
        /**
         returns a url from [AnyHashable:URL] according to whatever youtube quality is availble to play the video
         */
        return  (urls[YouTubeVideoQuality.hd720] ?? urls[YouTubeVideoQuality.medium360] ?? urls[YouTubeVideoQuality.small240])
    }
    
    class func playVideoWith(identifier:String?,vc:UIViewController){
        /**
         Parameters : YoutubeIdentifer as string
         UIviewcontroller on which we have to pressent the youtube trailer
         */
        
        //Initializing AVPlayerController so we can pass url to play the video
        let playerViewController = AVPlayerViewController()
        vc.present(playerViewController, animated: true, completion: nil)
        
        XCDYouTubeClient.default().getVideoWithIdentifier(identifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
            //Dismissing the pressented vc and showing error on the detail screen
            if let error = error {
                vc.dismiss(animated: true, completion: nil)
                vc.showAlert(message: error.localizedDescription)
            }
            else {
                // passing the converted url to avplayer
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
