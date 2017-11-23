//
//  Model.swift
//  TwitchStream
//
//  Created by Donny Apriliano on 22/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import Foundation

struct TwitchStreamsService: Codable {
    let streams:[TwitchStream]
    
    struct TwitchStream: Codable {
        let _id: Int
        let channel:TwitchChannel
        let preview:VideoPreview
        
        struct TwitchChannel: Codable {
            let _id: Int
            let status: String
            let url: String
        }
        
        struct VideoPreview: Codable {
            let large: String
        }
    }
    
}
