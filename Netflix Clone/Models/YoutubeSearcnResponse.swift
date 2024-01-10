//
//  YoutubeSearcnResponse.swift
//  Netflix Clone
//
//  Created by Abdulla Ahmad on 1/9/24.
//

import Foundation


struct YoutubeSearcnResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: VideoElementID
}

struct VideoElementID: Codable {
    let channelId: String?
    let kind: String
    let videoId: String?
}



/*
 items =     (
             {
         etag = "wZMPZ9XGgQM5ykifJdt9_-Co4ok";
         id =             {
             channelId = "UC8fwExOkHg0_fX_XJcR31NA";
             kind = "youtube#channel";
         };
         kind = "youtube#searchResult";
     },

 */
