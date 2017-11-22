//
//  ViewController.swift
//  TwitchStream
//
//  Created by Donny Apriliano on 22/11/17.
//  Copyright © 2017 spacetimecorp. All rights reserved.
//

import UIKit
import AsyncDisplayKit

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
        
        setupTableNode()
        loadStreams()
    }
    
    func setupTableNode() {
        tableNode.view.allowsSelection = false
        //tableNode.view.separatorStyle = .none
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
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                do {
                    let streams = try JSONDecoder().decode(TwitchStreamsService.self, from: data)
                    print(streams)
                    DispatchQueue.main.async {
                        self?.streams = streams.data
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
    
}

extension ViewController:ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let stream = streams[indexPath.row]
        let textNode = ASTextCellNode()
        textNode.text = stream.title
        return textNode
    }
}

