//
//  ViewController.swift
//  TwitchStream
//
//  Created by Donny Apriliano on 22/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SafariServices

let twitchClientID = "j8zwslr2aq142h1iuzbiqi21pcv8m2"

class ViewController: ASViewController<ASDisplayNode> {
    
    var streams:[TwitchStreamsService.TwitchStream]

    var tableNode: ASTableNode {
        return node as! ASTableNode
    }
    
    init() {
        self.streams = []

        super.init(node: ASTableNode(style: .plain))
        tableNode.delegate = self
        tableNode.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Streams"
        
        loadStreams()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStreams() {
        let url = URL(string: "https://api.twitch.tv/kraken/streams")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        request.addValue(twitchClientID, forHTTPHeaderField: "Client-ID")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                do {
                    let streamService = try JSONDecoder().decode(TwitchStreamsService.self, from: data)
                    DispatchQueue.main.async {
                        self?.streams = streamService.streams
                        self?.tableNode.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
}

extension ViewController:ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        tableNode.deselectRow(at: indexPath, animated: true)
        
        let stream = streams[indexPath.row]
        if let url = URL(string: stream.channel.url) {
            let safari = SFSafariViewController(url: url)
            present(safari, animated: true, completion: nil)
        }
    }
}

extension ViewController:ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let stream = streams[indexPath.row]
        let nodeBlock:ASCellNodeBlock = {
            let streamCell = StreamCell(stream: stream)
            return streamCell
        }
        return nodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        
    }
}

