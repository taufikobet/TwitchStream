//
//  ViewController.swift
//  TwitchStream
//
//  Created by Donny Apriliano on 22/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import UIKit

let twitchClientID = "j8zwslr2aq142h1iuzbiqi21pcv8m2"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadStreams()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStreams() {
        let url = URL(string: "https://api.twitch.tv/helix/streams")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(twitchClientID, forHTTPHeaderField: "Client-ID")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let streams = try JSONDecoder().decode(TwitchStreamsService.self, from: data)
                    print(streams)
                } catch let error {
                    print(error)
                }
            }
        }
        
        task.resume()
    }


}

