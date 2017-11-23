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
    
}

struct TwitchStream: Codable {
    let id: Int
    let channel:TwitchChannel
    let preview:VideoPreview
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case channel
        case preview
    }
}

struct TwitchChannel: Codable {
    let id: Int
    let status: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
        case url
    }
}

struct VideoPreview: Codable {
    let largeURL: URL
    
    enum CodingKeys: String, CodingKey {
        case largeURL = "large"
    }
}



