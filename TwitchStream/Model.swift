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
    let videoHeight:Int
    let viewers:Int
    let game:String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case channel
        case preview
        case videoHeight = "video_height"
        case viewers
        case game
    }
}

struct TwitchChannel: Codable {
    let id: Int
    let status: String
    let url: URL
    let displayName: String
    let avatar:URL
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
        case url
        case displayName = "display_name"
        case avatar = "logo"
    }
}

struct VideoPreview: Codable {
    let largeURL: URL
    
    enum CodingKeys: String, CodingKey {
        case largeURL = "large"
    }
}



