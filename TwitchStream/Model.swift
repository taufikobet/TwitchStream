//
//  Model.swift
//  TwitchStream
//
//  Created by Donny Apriliano on 22/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import Foundation

struct TwitchStreamsService: Codable {
    let data:[TwitchStream]
    let pagination:TwitchPagination
    
    struct TwitchStream: Codable {
        let id: String
        let user_id: String
        let game_id: String
        let type: String
        let title: String
        let viewer_count: Int
        let started_at: String
        let language: String
        let thumbnail_url: String
    }
    
    struct TwitchPagination: Codable {
        let cursor: String
    }
}
