//
//  StreamsViewModel.swift
//  TwitchStream
//
//  Created by Taufik Obet on 23/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import Foundation
import AsyncDisplayKit

let twitchClientID = "j8zwslr2aq142h1iuzbiqi21pcv8m2"

class StreamsViewModel {
    var streams:[TwitchStreamsService.TwitchStream] = []
    
    private var fetchInProgress:Bool = false
    
    func loadStreams(completionHandler:@escaping (Int)->()) {
        
        if fetchInProgress { return }
        
        fetchInProgress = true
        fetchNewStreamBatch { [weak self] (newStreamCount) in
            self?.fetchInProgress = false
            completionHandler(newStreamCount)
        }
    }
    
    func fetchNewStreamBatch(completionHandler:@escaping (Int)->()) {
        var urlString = "https://api.twitch.tv/kraken/streams"
        if streams.count > 0 {
            urlString = "https://api.twitch.tv/kraken/streams?offset=\(streams.count)"
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        request.addValue(twitchClientID, forHTTPHeaderField: "Client-ID")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                do {
                    let streamService = try JSONDecoder().decode(TwitchStreamsService.self, from: data)
                    DispatchQueue.main.async {
                        let streams = streamService.streams
                        self?.streams.append(contentsOf: streams)
                        completionHandler(streams.count)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        
        task.resume()
        
    }
    
}
