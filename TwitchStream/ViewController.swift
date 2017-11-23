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

class ViewController: ASViewController<ASDisplayNode> {
    
    let viewModel:StreamsViewModel = StreamsViewModel()

    var tableNode: ASTableNode {
        return node as! ASTableNode
    }
    
    init() {

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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchNewBatch(context: ASBatchContext?) {
        viewModel.loadStreams { [weak self] newStreamsCount in
            self?.insertRows(newStreamsCount: newStreamsCount)
            context?.completeBatchFetching(true)
        }
    }
    
    func insertRows(newStreamsCount: Int) {
        let indexRange = (viewModel.streams.count - newStreamsCount..<viewModel.streams.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        tableNode.insertRows(at: indexPaths, with: .none)
    }
}

extension ViewController:ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        tableNode.deselectRow(at: indexPath, animated: true)
        
        let stream = viewModel.streams[indexPath.row]
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
        return viewModel.streams.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let stream = viewModel.streams[indexPath.row]
        let nodeBlock:ASCellNodeBlock = {
            let streamCell = StreamCell(stream: stream)
            return streamCell
        }
        return nodeBlock
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatch(context: context)
    }
}

